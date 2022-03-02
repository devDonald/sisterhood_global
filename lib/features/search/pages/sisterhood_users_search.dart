import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/profile/pages/follow_user_screen.dart';

import '../../../core/model/app_users_model.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/menu_drawer.dart';
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
      drawer: MenuDrawer(),
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: JanguAskColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: JanguAskColors.shadowColor,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: JanguAskColors.whiteColor, //5
                        ),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          textCapitalization: TextCapitalization.sentences,
                          focusNode: searchFocus,
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search,
                                color: JanguAskColors.primaryGreyColor),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchController.clear();
                              },
                              child: const Icon(Icons.close,
                                  color: JanguAskColors.primaryGreyColor),
                            ),
                            border: InputBorder.none,
                            hintText: 'Search for People',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(100),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: JanguAskColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: JanguAskColors.shadowColor,
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
