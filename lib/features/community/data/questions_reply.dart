import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/widgets/linkify_text_widget.dart';
import 'package:sisterhood_global/core/widgets/other_widgets.dart';

import '../../../core/constants/contants.dart';
import '../../../core/widgets/profile_picture.dart';

class RecieverBox extends StatelessWidget {
  const RecieverBox({
    Key? key,
    required this.timeOfMessage,
    required this.messageContent,
    required this.commentId,
    required this.receiverId,
    required this.postId,
  }) : super(key: key);
  final String timeOfMessage, messageContent, commentId, postId, receiverId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 70.5,
        right: 13.9,
        bottom: 10.5,
      ),
      padding: const EdgeInsets.only(
        right: 11.5,
        left: 19.6,
        top: 5.5,
        bottom: 5.5,
      ),
      decoration: const BoxDecoration(
        color: Colors.white, //for now
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(0.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    timeOfMessage,
                    style: const TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              DeleteEditPopUp(
                delete: () async {
                  await communityRef
                      .doc(postId)
                      .collection('comments')
                      .doc(commentId)
                      .delete()
                      .then((value) {});
                  Navigator.of(context).pop();
                },
                isOwner: true,
                edit: () {},
                report: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          const SizedBox(height: 10.0),
          LinkifyTextWidget(messageContent: messageContent),
        ],
      ),
    );
  }
}

class SenderBox extends StatelessWidget {
  SenderBox({
    Key? key,
    required this.senderName,
    required this.senderPhoto,
    required this.messageContent,
    required this.timeOfMessage,
  }) : super(key: key);
  final String senderName, senderPhoto, timeOfMessage, messageContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 70.5,
        left: 13.9,
        top: 10.0,
        bottom: 10.5,
      ),
      padding: const EdgeInsets.only(
        right: 11.5,
        left: 19.6,
        top: 5.5,
        bottom: 5.5,
      ),
      decoration: const BoxDecoration(
        color: Colors.white, //for now
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ProfilePicture(
                    image: CachedNetworkImageProvider(
                      senderPhoto,
                    ),
                    width: 30.0,
                    height: 29.5,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    senderName,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    timeOfMessage,
                    style: const TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          LinkifyTextWidget(messageContent: messageContent),
        ],
      ),
    );
  }
}
