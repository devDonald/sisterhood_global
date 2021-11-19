import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sisterhood_global/core/widgets/menu_drawer.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/videos.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/youtube_live.dart';

// import 'package:standart/features/store/data/models/store_model.dart';
// import 'package:standart/features/store/presentation/bloc/store_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  HomeScreen({Key? key}) : super(key: key);
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
        drawer: MenuDrawer(),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, n) {
              return [
                SliverAppBar(
                  elevation: 0,
                  floating: true,
                  pinned: false,
                  expandedHeight: MediaQuery.of(context).size.height / 2.5,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.blurBackground],
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(color: Colors.pink),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 5.0, right: 3.0, bottom: 15.0),
                            child: Container(
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
                                    bottom:
                                        MediaQuery.of(context).size.height / 22,
                                    left:
                                        MediaQuery.of(context).size.width / 15,
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
                                                width: 3.0,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                  leading: InkWell(
                    onTap: () {
                      _scaffoldKey!.currentState!.openDrawer();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                ),
              ];
            },
            body: WillPopScope(
              onWillPop: onWillPop,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(color: Colors.black),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.height / 80,
                            vertical: MediaQuery.of(context).size.height / 90),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              tabHeaderBtn("Events", true, 0),
                              tabHeaderBtn("Community", false, 1),
                              tabHeaderBtn("NGO", false, 2),
                              tabHeaderBtn("Videos", false, 3),
                              tabHeaderBtn("Partners Cafe", false, 4),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: PageView(
                            onPageChanged: (index) {
                              setState(() {
                                selectedPage = index;
                              });
                            },
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(),
                              Container(),
                              Container(),
                              const Videos(),
                              Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ));
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
                    color: selectedPage == page ? Colors.green : Colors.white),
              ),
            ),
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: selectedPage == page ? Colors.white : Color(0xFF121922),
            width: 1,
          ))),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
