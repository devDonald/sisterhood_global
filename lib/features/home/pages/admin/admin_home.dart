import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:sisterhood_global/core/constants/device_util.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/features/home/pages/admin/events_home.dart';
import 'package:sisterhood_global/features/home/pages/admin/manage_community_post.dart';
import 'package:sisterhood_global/features/home/pages/admin/talk_list.dart';
import 'package:sisterhood_global/features/home/pages/admin/users_report.dart';
import 'package:sisterhood_global/features/home/pages/admin/youtube_notication.dart';

import 'all_users.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool isAdmin = false, isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  late String _uid;

  @override
  void initState() {
    super.initState();
    //checkInGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: ThemeColors.whiteColor,
        title: Text(
          'Admin Section',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme:
            const IconThemeData(color: ThemeColors.blackColor1, size: 35),
        titleSpacing: 15.0,
      ),
      body: GridView(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
            crossAxisCount: 2),
        children: [
          HomeCard(
            icon: Icons.live_tv,
            title: 'Livestream Notification',
            onTap: () {
              Get.to(() => const LivestreamNotification());
            },
          ),
          HomeCard(
            icon: Icons.event_available,
            title: 'Events',
            onTap: () {
              Get.to(() => EventHome());
            },
          ),
          HomeCard(
            icon: Icons.people,
            title: 'Manage Users',
            onTap: () async {
              Get.to(() => DisplayUsers());
            },
          ),
          HomeCard(
            icon: Icons.post_add,
            title: 'Manage Posts',
            onTap: () async {
              Get.to(() => AdminCommunityHome());
            },
          ),
          HomeCard(
            icon: Icons.report,
            title: 'User Reports',
            onTap: () async {
              Get.to(() => const UsersReports());
            },
          ),
          HomeCard(
            icon: Icons.live_tv,
            title: 'Let\'s Talk About It',
            onTap: () async {
              Get.to(() => const TalkListHome());
            },
          )
        ],
      ),
    );
  }
}

class ButtonWithICon2 extends StatelessWidget {
  const ButtonWithICon2({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 149,
      height: 40.0,
      margin: const EdgeInsets.only(
        top: 8.5,
        bottom: 8.5,
      ),
      padding: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: ThemeColors.shadowColor,
            offset: Offset(0.0, 2.5),
            blurRadius: 7.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: ThemeColors.whiteColor,
            ),
            const SizedBox(width: 9.2),
            Text(
              title,
              style: const TextStyle(
                color: ThemeColors.whiteColor,
                fontSize: 15.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.42,
          height: MediaQuery.of(context).size.height * 0.20,
          margin: const EdgeInsets.only(
              top: 17.5, bottom: 5.0, left: 15.0, right: 7.0),
          //padding: EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: ThemeColors.whiteColor,
                offset: Offset(0.0, 2.5),
                blurRadius: 10.5,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: ThemeColors.primaryColor,
                  size: 35.0,
                ),
              ],
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class HomeCard1 extends StatelessWidget {
  const HomeCard1({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: width * 0.38,
          height: height * 0.16,
          margin: const EdgeInsets.only(
              top: 17.5, bottom: 5.0, left: 20.0, right: 20.0),
          //padding: EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: ThemeColors.whiteColor,
                offset: Offset(0.0, 2.5),
                blurRadius: 10.5,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: ThemeColors.whiteColor,
                  size: DeviceUtil.isTablet ? 60 : 35,
                ),
              ],
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
