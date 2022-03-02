import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/files_widgets.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/notification/notification_type.dart';

class CreateEvent extends StatefulWidget {
  static const String id = 'CreateEvent';
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  String _uploadedImageURL = '', error = '', _date = '';
  String _eventType = 'Picture Event';
  late ProgressDialog pr;
  bool profileImage = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _venue = TextEditingController();

  File? pickedImage;

  final _picker = ImagePicker();
  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery

    var image = await _picker.getImage(source: source);

    //Cropping the image

    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      maxWidth: 1024,
      maxHeight: 4096,
    );

    setState(() {
      pickedImage = croppedFile!;
      print(pickedImage!.lengthSync());
    });
  }

  void _uploadEvent() async {
    try {
      User? _currentUser = FirebaseAuth.instance.currentUser;
      String uid = _currentUser!.uid;
      if (pickedImage != null) {
        pr.show();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('events/$uid/${Path.basename(pickedImage!.path)}}');
        UploadTask uploadTask = storageReference.putFile(pickedImage!);
        await uploadTask;
        print('File Uploaded');
        storageReference.getDownloadURL().then((fileURL) {
          _uploadedImageURL = fileURL;
          DocumentReference _docRef = eventsRef.doc();
          _docRef.set({
            'title': _title.text,
            'description': _description.text,
            'likes': {},
            'postId': _docRef.id,
            'comments': {},
            'date': _date,
            'venue': _venue.text,
            'createdAt': createdAt,
            'imageUrl': _uploadedImageURL,
            'timestamp': timestamp,
          }).then((doc) async {
            pr.hide();
            Fluttertoast.showToast(
                msg: "Event created successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            await usersRef.get().then((value) {});
            var result = await usersRef.get();
            result.docs.forEach((res) {
              CommunityDB.sendGeneralNotification(
                  _docRef.id,
                  res.id,
                  _description.text,
                  'Admin',
                  "Event",
                  NotificationType.event,
                  _title.text);
            });
            Navigator.of(context).pop();
          }).catchError((onError) async {
            pr.hide();
            Fluttertoast.showToast(
                msg: "Event Creation Failed",
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
    //bodyValue.clear();
    setState(() {
      pickedImage = null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(message: 'Please wait, Uploading Event');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: JanguAskColors.primaryColor,
        elevation: 3.0,
        titleSpacing: -3.0,
        title: const Text(
          'Create Event',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0.0, 2.5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PostLabel(label: 'Event Title'),
              const SizedBox(height: 9.5),
              PostTextFeild(
                height: 70,
                isBorder: true,
                capitalization: TextCapitalization.sentences,
                hint: 'Type in the Title',
                maxLines: 5, //fix
                textController: _title,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Event Description'),
              const SizedBox(height: 9.5),
              PostTextFeild(
                height: 200,
                isBorder: true,
                capitalization: TextCapitalization.sentences,
                hint: 'Type event description here',
                maxLines: 5, //fix
                textController: _description,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Event Date'),
              const SizedBox(height: 9.5),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2021, 3, 5),
                      maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                    print('change $date');
                    _date = '${date.day}-${date.month}-${date.year}';
                  }, onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.day}-${date.month}-${date.year}';
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: const Text('Pick Event Date',
                    style: TextStyle(
                      color: JanguAskColors.primaryColor,
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                    )),
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Event Venue'),
              const SizedBox(height: 9.5),
              PostTextFeild(
                isBorder: true,
                capitalization: TextCapitalization.sentences,
                hint: 'Type event venue here',
                maxLines: 2, //fix
                textController: _venue, height: 70,
              ),
              const SizedBox(height: 16.5),
              const SizedBox(height: 16.5),
              if (_eventType == 'Picture Event')
                DiscussOutlineButton(
                  onTap: () {
                    getImageFile(ImageSource.gallery);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Add Photo',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                      Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              else
                Container(),
              const SizedBox(height: 16.5),
              pickedImage != null
                  ? const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Image Picked',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  : const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Image empty',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
              const SizedBox(height: 16.5),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  width: 81.5,
                  height: 36.5,
                  blurRadius: 3.0,
                  roundedEdge: 5.0,
                  color: Colors.pink,
                  buttonTitle: 'Post',
                  onTap: () {
                    if (validateEvent(_title.text, _description.text, _date,
                        _venue.text, pickedImage!.path)) {
                      _uploadEvent();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostTextFeild extends StatelessWidget {
  const PostTextFeild(
      {Key? key,
      required this.hint,
      required this.height,
      required this.maxLines,
      required this.textController,
      required bool isBorder,
      required this.capitalization})
      : super(key: key);
  final String hint;
  final double height;
  final int maxLines;
  final TextEditingController textController;
  final TextCapitalization capitalization;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        maxLines: maxLines,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        controller: textController,
      ),
    );
  }
}

class PostLabel extends StatelessWidget {
  const PostLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
