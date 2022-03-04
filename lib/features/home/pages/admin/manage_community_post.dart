import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/home/pages/admin/approved_posts.dart';
import 'package:sisterhood_global/features/home/pages/admin/unpproved_posts.dart';

import '../../../community/pages/create_contribution.dart';
import 'admin_pinned_posts.dart';

class AdminCommunityHome extends StatefulWidget {
  static const String id = 'Search';

  AdminCommunityHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _AdminCommunityHomeState();
  }
}

class _AdminCommunityHomeState extends State<AdminCommunityHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Approved'),
    Tab(text: 'Unapproved'),
    Tab(text: 'Pinned'),
  ];
  @override
  initState() {
    _tabController = TabController(
      length: commTabs.length,
      initialIndex: 0,
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Community Post Verification'),
          backgroundColor: Colors.pink,
          bottom: TabBar(
            controller: _tabController,
            tabs: commTabs,
          )),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ApprovedPosts(),
          UnApprovedPosts(),
          AdminPinnedPosts()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const CreateContribution(
                isAdmin: true,
              ));
        },
      ),
    );
  }
}