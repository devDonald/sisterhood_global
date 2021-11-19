import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseMessaging fcm = FirebaseMessaging.instance;
var usersRef = firebaseFirestore.collection('users');
const profilePHOTO =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6TaCLCqU4K0ieF27ayjl51NmitWaJAh_X0r1rLX4gMvOe0MDaYw&s';

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
    String dialCode, String code, String phone, String confirm_password) {
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
  } else if (password != confirm_password) {
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
) {
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

class Constants {
  Constants._();
  static const double padding = 10;
  static const double avatarRadius = 45;
}

String API_KEY = 'AIzaSyBwtUGqZTCqrko-e6KCo2S1bGQsraAkmOQ';
