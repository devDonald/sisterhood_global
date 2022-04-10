import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';

import '../../../core/widgets/add_photo_buttons.dart';

class CreateContribution extends StatefulWidget {
  final bool isAdmin;
  final String category;
  static const String id = 'CreateQuestion';
  const CreateContribution(
      {Key? key, required this.isAdmin, required this.category})
      : super(key: key);

  @override
  _CreateContributionState createState() => _CreateContributionState();
}

class _CreateContributionState extends State<CreateContribution> {
  String error = '';
  String categoryOption = "";
  late ProgressDialog pr;
  bool isPhotoAdded = false;
  final _question = TextEditingController();
  final FocusNode focusNode = FocusNode();

  clearPhoto() {
    setState(() {
      pickedImage = null;
      isPhotoAdded = false;
    });
  }

  File? pickedImage;
  final _picker = ImagePicker();
  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery

    var image = await _picker.pickImage(source: source);

    //Cropping the image

    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      pickedImage = croppedFile;
      isPhotoAdded = true;
      //print(pickedImage!.lengthSync());
    });
  }

  void _uploadEvent() async {
    try {
      User? _currentUser = FirebaseAuth.instance.currentUser;
      String uid = _currentUser!.uid;
      String? url;

      if (pickedImage != null) {
        pr.show();
        url = await CommunityDB().uploadFile(pickedImage!);
      }
      final CommunityModel model = CommunityModel(
        body: _question.text.trim(),
        category: categoryOption,
        ownerId: uid,
        imageLink: url ?? '',
        comments: {},
        likes: {},
        isApproved: widget.isAdmin ? true : false,
        isPinned: widget.isAdmin ? true : false,
        createdAt: createdAt,
        timestamp: timestamp,
      );
      await CommunityDB.addContemplation(model);

      pr.hide();
      Navigator.of(context).pop();
    } catch (e) {}
    //bodyValue.clear();
  }

  @override
  void initState() {
    categoryOption = widget.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(message: 'Please wait, sending post');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 3.0,
        titleSpacing: -3.0,
        title: const Text(
          'Contribute to Community',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(25.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Icon(Icons.people_outline_sharp),
                  const SizedBox(width: 8),
                  DropDown(
                    showUnderline: true,
                    initialValue: widget.category,
                    items: questionCategory,
                    hint: const Text("Select Category"),
                    icon: const Icon(
                      Icons.expand_more,
                      color: Colors.pink,
                    ),
                    onChanged: (String? value) {
                      categoryOption = value!;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Post Something'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                enableSuggestions: true,
                focusNode: focusNode,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                minLines: 1,
                maxLines: 10, //fix
                controller: _question,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AddPhotoWidget(
                      onClearTap: () {
                        clearPhoto();
                      },
                      isPhotoAdded: isPhotoAdded,
                      onAddImageTap: () async {
                        getImageFile(
                          ImageSource.gallery,
                        );
                      },
                      fileImage: pickedImage == null
                          ? Container()
                          : Image.file(
                              pickedImage!,
                            ),
                    ),
                    const SizedBox(width: 20),
                    PrimaryButton(
                      width: 81.5,
                      height: 36.5,
                      blurRadius: 3.0,
                      roundedEdge: 5.0,
                      color: ThemeColors.primaryColor,
                      buttonTitle: 'Post',
                      onTap: () {
                        if (validateQuestion(_question.text, categoryOption)) {
                          _uploadEvent();
                        }
                      },
                    ),
                  ],
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
    return SizedBox(
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
