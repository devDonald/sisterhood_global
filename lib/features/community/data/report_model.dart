import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';

class ReportModel {
  String? reportTitle,
      userId,
      ownerName,
      ownerId,
      postId,
      reportId,
      reportDetails;
  String? createdAt, reportActions, status, actionsTaken, reporterName;
  Timestamp? timestamp;
  UserModel? user;

  ReportModel({
    this.reportTitle,
    this.userId,
    this.ownerId,
    this.postId,
    this.createdAt,
    this.user,
    this.timestamp,
    this.reportId,
    this.status,
    this.actionsTaken,
    this.reportActions,
    this.reportDetails,
    this.ownerName,
    this.reporterName,
  });

  toJson() {
    return {
      "ownerId": ownerId,
      "postId": postId,
      "userId": userId,
      "reportTitle": reportTitle,
      "createdAt": createdAt,
      "reportId": reportId,
      "reportActions": reportActions,
      "actionsTaken": actionsTaken,
      "status": status,
      "reportDetails": reportDetails,
      "timestamp": timestamp,
      "ownerName": ownerName,
      "reporterName": reporterName,
    };
  }

  ReportModel.fromSnapshot({required DocumentSnapshot snap}) {
    reportTitle = snap['reportTitle'];
    userId = snap['userId'];
    ownerId = snap['ownerId'];
    postId = snap['postId'];
    createdAt = snap['createdAt'];
    timestamp = snap['timestamp'];
    reportId = snap['reportId'];
    status = snap['status'];
    reportActions = snap['reportActions'];
    actionsTaken = snap['actionsTaken'];
    reportDetails = snap['reportDetails'];
    ownerName = snap['ownerName'];
    reporterName = snap['reporterName'];
  }

  Future<void> loadUser() async {
    DocumentSnapshot ds = await usersRef.doc(ownerId).get();
    user = UserModel.fromSnapshot(ds);
  }
}
