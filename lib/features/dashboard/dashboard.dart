import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/community/pages/community_home.dart';
import 'package:sisterhood_global/features/community/pages/prayer_wall_home.dart';
import 'package:sisterhood_global/features/notification/general_notification.dart';

import '../chats/pages/message_list.dart';
import '../home/pages/home.dart';
import 'dashboard_controller.dart';
import 'menu_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  // String? name, email, photo, uid;
  //
  // getStorage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     photo = prefs.getString('photo');
  //     name = prefs.getString('name');
  //     uid = prefs.getString('uid');
  //     email = prefs.getString('email');
  //   });
  // }

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                HomeScreen(),
                CommunityHome(),
                PrayerWallHome(),
                MessageList(),
                NotificationHome(),
                MenuDrawer(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black87,
            selectedItemColor: Colors.pink,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.group,
                label: 'Community',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.book,
                label: 'Prayer Wall',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.chat_bubble_2,
                label: 'Messages',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.bell,
                label: 'Notification',
              ),
              _bottomNavigationBarItem(
                icon: Icons.menu,
                label: 'More',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
