import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/theme.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseFirestore root = FirebaseFirestore.instance;

final Timestamp timestamp = Timestamp.fromDate(DateTime.now());
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseMessaging fcm = FirebaseMessaging.instance;
var usersRef = firebaseFirestore.collection('users');
var feedRef = firebaseFirestore.collection('feed');
var reportRef = firebaseFirestore.collection('reports');

var eventsRef = firebaseFirestore.collection('events');
var communityRef = firebaseFirestore.collection('community');
var chatsRef = firebaseFirestore.collection('chats');
var talkRef = firebaseFirestore.collection('talks');
CustomTheme currentTheme = CustomTheme();

const profilePHOTO =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6TaCLCqU4K0ieF27ayjl51NmitWaJAh_X0r1rLX4gMvOe0MDaYw&s';
const adminId = 'LNXzA3WdsrNuXs4PBNLiiBQkypF2';

successToastMessage({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

errorToastMessage({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

warningToastMessage({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow,
      textColor: Colors.white,
      fontSize: 16.0);
}

bool validateForm(String email, String name, String password, String country,
    String dialCode, String code, String phone, String confirmPassword) {
  if (email.isEmpty) {
    errorToastMessage(msg: 'email cannot be empty');
    return false;
  } else if (!email.contains('.')) {
    errorToastMessage(msg: 'invalid email id');
    return false;
  } else if (!email.contains('@')) {
    errorToastMessage(msg: 'invalid email id, @ is missing');
    return false;
  } else if (name.isEmpty) {
    errorToastMessage(msg: 'name cannot be empty');
    return false;
  } else if (country.isEmpty) {
    errorToastMessage(msg: 'country not selected');
    return false;
  } else if (phone.isEmpty) {
    errorToastMessage(msg: 'phone number cannot be empty');
    return false;
  } else if (code.isEmpty) {
    errorToastMessage(msg: 'country code is empty, please select again');
    return false;
  } else if (password.isEmpty || password.length < 8) {
    errorToastMessage(msg: 'provide a password with 8 or more characters');
    return false;
  } else if (password != confirmPassword) {
    errorToastMessage(msg: 'password mismatch');
    return false;
  } else {
    return true;
  }
}

bool validateProfileEdit(
  String email,
  String name,
  String country,
  String dialCode,
  String code,
  String phone,
  String bio,
) {
  if (email.isEmpty) {
    errorToastMessage(msg: 'email cannot be empty');
    return false;
  } else if (!email.contains('.')) {
    errorToastMessage(msg: 'invalid email id');
    return false;
  } else if (bio.isEmpty) {
    errorToastMessage(msg: 'Bio Cannot be Empty');
    return false;
  } else if (!email.contains('@')) {
    errorToastMessage(msg: 'invalid email id, @ is missing');
    return false;
  } else if (name.isEmpty) {
    errorToastMessage(msg: 'name cannot be empty');
    return false;
  } else if (country.isEmpty) {
    errorToastMessage(msg: 'country not selected');
    return false;
  } else if (phone.isEmpty) {
    errorToastMessage(msg: 'phone number cannot be empty');
    return false;
  } else if (code.isEmpty) {
    errorToastMessage(msg: 'country code is empty, please select again');
    return false;
  } else {
    return true;
  }
}

bool validateLogin(String email, String password) {
  if (email.isEmpty) {
    errorToastMessage(msg: 'email cannot be empty');
    return false;
  } else if (!email.contains('.')) {
    errorToastMessage(msg: 'invalid email id');
    return false;
  } else if (!email.contains('@')) {
    errorToastMessage(msg: 'invalid email id');
    return false;
  } else if (password.isEmpty || password.length < 8) {
    errorToastMessage(msg: 'provide a password with 8 or more characters');
    return false;
  } else {
    return true;
  }
}

bool validateEmail(String email) {
  if (email.isEmpty) {
    errorToastMessage(msg: 'email cannot be empty');
    return false;
  } else if (!email.contains('.')) {
    errorToastMessage(msg: 'invalid email id');
    return false;
  } else if (!email.contains('@')) {
    errorToastMessage(msg: 'invalid email id');
    return false;
  } else {
    return true;
  }
}

bool validateEvent(
  String title,
  String description,
  String date,
  String venue,
  String photoUrl,
) {
  if (title.isEmpty) {
    errorToastMessage(msg: 'title of event cannot be empty');
    return false;
  } else if (description.isEmpty) {
    errorToastMessage(msg: 'description of event cannot be empty');
    return false;
  } else if (date.isEmpty) {
    errorToastMessage(msg: 'date of event cannot be empty');
    return false;
  } else if (venue.isEmpty) {
    errorToastMessage(msg: 'venue of event cannot be empty');
    return false;
  } else if (photoUrl.isEmpty) {
    errorToastMessage(msg: 'You did not pick an image, try again');
    return false;
  } else {
    return true;
  }
}

bool validateQuestion(
  String body,
  String category,
) {
  if (body.isEmpty) {
    errorToastMessage(msg: 'your thoughts cannot be empty');
    return false;
  } else if (category.isEmpty) {
    errorToastMessage(msg: 'category cannot be empty');
    return false;
  } else {
    return true;
  }
}

bool validateTalk(
  String title,
  String id,
) {
  if (title.isEmpty) {
    errorToastMessage(msg: 'Video Title cannot be Empty');
    return false;
  } else if (id.isEmpty) {
    errorToastMessage(msg: 'Video ID cannot be empty');
    return false;
  } else {
    return true;
  }
}

class Constants {
  Constants._();
  static const double padding = 10;
  static const double avatarRadius = 45;
}

const APIKEY = 'AIzaSyBwtUGqZTCqrko-e6KCo2S1bGQsraAkmOQ';

List<String> eventTypes = ["Video Event", "Picture Event"];
List<String> questionCategory = ["Community", "Agree With Me", "Testimony"];

final createdAt = DateTime.now().toUtc().toString();

int getLikeCount(likes) {
  // if no likes, return 0
  if (likes == null) {
    return 0;
  }
  int count = 0;
  // if the key is explicitly set to true, add a like
  likes.values.forEach((val) {
    if (val == true) {
      count += 1;
    }
  });
  return count;
}

int getViews(views) {
  // if no likes, return 0
  if (views == null) {
    return 0;
  }
  int count = 0;
  // if the key is explicitly set to true, add a like
  views.values.forEach((val) {
    if (val == true) {
      count += 1;
    }
  });
  return count;
}

String getCount(int count) {
  String _stPosts = "0";
  double _dbPosts = 0.0;

  if (count < 1000) {
    _stPosts = count.toString() + " ";
  } else if (count >= 1000 && count < 1000000) {
    _dbPosts = count / 1000;
    _stPosts = _dbPosts.toStringAsFixed(1) + "K";
  } else if (count >= 1000000 && count < 1000000000) {
    _dbPosts = count / 1000000;
    _stPosts = _dbPosts.toStringAsFixed(1) + "M";
  } else {
    _dbPosts = count / 1000000000;
    _stPosts = _dbPosts.toStringAsFixed(1) + "B";
  }
  return _stPosts;
}

int getCommentCount(comments) {
  // if no likes, return 0
  if (comments == null) {
    return 0;
  }
  int count = 0;
  // if the key is explicitly set to true, add a like
  comments.values.forEach((val) {
    if (val == true) {
      count += 1;
    }
  });
  return count;
}

int getFollowingCount(comments) {
  // if no likes, return 0
  if (comments == null) {
    return 0;
  }
  int count = 0;
  // if the key is explicitly set to true, add a like
  comments.values.forEach((val) {
    count += 1;
  });
  return count;
}

String getTimestamp(String date) {
  String msg = '';
  var dt = DateTime.parse(date).toLocal();

  if (DateTime.now().toLocal().isBefore(dt)) {
    return DateFormat.jm().format(DateTime.parse(date).toLocal()).toString();
  }

  var dur = DateTime.now().toLocal().difference(dt);
  if (dur.inDays > 0) {
    msg = '${dur.inDays} days ago';
    return dur.inDays == 1 ? '1d ago' : DateFormat("dd MMM").format(dt);
  } else if (dur.inHours > 0) {
    msg = '${dur.inHours} hrs ago';
  } else if (dur.inMinutes > 0) {
    msg = '${dur.inMinutes} m ago';
  } else if (dur.inSeconds > 0) {
    msg = '${dur.inSeconds} s ago';
  } else {
    msg = 'now';
  }
  return msg;
}

DateTime? toDateTime(Timestamp value) {
  return value.toDate();
}

dynamic fromDateTimeToJson(DateTime date) {
  return date.toUtc();
}

showDownloadProgress(received, total) {
  if (total != -1) {
    //print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

Future download2(Dio dio, String url, String savePath) async {
  try {
    Response response = await dio.get(
      url,
      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    //print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
  } catch (e) {
    //print(e);
  }
}

Future<void> onOpen(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}

const style = TextStyle(
  color: Colors.red,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  height: 1.375,
);
