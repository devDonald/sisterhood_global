import 'package:flutter/material.dart';

import '../../../core/themes/theme_colors.dart';

class DiscussionTextField extends StatelessWidget {
  const DiscussionTextField(
      {Key? key,
      this.onChanged,
      required this.sendMessage,
      this.discussionFocusNode,
      this.discussionController,
      this.isTyping = false})
      : super(key: key);
  final Function() sendMessage;
  final Function(String)? onChanged;
  final FocusNode? discussionFocusNode;
  final TextEditingController? discussionController;
  final bool isTyping;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 7.5,
            offset: Offset(0.0, 2.5),
            color: ThemeColors.shadowColor,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Button send image

          // Edit text
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 16, top: 9, bottom: 9, right: 16),
              child: TextFormField(
                maxLines: 4,
                minLines: 1,
                // onTap: getTextKeyBoard,
                onChanged: onChanged,
                textInputAction: TextInputAction.newline,
                autofocus: false,
                focusNode: discussionFocusNode,
                controller: discussionController,
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
                decoration: const InputDecoration.collapsed(
                  hintText: 'New Message...',
                  hintStyle: TextStyle(color: Color(0xff8e8e8e)),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: sendMessage,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColors.primaryColor,
              ),
              margin: const EdgeInsets.only(right: 10, left: 5),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.send,
                size: 25,
                color: ThemeColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
