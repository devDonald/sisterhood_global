import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/chats/data/chats_model.dart';
import 'package:sisterhood_global/features/community/data/message.dart';
import 'package:sisterhood_global/features/notification/notification_type.dart';

class FirebaseApi {
  static Future uploadMessage(
      String messageContent,
      String postId,
      String senderId,
      ownerId,
      category,
      question,
      senderPhoto,
      senderName) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    DocumentReference _docRef =
        communityRef.doc(postId).collection('comments').doc();
    final newMessage = Message(
      chatType: 'text',
      postId: postId,
      date: formatted,
      time: DateFormat.jm().format(DateTime.now()),
      isPhoto: false,
      isRecorded: false,
      isPinned: false,
      seen: false,
      visible: true,
      commentId: _docRef.id,
      senderId: senderId,
      photo: senderPhoto,
      createdAt: createdAt,
      userName: senderName,
      messageContent: messageContent,
      timestamp: DateTime.now().toUtc(),
    );
    await _docRef.set(newMessage.toJson()).then((value) async {
      await communityRef.doc(postId).update({'comments.${_docRef.id}': true});

      bool isNotPostOwner = auth.currentUser!.uid != ownerId;
      if (isNotPostOwner) {
        DocumentReference _docRef =
            root.collection('feed').doc(ownerId).collection('feeds').doc();
        _docRef.set({
          "type": NotificationType.contributionComment,
          "userId": auth.currentUser!.uid,
          "seen": false,
          "commentData": messageContent,
          "discussion": question,
          "ownerId": ownerId,
          'category': category,
          "postId": _docRef.id,
          'createdAt': createdAt,
          "timestamp": timestamp,
          "username": senderName,
        });
      }
    });
  }

  static Future sendChat(
      String senderPhoto,
      String messageContent,
      String chatId,
      String senderId,
      String receiverId,
      String senderName) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    DocumentReference _docRef =
        chatsRef.doc(chatId).collection('messages').doc();
    final newMessage = ChatMessage(
      chatType: 'text',
      date: formatted,
      time: DateFormat.jm().format(DateTime.now()),
      isPhoto: false,
      isRecorded: false,
      isPinned: false,
      seen: false,
      visible: true,
      messageId: _docRef.id,
      receiverId: receiverId,
      senderId: senderId,
      photo: senderPhoto,
      createdAt: createdAt,
      senderName: senderName,
      messageContent: messageContent,
      timestamp: DateTime.now().toUtc(),
    );
    await _docRef.set(newMessage.toJson()).then((value) async {
      await usersRef.doc(senderId).collection("chats").doc(chatId).set({
        'time': DateFormat.jm().format(DateTime.now()),
        'date': formatted,
        'senderId': senderId,
        'otherPerson': receiverId,
        'timestamp': DateTime.now().toUtc(),
        'lastMessage': _docRef.id,
        'createdAt': createdAt,
        'chatId': chatId,
      });
      await usersRef.doc(receiverId).collection("chats").doc(chatId).set({
        'time': DateFormat.jm().format(DateTime.now()),
        'date': formatted,
        'senderId': senderId,
        'otherPerson': senderId,
        'createdAt': createdAt,
        'timestamp': DateTime.now().toUtc(),
        'lastMessage': _docRef.id,
        'chatId': chatId,
      });

      DocumentReference _docRef2 =
          root.collection('feed').doc(receiverId).collection('feeds').doc();
      await _docRef2.set({
        "type": NotificationType.chat,
        "userId": receiverId,
        "seen": false,
        "commentData": messageContent,
        "discussion": messageContent,
        "ownerId": senderId,
        'category': 'Chat',
        "postId": chatId,
        'createdAt': createdAt,
        "timestamp": timestamp,
        "username": senderName,
      });
    });
  }

  static Future sendYoutubeChat(
      String senderPhoto,
      String messageContent,
      String videoId,
      String senderId,
      String receiverId,
      String senderName) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    DocumentReference _docRef =
        talkRef.doc(videoId).collection('comments').doc();
    final newMessage = ChatMessage(
      chatType: 'text',
      date: formatted,
      time: DateFormat.jm().format(DateTime.now()),
      isPhoto: false,
      isRecorded: false,
      isPinned: false,
      seen: false,
      visible: true,
      messageId: _docRef.id,
      receiverId: receiverId,
      senderId: senderId,
      photo: senderPhoto,
      createdAt: createdAt,
      senderName: senderName,
      messageContent: messageContent,
      timestamp: DateTime.now().toUtc(),
    );
    await _docRef.set(newMessage.toJson()).then((value) async {
      await talkRef.doc(videoId).update({'comments.${_docRef.id}': true});
    });
  }
}
