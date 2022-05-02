import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/app_bar_icon_button.dart';
import 'package:sisterhood_global/features/profile/pages/follow_user_screen.dart';

import '../../../core/model/app_users_model.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/other_widgets.dart';
import '../../profile/controller/follow_user_controller.dart';

class PeopleSearch extends StatefulWidget {
  const PeopleSearch({
    Key? key,
  }) : super(key: key);

  @override
  _PeopleSearchState createState() => _PeopleSearchState();
}

class _PeopleSearchState extends State<PeopleSearch> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  String filter = '';
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool searchBar = false;

  PreferredSizeWidget buildSearchAppBar() {
    setState(() {
      searchBar = true;
    });
    return AppBar(
      backgroundColor: ThemeColors.primaryColor,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            searchBar = false;
          });
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          hintText: 'Search Users',
          suffixIcon: GestureDetector(
            onTap: () {
              searchController.clear();
            },
            child: const Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    searchFocus.requestFocus();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar
          ? buildSearchAppBar()
          : AppBar(
              title: const Text('Follow Members',
                  style: TextStyle(color: Colors.white)),
              iconTheme: const IconThemeData(color: Colors.white, size: 35),
              backgroundColor: ThemeColors.pink.shade400,
              titleSpacing: -5,
              actions: [
                AppBarButtonIcon(
                  icon: const Icon(
                    Icons.search,
                    color: ThemeColors.whiteColor,
                  ),
                  onTap: () {
                    buildSearchAppBar();
                  },
                ),
              ],
              // elevation: 2.0,
            ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ThemeColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.shadowColor,
              blurRadius: 5,
              offset: Offset(0, 2.5),
            ),
          ],
        ),
        child: RefreshIndicator(
          child: PaginateFirestore(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemsPerPage: 50,
            itemBuilder: (context, snapshot, index) {
              UserModel _users = UserModel.fromSnapshot(snapshot[index]);
              if (!_users.isOwner!) {
                return filter == ""
                    ? UserSearchFollow(
                        isFollowing: _users.isFollowing,
                        userName: _users.name!.toUpperCase(),
                        country: _users.country,
                        profileImage: _users.photo,
                        onTap: () {
                          Get.to(() => FollowUserScreen(
                              name: _users.name!, userId: _users.userId!));
                        },
                        onFollow: () {
                          FollowController().followUser(
                              auth.currentUser!.uid,
                              _users.userId!,
                              _users.isFollowing!,
                              auth.currentUser!.displayName!);
                        },
                      )
                    : '${_users.name}'
                            .toLowerCase()
                            .contains(filter.toLowerCase())
                        ? UserSearchFollow(
                            isFollowing: _users.isFollowing,
                            userName: _users.name,
                            country: _users.country,
                            profileImage: _users.photo,
                            onTap: () {
                              Get.to(() => FollowUserScreen(
                                  name: _users.name!, userId: _users.userId!));
                            },
                            onFollow: () {
                              FollowController().followUser(
                                  auth.currentUser!.uid,
                                  _users.userId!,
                                  _users.isFollowing!,
                                  auth.currentUser!.displayName!);
                            },
                          )
                        : Container();
              } else {
                return Container();
              }
            },
            // orderBy is compulsary to enable pagination
            query: usersRef.orderBy('name', descending: false),
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
      ),
    );
  }
}
