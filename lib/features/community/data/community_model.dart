import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';

class CommunityModel {
  String? body, category, ownerId, postId, imageLink, videoLink;
  dynamic comments, likes;
  String? createdAt, ownerName, ownerPhoto, likeCount, commentCount;
  Timestamp? timestamp;
  UserModel? user;
  bool? likeToCard = false,
      isOwner = false,
      isPinned = false,
      isApproved = false,
      withImage = false;

  CommunityModel({
    this.body,
    this.category,
    this.ownerId,
    this.postId,
    this.comments,
    this.likes,
    this.createdAt,
    this.user,
    this.timestamp,
    this.imageLink,
    this.videoLink,
    this.isApproved,
    this.isPinned,
  });

  toJson() {
    return {
      "ownerId": ownerId,
      "postId": postId,
      "category": category,
      "body": body,
      "comments": comments,
      "createdAt": createdAt,
      "likes": likes,
      "imageLink": imageLink,
      "videoLink": videoLink,
      "isApproved": isApproved,
      "isPinned": isPinned,
      "timestamp": timestamp,
    };
  }

  communityUpdate() {
    return {
      "category": category,
      "body": body,
    };
  }

  CommunityModel.fromSnapshot({required DocumentSnapshot snap}) {
    body = snap['body'];
    category = snap['category'];
    ownerId = snap['ownerId'];
    postId = snap['postId'];
    comments = snap['comments'];
    createdAt = snap['createdAt'];
    timestamp = snap['timestamp'];
    likes = snap['likes'];
    imageLink = snap['imageLink'];
    videoLink = snap['videoLink'];
    isApproved = snap['isApproved'];
    isPinned = snap['isPinned'];

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

    if (imageLink!.isNotEmpty) {
      withImage = true;
    }
  }

  Future<void> loadUser() async {
    DocumentSnapshot ds = await usersRef.doc(ownerId).get();

    user = UserModel.fromSnapshot(ds);
    ownerName = user!.name;
    ownerPhoto = user!.photo;
  }
}
