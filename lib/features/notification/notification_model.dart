import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/contants.dart';
import '../../core/model/app_users_model.dart';

class NotificationModel {
  String? type;
  String? userId;
  String? ownerId;
  bool? seen;
  String? postId, createdAt, commentData;
  UserModel? user;

  NotificationModel({
    this.type,
    this.userId,
    this.ownerId,
    this.seen,
    this.postId,
    this.createdAt,
    this.user,
    this.commentData,
  });

  NotificationModel.fromSnapshot(DocumentSnapshot docs) {
    type = docs["type"];
    userId = docs["userId"];
    ownerId = docs["ownerId"];
    seen = docs["seen"];
    createdAt = docs['createdAt'];
    postId = docs["postId"];
    commentData = docs['commentData'];
  }

  Future<void> loadUser() async {
    DocumentSnapshot ds = await usersRef.doc(this.userId).get();
    if (ds != null) this.user = UserModel.fromSnapshot(ds);
  }
}
