import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';
import 'package:sisterhood_global/features/home/pages/home.dart';

import 'core/constants/contants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    startTime();
  }

//update firebase token for every user
  Future<bool> getUserLoginStatus() async {
    if (auth.currentUser != null) {
      _fcm.getToken().then((token) {
        // print("Firebase Messaging Token: $token\n");
        root
            .collection('users')
            .doc(auth.currentUser!.uid)
            .update({"token": token});
      });
      return true;
    } else {
      return false;
    }
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    bool isLoggedIn = await getUserLoginStatus();
    isLoggedIn
        ? Get.offAll(() => HomeScreen())
        : Get.offAll(() => LoginScreen());
  }

  // void initializePushNotification(BuildContext context) async {
  //   await pushNotification.intialise(context);
  // }
  @override
  Widget build(BuildContext context) {
    // initializePushNotification(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Hero(tag: 'logo', child: Image.asset('images/logo.png')),
              ),
            ],
          ),
        ));
  }
}
