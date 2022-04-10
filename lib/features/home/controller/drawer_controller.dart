import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../authentication/controller/auth_controller.dart';

class CusDrawerController extends GetxController {
  final AuthController authController = AuthController.to;
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
    authController.signOut();
  }
}
