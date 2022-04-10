import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/contants.dart';

class UserModel {
  static const USERID = "userId";
  static const NAME = "name";
  static const EMAIL = "email";
  static const COUNTRY = "country";
  static const PHOTO = "photo";
  static const PHONE = "phone";
  static const CODE = "code";
  static const TYPE = "type";
  static const DIALCODE = "dialCode";
  static const ISADMIN = "isAdmin";

  String? userId;
  String? name;
  String? country;
  String? photo;
  String? email;
  String? phone;
  String? code;
  String? type, marital;
  String? dialCode;
  bool? isAdmin = false;
  String? followers;
  String? following, bio;
  int? posts;
  dynamic followersList;
  dynamic followingList;
  bool? isFollower = false, isFollowing = false, isOwner = false;

  UserModel(
      {this.userId,
      this.name,
      this.country,
      this.photo,
      this.email,
      this.phone,
      this.code,
      this.dialCode,
      this.type,
      this.isAdmin,
      this.followers,
      this.followersList,
      this.following,
      this.followingList,
      this.isFollower,
      this.isOwner,
      this.bio,
      this.marital,
      this.posts});

  toJson() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'country': country,
      'photo': photo,
      'code': code,
      'isAdmin': isAdmin,
      'dialCode': dialCode,
      'phone': phone,
      'token': '',
      'type': type,
      'bio': bio,
      'posts': posts,
      'marital': marital,
      'followersList': followersList,
      'followingList': followingList,
    };
  }

  updateUser() {
    return {
      "email": email,
      'name': name,
      'country': country,
      'code': code,
      'dialCode': dialCode,
      'phone': phone,
    };
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    country = snapshot[COUNTRY];
    photo = snapshot[PHOTO];
    userId = snapshot[USERID];
    phone = snapshot[PHONE];
    code = snapshot[CODE];
    dialCode = snapshot[DIALCODE];
    type = snapshot[TYPE];
    bio = snapshot['bio'];
    marital = snapshot['marital'];
    isAdmin = snapshot[ISADMIN];
    posts = snapshot['posts'];
    followingList = snapshot['followingList'];
    followersList = snapshot['followersList'];

    if (snapshot['followingList'] != null) {
      following = getCount(getLikeCount(followingList));
    }
    if (snapshot['followersList'] != null) {
      followers = getCount(getCommentCount(followersList));
    }

    if (followersList[auth.currentUser!.uid] == true) {
      isFollowing = true;
    }
    if (followingList[auth.currentUser!.uid] == true) {
      isFollower = true;
    }
    if (auth.currentUser!.uid == snapshot['userId']) {
      isOwner = true;
    }
  }
}
