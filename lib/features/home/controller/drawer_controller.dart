import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';

class CusDrawerController extends GetxController {
  late User user;
  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    await auth.signOut();
  }
}
