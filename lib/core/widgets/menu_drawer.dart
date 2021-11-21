import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';
import 'package:sisterhood_global/features/home/controller/drawer_controller.dart';
import 'package:sisterhood_global/features/home/pages/about_us.dart';
import 'package:sisterhood_global/features/home/pages/admin_home.dart';
import 'package:sisterhood_global/features/home/pages/contact_us.dart';
import 'package:sisterhood_global/features/profile/pages/profile_screen.dart';

class MenuDrawer extends StatefulWidget {
  MenuDrawer({
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ProfilePicture(
                              width: 80.0,
                              height: 80.0,
                              image: AssetImage('images/logo3.png'),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          auth.currentUser!.email == 'donaldebuga@gmail.com'
                              ? ButtonWithICon2(
                                  icon: Icons.person,
                                  title: 'Admin Section',
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Get.to(() => AdminHome());
                                  },
                                )
                              : Container(),
                          ButtonWithICon2(
                            icon: Icons.person,
                            title: 'My Profile',
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.to(() => ProfileScreen());
                            },
                          ),
                          ButtonWithICon2(
                            icon: Icons.info,
                            title: 'About Us',
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.to(() => AboutUs());
                            },
                          ),
                          ButtonWithICon2(
                            icon: Icons.contact_mail,
                            title: 'Contact Us',
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.to(() => const ContactUs());
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          ButtonWithIcon(
                            icon: (Icons.share),
                            title: ('Invite Friends'),
                            onTap: () {
                              Navigator.of(context).pop();
                              // ShareExtend.share(
                              //   'Hey download the God-Life Assembly mobile app https://play.google.com/store/apps/details?id=com.godlife.churchapp.godlifeassembly',
                              //   'text',
                              // );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            const Divider(
              height: 15.0,
              color: JanguAskColors.primaryGreyColor,
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 10.2,
                  bottom: 20.5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // ButtonWithIcon(
                    //   icon: (Icons.settings),
                    //   title: ('Settings'),
                    //   onTap: () {
                    //    // Navigator.of(context).pushNamed(MySettings.id);
                    //   },
                    // ),
                    // SizedBox(height: 5.0),
                    ButtonWithIcon(
                      icon: Icons.exit_to_app,
                      title: 'Sign Out',
                      onTap: () async {
                        _auth.logout();
                        Get.offAll(LoginScreen());
                      },
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
      width: 149.0,
      height: 40.0,
      margin: EdgeInsets.only(
        top: 8.5,
        bottom: 8.5,
      ),
      padding: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: JanguAskColors.pinkishGreyColor,
            offset: Offset(0.0, 2.5),
            blurRadius: 7.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: JanguAskColors.whiteColor,
              ),
              SizedBox(width: 9.2),
              Text(
                title,
                style: TextStyle(
                  color: JanguAskColors.whiteColor,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
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
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 22.6,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: JanguAskColors.primaryGreyColor,
            ),
            SizedBox(width: 18.5),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.0,
                color: JanguAskColors.primaryGreyColor,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
