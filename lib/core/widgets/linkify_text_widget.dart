import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import '../constants/contants.dart';
import '../constants/hastag_linkifier.dart';
import '../constants/phone_number_linkify.dart';
import '../constants/usertag_linkify.dart';

class LinkifyTextWidget extends StatelessWidget {
  final String messageContent;
  final int? maxLength;
  final ScrollPhysics? scroll;
  const LinkifyTextWidget(
      {Key? key, required this.messageContent, this.maxLength, this.scroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableLinkify(
      maxLines: maxLength,
      onOpen: onOpen,
      linkifiers: const [
        EmailLinkifier(),
        UrlLinkifier(),
        UserTagLinkifier(),
        HashtagLinkifier(),
        PhoneLinkifier()
      ],
      text: messageContent,
      scrollPhysics: scroll,
      style: const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black87),
      linkStyle: const TextStyle(color: Colors.blue),
    );
  }
}
