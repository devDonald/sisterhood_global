import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/features/community/pages/latest_posts.dart';
import 'package:sisterhood_global/features/community/pages/lets_talk_about_it.dart';
import 'package:sisterhood_global/features/community/pages/pinned_posts.dart';

class CommunityHome extends StatefulWidget {
  static const String id = 'Search';
  const CommunityHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommunityHomeState();
  }
}

class _CommunityHomeState extends State<CommunityHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Pinned'),
    Tab(text: 'Latest'),
    Tab(text: 'Let\'s Talk About It'),
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
          title: Text('Community', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.pinkAccent, size: 35),
          backgroundColor: ThemeColors.pink.shade400,
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.white,
            tabs: commTabs,
          )),
      body: TabBarView(
        controller: _tabController,
        children: const [PinnedPosts(), LatestPosts(), TalkAboutIt()],
      ),
    );
  }
}
//TODO if we have to use tabs
