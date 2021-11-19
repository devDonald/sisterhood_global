import 'package:get/get.dart';
import 'package:sisterhood_global/features/authentication/controller/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
