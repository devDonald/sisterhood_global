import 'package:get/get.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';

import '../data/community_database.dart';

class CommunityController extends GetxController {
  Rx<List<CommunityModel>> communityList = Rx<List<CommunityModel>>([]);
  List<CommunityModel> get community => communityList.value;

  @override
  void onReady() {
    communityList.bindStream(CommunityDB.communityStream());
  }
}
