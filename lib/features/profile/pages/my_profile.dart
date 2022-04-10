import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/features/profile/pages/user_profile_info.dart';

import '../../../core/constants/contants.dart';
import '../../../core/model/app_users_model.dart';
import '../../../core/widgets/flag_picker.dart';
import '../../../core/widgets/numbers_widget.dart';
import '../../authentication/pages/overview_biocard.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'My Profile',
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
            UserModel _user = UserModel.fromSnapshot(snapshot.single);
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
                  name: _user.name!.toUpperCase(),
                ),
                const SizedBox(height: 24),
                NumbersWidget(
                  nFollowers: _user.followers!,
                  nFollowing: _user.following!,
                  nPost: '${_user.posts!}',
                ),
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
          query: usersRef.where('userId', isEqualTo: auth.currentUser!.uid),
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
