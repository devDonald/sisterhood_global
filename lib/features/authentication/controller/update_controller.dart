// import 'package:get/get.dart';
//
// import '../../../core/constants/contants.dart';
//
// class UpdateController extends GetxController {
//   static UpdateController to = Get.find();
//   RxBool isAvailable = false.obs;
//
//   @override
//   void onReady() {
//     listenForUpdate();
//     super.onReady();
//   }
//
//   void listenForUpdate() {
//     updateRef.doc('new').get().then((ds) {
//       if (ds.exists) {
//         isAvailable = ds.data()!['isNew'];
//       }
//     });
//   }
// }
