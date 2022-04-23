import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/home/pages/home_events.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/videos.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/youtube_live.dart';
import 'package:sisterhood_global/features/profile/pages/my_profile.dart';
import 'package:sisterhood_global/features/search/pages/sisterhood_users_search.dart';

import '../../../core/themes/theme_colors.dart';

// import 'package:standart/features/store/data/models/store_model.dart';
// import 'package:standart/features/store/presentation/bloc/store_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  int selectedPage = 0;
  PageController _pageController = PageController();
  int currentImageIndex = 0;
  bool disableForwardButton = false;
  bool disableBackwardButton = false;

  DateTime? currentBackPressTime;
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;

  showToastMessage({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  var spinkit = Image.asset(
    'assets/images/loader.gif',
    height: 40.0,
    width: 60.0,
    fit: BoxFit.fill,
  );

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override //landingDataController
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, n) {
            return [
              SliverAppBar(
                elevation: 0,
                floating: true,
                pinned: false,
                expandedHeight: MediaQuery.of(context).size.height / 2.4,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.fadeTitle],
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 5.0, right: 3.0, bottom: 15.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset('images/live.jpeg',
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 22,
                                left: MediaQuery.of(context).size.width / 15,
                                child: ButtonTheme(
                                  height: 45,
                                  minWidth: 100,
                                  child: RaisedButton(
                                    color: Colors.transparent,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const YoutubeLive()));
                                      //Get.to(YoutubeLive());
                                    },
                                    child: const Text(
                                      'WATCH NOW',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            width: 3.0, color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                centerTitle: true,
              ),
            ];
          },
          body: GridView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
                crossAxisCount: 1),
            children: [
              HomeCard2(
                icon: 'images/events.jpeg',
                title: 'Events',
                onTap: () {
                  Get.to(() => const HomeEvents());
                },
              ),
              HomeCard2(
                icon: 'images/videos.jpeg',
                title: 'Videos',
                onTap: () {
                  Get.to(() => const Videos());
                },
              ),
              HomeCard2(
                icon: 'images/profile.jpeg',
                title: 'My Profile',
                onTap: () {
                  Get.to(() => ProfilePage());
                },
              ),
              HomeCard2(
                icon: 'images/search.jpeg',
                title: 'Search Users',
                onTap: () {
                  Get.to(() => const PeopleSearch());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible tabHeaderBtn(String title, bool isActive, int page) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPage = page;
          });
          _pageController.jumpToPage(page);
        },
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 40,
                    color: selectedPage == page
                        ? Colors.pinkAccent
                        : Colors.white),
              ),
            ),
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color:
                selectedPage == page ? Colors.white : const Color(0xFF121922),
            width: 1,
          ))),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class HomeCard2 extends StatelessWidget {
  const HomeCard2({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String icon;
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.50,
        margin: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        padding: const EdgeInsets.all(
          12.2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
              color: ThemeColors.primaryColor,
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              icon,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
