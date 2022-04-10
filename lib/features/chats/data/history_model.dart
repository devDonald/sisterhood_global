import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/features/chats/data/chats_model.dart';

import '../../../core/constants/contants.dart';

class HistoryModel {
  String? date;
  String? userPhoto, userName;
  String? time, otherPerson, senderId;
  String? lastMessage, chatId;
  DateTime? timestamp;
  UserModel? user;
  ChatMessage? lastChat;

  HistoryModel(
      {this.date,
      this.userPhoto,
      this.userName,
      this.time,
      this.otherPerson,
      this.senderId,
      this.lastMessage,
      this.chatId,
      this.user,
      this.lastChat,
      this.timestamp});

  HistoryModel.fromSnapshot(DocumentSnapshot json) {
    senderId = json['senderId'];
    date = json['date'];
    time = json['time'];
    lastMessage = json['lastMessage'];
    chatId = json['chatId'];
    otherPerson = json['otherPerson'];
    timestamp = toDateTime(json['timestamp']);
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'date': date,
        'time': time,
        'timestamp': fromDateTimeToJson(timestamp!),
      };

  Future<void> loadUser() async {
    DocumentSnapshot ds = await usersRef.doc(otherPerson).get();
    if (ds != null) {
      user = UserModel.fromSnapshot(ds);
      userName = user!.name;
      userPhoto = user!.photo;
    }
  }

  Future<void> loadLastChat() async {
    DocumentSnapshot ds = await chatsRef
        .doc(chatId)
        .collection('messages')
        .doc(lastMessage)
        .get();
    if (ds != null) {
      lastChat = ChatMessage.fromSnapshot(ds);
    }
  }
}
