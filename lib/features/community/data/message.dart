import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';

class MessageField {
  static final String messageContent = 'messageContent';
  static final String timestamp = 'timestamp';
}

class Message {
  final String? senderId, chatType, postId, date, receiverName;
  final String? photo;
  final String? userName, time;
  final String? messageContent, commentId, createdAt;
  final DateTime? timestamp;
  final bool? isPhoto, isPinned, isRecorded, seen, visible;

  const Message(
      {this.senderId,
      this.chatType,
      this.postId,
      this.date,
      this.receiverName,
      this.photo,
      this.userName,
      this.time,
      this.messageContent,
      this.commentId,
      this.timestamp,
      this.isPhoto,
      this.isPinned,
      this.isRecorded,
      this.seen,
      this.visible,
      this.createdAt});

  static Message fromJson(Map<String, dynamic> json) => Message(
        senderId: json['senderId'],
        chatType: json['chatType'],
        postId: json['receiverId'],
        date: json['date'],
        receiverName: json['receiverName'],
        time: json['time'],
        isPhoto: json['isPhoto'],
        isPinned: json['isPinned'],
        isRecorded: json['isRecorded'],
        seen: json['seen'],
        visible: json['visible'],
        commentId: json['messageId'],
        photo: json['photo'],
        userName: json['userName'],
        messageContent: json['messageContent'],
        createdAt: json['createdAt'],
        timestamp: toDateTime(json['timestamp']),
      );
  static Message fromSnapshot(DocumentSnapshot json) => Message(
        senderId: json['senderId'],
        chatType: json['chatType'],
        postId: json['receiverId'],
        date: json['date'],
        receiverName: json['receiverName'],
        time: json['time'],
        isPhoto: json['isPhoto'],
        isPinned: json['isPinned'],
        isRecorded: json['isRecorded'],
        seen: json['seen'],
        visible: json['visible'],
        commentId: json['messageId'],
        photo: json['photo'],
        createdAt: json['createdAt'],
        userName: json['userName'],
        messageContent: json['messageContent'],
        timestamp: toDateTime(json['timestamp']),
      );

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'photo': photo,
        'chatType': chatType,
        'date': date,
        'receiverName': receiverName,
        'time': time,
        'isPhoto': isPhoto,
        'isPinned': isPinned,
        'receiverId': postId,
        'isRecorded': isRecorded,
        'seen': seen,
        'visible': visible,
        'messageId': commentId,
        'userName': userName,
        'createdAt': createdAt,
        'messageContent': messageContent,
        'timestamp': fromDateTimeToJson(timestamp!),
      };
}
