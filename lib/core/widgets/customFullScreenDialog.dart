import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin CustomFullScreenDialog {
  static Future<void> showDialog() async {
    Get.dialog(
      WillPopScope(
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.pink),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.3),
      useSafeArea: true,
    );
  }

  static Future<void> cancelDialog() async {
    Get.back();
  }
}
