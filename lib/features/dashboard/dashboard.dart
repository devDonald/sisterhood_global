import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/community/pages/community_home.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/videos.dart';
import 'package:sisterhood_global/features/messages/pages/message_list.dart';
import 'package:sisterhood_global/features/search/pages/sisterhood_users_search.dart';

import '../home/pages/home.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeScreen(),
                CommunityHome(),
                //const CommunityHome(),
                const Videos(),
                const MessageList(),
                const PeopleSearch()
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
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
                icon: CupertinoIcons.videocam,
                label: 'Videos',
              ),
              _bottomNavigationBarItem(
                icon: Icons.message,
                label: 'Messages',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.search_circle,
                label: 'Search',
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
