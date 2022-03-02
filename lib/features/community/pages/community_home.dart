import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/community/pages/pinned_posts.dart';

import '../../../core/widgets/menu_drawer.dart';
import 'create_contribution.dart';

class CommunityHome extends StatefulWidget {
  static const String id = 'Search';

  CommunityHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _CommunityHomeState();
  }
}

class _CommunityHomeState extends State<CommunityHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Pinned Posts'),
    Tab(text: 'Latest Posts'),
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
          title: const Text('Community'),
          backgroundColor: Colors.pink,
          bottom: TabBar(
            controller: _tabController,
            tabs: commTabs,
          )),
      drawer: MenuDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          const PinnedPosts(),
          Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const CreateContribution());
        },
      ),
    );
  }
}
//TODO if we have to use tabs
