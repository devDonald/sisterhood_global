import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';

class CreateQuestion extends StatefulWidget {
  static const String id = 'CreateQuestion';
  const CreateQuestion({Key? key}) : super(key: key);

  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  String _uploadedImageURL = '', error = '';
  String categoryOption = "";
  late ProgressDialog pr;
  bool profileImage = false;
  final _question = TextEditingController();

  void _uploadEvent() async {
    try {
      User? _currentUser = await FirebaseAuth.instance.currentUser;
      String uid = _currentUser!.uid;
      final CommunityModel model = CommunityModel(
        question: _question.text.trim(),
        category: categoryOption,
        ownerId: uid,
        comments: {},
        likes: {},
        createdAt: createdAt,
        timestamp: timestamp,
      );
      await CommunityDB.addContemplation(model);
      Navigator.of(context).pop();
    } catch (e) {}
    //bodyValue.clear();

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(message: 'Please wait, posting contemplation');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: JanguAskColors.primaryColor,
        elevation: 3.0,
        titleSpacing: -3.0,
        title: const Text(
          'Create Question',
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
              const PostLabel(label: 'What is on your mind?'),
              const SizedBox(height: 9.5),
              PostTextFeild(
                height: 70,
                isBorder: true,
                capitalization: TextCapitalization.sentences,
                hint: 'Type your contemplation or question',
                maxLines: 5, //fix
                textController: _question,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Category'),
              const SizedBox(height: 9.5),
              DropDown(
                items: questionCategory,
                hint: const Text("Select Category"),
                icon: const Icon(
                  Icons.expand_more,
                  color: Colors.pink,
                ),
                onChanged: (String? value) {
                  categoryOption = value!;
                  print('category: $categoryOption');
                },
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
                    if (validateQuestion(_question.text, categoryOption)) {
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
