import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/widgets/follow_button.dart';
import 'package:sisterhood_global/features/profile/controller/follow_user_controller.dart';
import 'package:sisterhood_global/features/profile/pages/user_profile_info.dart';

import '../../../core/constants/contants.dart';
import '../../../core/model/app_users_model.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/flag_picker.dart';
import '../../../core/widgets/numbers_widget.dart';
import '../../authentication/pages/overview_biocard.dart';

class FollowUserScreen extends StatefulWidget {
  final String name, userId;
  const FollowUserScreen({Key? key, required this.name, required this.userId})
      : super(key: key);

  @override
  _FollowUserScreenState createState() => _FollowUserScreenState();
}

class _FollowUserScreenState extends State<FollowUserScreen> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
        backgroundColor: ThemeColors.whiteColor,
      ),
      body: RefreshIndicator(
        child: PaginateFirestore(
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 1,
          itemBuilder: (context, snapshot, index) {
            UserModel _user = UserModel.fromSnapshot(snapshot[index]);
            return Column(
              children: [
                UserProfileInfo(
                  isFollowing: _user.isFollowing!,
                  isOwner: _user.isOwner!,
                  profileImage: _user.photo!,
                  userId: _user.userId!,
                  country: _user.country!,
                  flag: FlagPicker(
                    flagCode: _user.code!,
                  ),
                  name: _user.name!,
                ),
                const SizedBox(height: 15),
                NumbersWidget(
                  nFollowers: _user.followers!,
                  nFollowing: _user.following!,
                  nPost: '${_user.posts!}',
                ),
                FollowButton(
                    isFollowing: _user.isFollowing!,
                    onFollow: () {
                      FollowController().followUser(
                          auth.currentUser!.uid,
                          _user.userId!,
                          _user.isFollowing!,
                          auth.currentUser!.displayName!);
                    }),
                OverViewBioCard(
                  marital: _user.marital!,
                  bio: _user.bio!,
                  email: _user.email!,
                  phone: "${_user.dialCode}${_user.phone}",
                  isOwner: _user.isOwner!,
                )
              ],
            );
          },
          // orderBy is compulsary to enable pagination
          query: usersRef.where('userId', isEqualTo: widget.userId),
          isLive: true,
          listeners: [
            refreshChangeListener,
          ],
          itemBuilderType: PaginateBuilderType.listView,
        ),
        onRefresh: () async {
          refreshChangeListener.refreshed = true;
        },
      ),
    );
  }

  Widget buildName(String name, String email) => Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
}
