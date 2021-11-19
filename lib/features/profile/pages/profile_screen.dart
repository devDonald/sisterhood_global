import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/flag_picker.dart';
import 'package:sisterhood_global/features/authentication/pages/overview_biocard.dart';
import 'package:sisterhood_global/features/profile/pages/user_profile_info.dart';

import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  Future<void> choiceAction(String choice) async {
    if (choice == ProfileMenuItem.EditProfile) {
      Get.to(() => EditProfile());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text(
                'My Profile',
                style: TextStyle(
                  color: JanguAskColors.primaryColor,
                  fontSize: 20,
                ),
              ),
              pinned: true,
              floating: true,
              iconTheme: IconThemeData(color: JanguAskColors.primaryGreyColor),
              actions: [
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return ProfileMenuItem.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
              backgroundColor: JanguAskColors.whiteColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    RefreshIndicator(
                      child: PaginateFirestore(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemsPerPage: 1,
                        itemBuilder: (index, context, snapshot) {
                          UserModel _user = UserModel.fromSnapshot(snapshot);
                          return UserProfileInfo(
                            profileImage: _user.photo!,
                            userId: _user.userId!,
                            country: _user.country!,
                            flag: FlagPicker(
                              flagCode: _user.code!,
                            ),
                            name: _user.name!,
                            phone: '',
                            email: '',
                          );
                        },
                        // orderBy is compulsary to enable pagination
                        query: usersRef.where('userId',
                            isEqualTo: auth.currentUser!.uid),
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
                  ],
                ),
              ),
              expandedHeight: MediaQuery.of(context).size.height / 2,
            )
          ];
        },
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: usersRef
                    .where('userId', isEqualTo: auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot snap = snapshot.data!.docs[index];
                          return OverViewBioCard(
                            name: snap['name'],
                            country: snap['country'],
                            gender: "Female",
                            email: snap['email'],
                            phone: '${snap['dialCode']}${snap['phone']}',
                          );
                        });
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem {
  static const String EditProfile = 'Edit Profile';

  static const List<String> choices = <String>[EditProfile];
}
