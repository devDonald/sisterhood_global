import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';

class CommunityModel {
  String? question, category, ownerId, postId;
  dynamic comments, likes;
  String? createdAt, ownerName, ownerPhoto, likeCount, commentCount;
  Timestamp? timestamp;
  UserModel? user;
  bool likeToCard = false, isOwner = false;

  CommunityModel(
      {this.question,
      this.category,
      this.ownerId,
      this.postId,
      this.comments,
      this.likes,
      this.createdAt,
      this.user,
      this.timestamp});

  toJson() {
    return {
      "ownerId": ownerId,
      "postId": postId,
      "category": category,
      "question": question,
      "comments": comments,
      "createdAt": createdAt,
      "likes": likes,
      "timestamp": timestamp,
    };
  }

  communityUpdate() {
    return {
      "category": category,
      "question": question,
    };
  }

  CommunityModel.fromSnapshot({required DocumentSnapshot snap}) {
    question = snap['question'];
    category = snap['category'];
    ownerId = snap['ownerId'];
    postId = snap['postId'];
    comments = snap['comments'];
    createdAt = snap['createdAt'];
    timestamp = snap['timestamp'];
    likes = snap['likes'];

    if (snap['likes'] != null) {
      likeCount = getCount(getLikeCount(likes));
    }
    if (snap['comments'] != null) {
      commentCount = getCount(getCommentCount(comments));
    }

    if (likes[auth.currentUser!.uid] == true) {
      likeToCard = true;
    }
    if (auth.currentUser!.uid == snap['ownerId']) {
      isOwner = true;
    }
  }

  Future<void> loadUser() async {
    DocumentSnapshot ds = await usersRef.doc(ownerId).get();

    user = UserModel.fromSnapshot(ds);
    ownerName = user!.name;
    ownerPhoto = user!.photo;
  }
}
