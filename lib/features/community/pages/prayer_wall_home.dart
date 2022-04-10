import 'package:flutter/material.dart';
import 'package:sisterhood_global/features/community/pages/agree_with_me.dart';
import 'package:sisterhood_global/features/community/pages/testimony.dart';

import '../../../core/themes/theme_colors.dart';
import '../../dashboard/menu_drawer.dart';

class PrayerWallHome extends StatefulWidget {
  static const String id = 'Search';
  const PrayerWallHome({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrayerWallHomeState();
  }
}

class _PrayerWallHomeState extends State<PrayerWallHome>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  //FocusNode searchFocus = FocusNode();
  late TabController _tabController;
  static const List<Tab> commTabs = <Tab>[
    Tab(text: 'Agree With Me'),
    Tab(text: 'Testimonies'),
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
          title: Text(
            'Prayer Wall',
            style: Theme.of(context).textTheme.headline5,
          ),
          iconTheme: const IconThemeData(color: Colors.black, size: 35),
          backgroundColor: ThemeColors.whiteColor,
          bottom: TabBar(
            controller: _tabController,
            tabs: commTabs,
          )),
      body: TabBarView(
        controller: _tabController,
        children: const [AgreeWithMe(), Testimony()],
      ),
    );
  }
}
//TODO if we have to use tabs
