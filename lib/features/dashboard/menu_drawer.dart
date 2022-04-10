import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';
import 'package:sisterhood_global/features/home/app_support.dart';
import 'package:sisterhood_global/features/home/controller/drawer_controller.dart';
import 'package:sisterhood_global/features/home/pages/about_us.dart';
import 'package:sisterhood_global/features/home/pages/admin/admin_home.dart';
import 'package:sisterhood_global/features/home/pages/contact_us.dart';
import 'package:sisterhood_global/features/home/pages/home_events.dart';
import 'package:sisterhood_global/features/ngo/pages/ngo_page.dart';
import 'package:sisterhood_global/features/profile/pages/my_reports.dart';

import '../../core/widgets/profile_picture.dart';
import '../profile/pages/my_profile.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final CusDrawerController _auth = Get.put(CusDrawerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: ThemeColors.whiteColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ProfilePicture(
              width: 50.0,
              height: 50.0,
              image: AssetImage('images/logo3.png'),
            ),
          ),
        ),
        iconTheme:
            const IconThemeData(color: ThemeColors.blackColor1, size: 35),
        titleSpacing: 15.0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10.2,
                  bottom: 20.5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    auth.currentUser!.email == 'donaldebuga@gmail.com' ||
                            auth.currentUser!.email ==
                                'sisterhoodglobalapp@gmail.com'
                        ? ButtonWithIcon(
                            icon: Icons.person,
                            title: 'Admin Section',
                            onTap: () {
                              Get.to(() => AdminHome());
                            },
                          )
                        : Container(),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.info,
                      title: 'About Us',
                      onTap: () {
                        Get.to(() => AboutUs());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.person,
                      title: 'My Profile',
                      onTap: () {
                        Get.to(() => ProfilePage());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.event,
                      title: 'Events',
                      onTap: () {
                        Get.to(() => const HomeEvents());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.group,
                      title: 'NGO',
                      onTap: () {
                        Get.to(() => const NGOPage());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.contact_mail,
                      title: 'Contact Us',
                      onTap: () {
                        Get.to(() => const ContactUs());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.report_outlined,
                      title: 'My Reports',
                      onTap: () {
                        Get.to(() => const MyReports());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.support,
                      title: 'App Support',
                      onTap: () {
                        Get.to(() => const AppSupport());
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: (Icons.share),
                      title: ('Invite Friends'),
                      onTap: () {
                        if (Platform.isAndroid) {
                          ShareExtend.share(
                            'Hey download the Sisterhood global mobile app https://play.google.com/store/apps/details?id=com.abidon.sisterhood_global',
                            'text',
                          );
                        }
                        if (Platform.isIOS) {
                          ShareExtend.share(
                            'Hey download the Sisterhood global mobile app https://play.google.com/store/apps/details?id=com.abidon.sisterhood_global',
                            'text',
                          );
                        }
                      },
                    ),
                    const Divider(
                      height: 15.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                    ButtonWithIcon(
                      icon: Icons.exit_to_app,
                      title: 'Log Out',
                      onTap: () async {
                        Get.defaultDialog(
                          title: 'Logout of Account',
                          middleText:
                              'Are you sure you want to logout of your account? ',
                          barrierDismissible: false,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                //Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                _auth.logout();
                                Get.offAll(() => LoginScreen());
                              },
                              child: const Text('Confirm')),
                        );
                      },
                    ),
                    const Divider(
                      height: 10.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
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
    return InkWell(
      onTap: onTap,
      // leading: icon,
      // title: title,
      // onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 22.6,
        ),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                color: ThemeColors.blackColor1,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
