import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';
import 'package:sisterhood_global/core/widgets/customFullScreenDialog.dart';
import 'package:sisterhood_global/core/widgets/vertical_divider.dart';

class UserProfileInfo extends StatefulWidget {
  const UserProfileInfo({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.country,
    required this.flag,
    required this.userId,
    required this.isOwner,
    required this.isFollowing,
  }) : super(key: key);
  final String name, profileImage, country, userId;
  final Widget flag;
  final bool isOwner, isFollowing;

  @override
  State<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  late File pickedImage;

  late String _uploadedImageURL;

  final _picker = ImagePicker();
  ImageCropper? imageCropper;

  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery

    var image = await _picker.getImage(source: source);

    //Cropping the image

    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      pickedImage = croppedFile!;
      print(pickedImage.lengthSync());
    });
  }

  Future<void> sendImage() async {
    try {
      User? _currentUser = await FirebaseAuth.instance.currentUser;
      String uid = _currentUser!.uid;
      if (pickedImage != null) {
        CustomFullScreenDialog.showDialog();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile/$uid/${Path.basename(pickedImage.path)}}');
        UploadTask uploadTask = storageReference.putFile(pickedImage);
        await uploadTask;
        print('profile pics Uploaded');
        storageReference.getDownloadURL().then((fileURL) async {
          _uploadedImageURL = fileURL;
          DocumentReference _docRef = usersRef.doc(uid);
          await _docRef.update({
            'photo': _uploadedImageURL,
          }).then((doc) async {
            CustomFullScreenDialog.cancelDialog();
            Fluttertoast.showToast(
                msg: "photo successfully updated",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }).catchError((onError) async {
            CustomFullScreenDialog.cancelDialog();
            Fluttertoast.showToast(
                msg: onError.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Stack(fit: StackFit.loose, children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                CachedNetworkImageProvider(widget.profileImage),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ],
                ),
                widget.isOwner
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 100.0, right: 100.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                await getImageFile(ImageSource.gallery);
                                sendImage();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ))
                    : Container(),
              ]),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: JanguAskFontWeight.kBoldText,
                    fontSize: 23,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: widget.flag,
                  ),
                  Text(
                    widget.country,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff333333),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  !widget.isOwner && widget.isFollowing
                      ? Row(
                          children: const [
                            VertDivider(),
                            Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff333333),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
