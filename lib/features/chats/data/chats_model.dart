import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/contants.dart';

class ChatMessage {
  String? senderId, chatType, date;
  String? photo;
  String? senderName, time, receiverId;
  String? messageContent, messageId, createdAt;
  DateTime? timestamp;
  bool? isPhoto, isPinned, isRecorded, seen, visible;

  ChatMessage({
    this.senderId,
    this.chatType,
    this.date,
    this.photo,
    this.senderName,
    this.time,
    this.messageContent,
    this.messageId,
    this.timestamp,
    this.isPhoto,
    this.isPinned,
    this.isRecorded,
    this.seen,
    this.visible,
    this.receiverId,
    this.createdAt,
  });

  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
        senderId: json['senderId'],
        chatType: json['chatType'],
        date: json['date'],
        time: json['time'],
        isPhoto: json['isPhoto'],
        isPinned: json['isPinned'],
        isRecorded: json['isRecorded'],
        seen: json['seen'],
        visible: json['visible'],
        messageId: json['messageId'],
        photo: json['photo'],
        senderName: json['senderName'],
        messageContent: json['messageContent'],
        receiverId: json['receiverId'],
        createdAt: json['createdAt'],
        timestamp: toDateTime(json['timestamp']),
      );
  ChatMessage.fromSnapshot(DocumentSnapshot json) {
    senderId = json['senderId'];
    chatType = json['chatType'];
    date = json['date'];
    time = json['time'];
    isPhoto = json['isPhoto'];
    isPinned = json['isPinned'];
    isRecorded = json['isRecorded'];
    seen = json['seen'];
    visible = json['visible'];
    messageId = json['messageId'];
    photo = json['photo'];
    senderName = json['senderName'];
    messageContent = json['messageContent'];
    receiverId = json['receiverId'];
    createdAt = json['createdAt'];
    timestamp = toDateTime(json['timestamp']);
  }

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'photo': photo,
        'chatType': chatType,
        'date': date,
        'time': time,
        'isPhoto': isPhoto,
        'isPinned': isPinned,
        'isRecorded': isRecorded,
        'seen': seen,
        'visible': visible,
        'createdAt': createdAt,
        'messageId': messageId,
        'senderName': senderName,
        'receiverId': receiverId,
        'messageContent': messageContent,
        'timestamp': fromDateTimeToJson(timestamp!),
      };
}
