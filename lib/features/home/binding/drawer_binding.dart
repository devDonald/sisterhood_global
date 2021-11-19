import 'package:get/get.dart';
import 'package:sisterhood_global/features/home/controller/drawer_controller.dart';

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CusDrawerController>(CusDrawerController());
  }
}
