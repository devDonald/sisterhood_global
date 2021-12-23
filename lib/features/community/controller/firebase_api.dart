import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/community/data/message.dart';

class FirebaseApi {
  static Future uploadMessage(String senderPhoto, String messageContent,
      String postId, String fromUid, String senderName, ownerId) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    DocumentReference _docRef =
        communityRef.doc(postId).collection('comments').doc();
    final newMessage = Message(
      chatType: 'text',
      postId: postId,
      date: formatted,
      time: "${new DateFormat.jm().format(new DateTime.now())}",
      isPhoto: false,
      isRecorded: false,
      isPinned: false,
      seen: false,
      visible: true,
      commentId: _docRef.id,
      senderId: fromUid,
      photo: senderPhoto,
      userName: senderName,
      messageContent: messageContent,
      timestamp: DateTime.now().toUtc(),
    );
    await _docRef.set(newMessage.toJson()).then((value) async {
      await communityRef.doc(postId).update({'comments.${_docRef.id}': true});

      bool isNotPostOwner = auth.currentUser!.uid != ownerId;
      if (isNotPostOwner) {
        root.collection('feed').doc(ownerId).collection('feeds').doc(postId).set({
          "type": "discussComment",
          "userId": auth.currentUser!.uid,
          "seen": false,
          "commentData": messageContent,
          "data": messageContent,
          "ownerId": ownerId,
          "postId": postId,
          'createdAt': createdAt,
          "timestamp": timestamp,
          "username": senderName,
        });
      }
    });
  }
}
