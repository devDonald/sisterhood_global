import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/features/home/pages/admin/events_home.dart';
import 'package:sisterhood_global/features/home/pages/admin/youtube_notication.dart';

import 'admin/all_users.dart';

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

  void checkInGroup() async {
    if (mounted == true) {
      setState(() {
        isLoading = true;
      });
    }
    // final prefs = await SharedPreferences.getInstance();
    //  = prefs.getString('uid');
    print('uid $_uid');
    try {
      User? _currentUser = FirebaseAuth.instance.currentUser;
      String authid = _currentUser!.uid;

      usersRef.doc(authid).get().then((ds) {
        if (ds.exists) {
          if (mounted) {
            setState(() {
              isAdmin = ds.data()!['isAdmin'];
              _uid = ds.data()!['userId'];
            });
          }
        }
      });
      if (mounted == true) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
        backgroundColor: JanguAskColors.primaryColor,
        title: const Text('Admin Section',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              HomeCard(
                icon: Icons.live_tv,
                title: 'Livestream Notification',
                onTap: () {
                  Get.to(() => LivestreamNotification());
                },
              ),
              HomeCard(
                icon: Icons.event_available,
                title: 'Events',
                onTap: () {
                  Get.to(() => EventHome());
                },
              ),
            ],
          ),
          Row(
            children: [
              HomeCard(
                icon: Icons.people,
                title: 'Manage Users',
                onTap: () async {
                  Get.to(() => DisplayUsers());
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
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
        color: JanguAskColors.primaryColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: JanguAskColors.shadowColor,
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
              color: JanguAskColors.whiteColor,
            ),
            const SizedBox(width: 9.2),
            Text(
              title,
              style: const TextStyle(
                color: JanguAskColors.whiteColor,
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
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
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
                  color: JanguAskColors.primaryColor,
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
