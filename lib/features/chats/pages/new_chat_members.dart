import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/core/widgets/other_widgets.dart';
import 'package:sisterhood_global/features/chats/pages/chat_screen.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/app_bar_icon_button.dart';

class NewChatMembers extends StatefulWidget {
  const NewChatMembers({Key? key}) : super(key: key);

  @override
  _CreateGroupChatState createState() => _CreateGroupChatState();
}

class _CreateGroupChatState extends State<NewChatMembers> {
  final _groupSearchController = TextEditingController();
  bool searchBar = false;

  PreferredSizeWidget buildSearchAppBar() {
    setState(() {
      searchBar = true;
    });
    return AppBar(
      backgroundColor: ThemeColors.pink.shade400,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            searchBar = false;
          });
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: TextField(
        controller: _groupSearchController,
        decoration: InputDecoration(
          hintText: 'Search User',
          hintStyle: const TextStyle(color: ThemeColors.whiteColor),
          suffixIcon: GestureDetector(
            onTap: () {
              _groupSearchController.clear();
            },
            child: const Icon(
              Icons.close,
              color: ThemeColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  String filter = '';

  @override
  initState() {
    _groupSearchController.addListener(() {
      if (mounted) {
        setState(() {
          filter = _groupSearchController.text;
        });
      }
      print('Filter: $filter');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar
          ? buildSearchAppBar()
          : AppBar(
              backgroundColor: ThemeColors.pink.shade400,
              titleSpacing: -5,
              title: const Text(
                'New Chat',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: ThemeColors.whiteColor,
                ),
              ),
              actions: [
                AppBarButtonIcon(
                  icon: const Icon(Icons.search),
                  onTap: () {
                    buildSearchAppBar();
                  },
                ),
              ],
              // elevation: 2.0,
            ),
      body: RefreshIndicator(
        child: PaginateFirestore(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 50,
          itemBuilder: (context, snapshot, index) {
            UserModel _users = UserModel.fromSnapshot(snapshot[index]);
            if (_users.isFollowing! || _users.isFollower!) {
              return filter == ""
                  ? UserSearchTile(
                      userName: _users.name!.toUpperCase(),
                      profileImage: _users.photo!,
                      country: _users.country!,
                      onTap: () {
                        Get.to(() => ChatScreen(
                            receiverId: _users.userId!,
                            senderId: auth.currentUser!.uid,
                            receiverName: _users.name!.toUpperCase(),
                            receiverPhoto: _users.photo!,
                            chatId:
                                '${auth.currentUser!.uid}${_users.userId}'));
                      },
                    )
                  : '${_users.name}'
                          .toLowerCase()
                          .contains(filter.toLowerCase())
                      ? UserSearchTile(
                          userName: _users.name!.toUpperCase(),
                          profileImage: _users.photo!,
                          country: _users.country!,
                          onTap: () async {
                            Get.to(() => ChatScreen(
                                receiverId: _users.userId!,
                                senderId: auth.currentUser!.uid,
                                receiverName: _users.name!.toUpperCase(),
                                receiverPhoto: _users.photo!,
                                chatId:
                                    '${auth.currentUser!.uid}${_users.userId}'));
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
    );
  }
}
