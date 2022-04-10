import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';

class TalkModel {
  String? videoId, videoTitle;
  dynamic comments, likes;
  String? createdAt, ownerName, likeCount, commentCount;
  Timestamp? timestamp;
  UserModel? user;
  bool? likeToCard = false, isOwner = false, isLive = false, isApproved = false;

  TalkModel({
    this.videoId,
    this.videoTitle,
    this.comments,
    this.likes,
    this.createdAt,
    this.user,
    this.timestamp,
    this.isApproved,
    this.isLive,
  });

  toJson() {
    return {
      "videoTitle": videoTitle,
      "videoId": videoId,
      "comments": comments,
      "createdAt": createdAt,
      "likes": likes,
      "isApproved": isApproved,
      "isLive": isLive,
      "timestamp": timestamp,
    };
  }

  TalkModel.fromSnapshot({required DocumentSnapshot snap}) {
    videoId = snap['videoId'];
    videoTitle = snap['videoTitle'];
    comments = snap['comments'];
    createdAt = snap['createdAt'];
    timestamp = snap['timestamp'];
    likes = snap['likes'];
    isApproved = snap['isApproved'];
    isLive = snap['isLive'];

    if (snap['likes'] != null) {
      likeCount = getCount(getLikeCount(likes));
    }
    if (snap['comments'] != null) {
      commentCount = getCount(getCommentCount(comments));
    }

    if (likes[auth.currentUser!.uid] == true) {
      likeToCard = true;
    }
  }
}
