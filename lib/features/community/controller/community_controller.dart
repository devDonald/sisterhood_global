import 'package:get/get.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';

class CommunityController extends GetxController {
  final Rx<CommunityModel> _communityModel = CommunityModel().obs;

  CommunityModel get communityPost => _communityModel.value;

  set communityPost(CommunityModel value) => _communityModel.value = value;

  void clear() {
    _communityModel.value = CommunityModel();
  }
}
