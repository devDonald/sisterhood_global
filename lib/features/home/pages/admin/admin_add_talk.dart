import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';

import '../../data/talk_model.dart';

class PostTalkAdmin extends StatefulWidget {
  static const String id = 'PostTalkAdmin';
  const PostTalkAdmin({Key? key}) : super(key: key);

  @override
  _PostTalkAdminState createState() => _PostTalkAdminState();
}

class _PostTalkAdminState extends State<PostTalkAdmin> {
  String error = '';
  late ProgressDialog pr;
  final _videoId = TextEditingController();
  final _videoTitle = TextEditingController();

  final FocusNode focusNode = FocusNode();

  void _uploadTalk() async {
    try {
      pr.show();
      final TalkModel model = TalkModel(
        videoId: _videoId.text.trim(),
        videoTitle: _videoTitle.text.trim(),
        comments: {},
        likes: {},
        isApproved: true,
        isLive: true,
        createdAt: createdAt,
        timestamp: timestamp,
      );
      await CommunityDB.addTalk(model);

      pr.hide();
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
    pr.style(message: 'Please wait, Posting Talk Link');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 3.0,
        titleSpacing: -3.0,
        title: const Text(
          'Let\'s Talk About it Video',
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
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Video Title'),
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
                maxLines: 2, //fix
                controller: _videoTitle,
              ),
              const SizedBox(height: 16.5),
              const PostLabel(label: 'Video ID'),
              const SizedBox(height: 9.5),
              TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: true,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                minLines: 1,
                maxLines: 2, //fix
                controller: _videoId,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: PrimaryButton(
                  width: 81.5,
                  height: 36.5,
                  blurRadius: 3.0,
                  roundedEdge: 5.0,
                  color: Colors.pink,
                  buttonTitle: 'Post Talk',
                  onTap: () {
                    if (validateTalk(_videoTitle.text, _videoId.text)) {
                      _uploadTalk();
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
