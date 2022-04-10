import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/widgets/linkify_text_widget.dart';
import 'package:sisterhood_global/core/widgets/other_widgets.dart';

import '../../../core/constants/contants.dart';
import '../../../core/widgets/profile_picture.dart';

class ReceiverChatBox extends StatelessWidget {
  const ReceiverChatBox({
    Key? key,
    required this.timeOfMessage,
    required this.messageContent,
    required this.chatId,
    required this.receiverId,
    required this.postId,
  }) : super(key: key);
  final String timeOfMessage, messageContent, chatId, postId, receiverId;

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
                  // await communityRef
                  //     .doc(postId)
                  //     .collection('comments')
                  //     .doc(commentId)
                  //     .delete()
                  //     .then((value) {});
                  // Navigator.of(context).pop();
                  Get.defaultDialog(
                    title: 'Delete Chat',
                    middleText:
                        'Chat will be deleted for you and the Receiver ',
                    barrierDismissible: false,
                    radius: 25,
                    cancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Get.back();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                        )),
                    confirm: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () async {
                          chatsRef
                              .doc(postId)
                              .collection('messages')
                              .doc(chatId)
                              .delete();
                          Get.back();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Continue')),
                  );
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

class SenderChatBox extends StatelessWidget {
  const SenderChatBox({
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
