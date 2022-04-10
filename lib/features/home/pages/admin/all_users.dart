import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/core/widgets/other_widgets.dart';

import '../../../profile/pages/follow_user_screen.dart';

class DisplayUsers extends StatefulWidget {
  DisplayUsers({Key? key}) : super(key: key);

  @override
  _DisplayUsersState createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  late String filter;
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

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
  void dispose() {
    searchFocus.dispose();
    //searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                          flex: 2,
                          child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })),
                      const Flexible(
                        flex: 8,
                        child: Text(
                          'All Members',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white, //5
                    ),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 20),
                      textCapitalization: TextCapitalization.sentences,
                      focusNode: searchFocus,
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            searchController.clear();
                          },
                          child: const Icon(Icons.close, color: Colors.red),
                        ),
                        border: InputBorder.none,
                        hintText: 'Search by Name',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(115),
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
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
                return filter == ""
                    ? UserSearchTile(
                        userName: _users.name!,
                        profileImage: _users.photo!,
                        onTap: () {
                          Get.to(() => FollowUserScreen(
                              name: _users.name!, userId: _users.userId!));
                        },
                        country: _users.country!,
                      )
                    : '${_users.name}'
                            .toLowerCase()
                            .contains(filter.toLowerCase())
                        ? UserSearchTile(
                            country: _users.country!,
                            userName: _users.name!,
                            profileImage: _users.photo!,
                            onTap: () {
                              Get.to(() => FollowUserScreen(
                                  name: _users.name!, userId: _users.userId!));
                            },
                          )
                        : Container();
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
        ));
    // body: Container(
    //   child: StreamBuilder<QuerySnapshot>(
  }
}
