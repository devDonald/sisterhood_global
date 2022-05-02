import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSupport extends StatefulWidget {
  const AppSupport({Key? key}) : super(key: key);

  @override
  _AppSupportState createState() => _AppSupportState();
}

class _AppSupportState extends State<AppSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('App Support', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.5,
          bottom: 100.0,
        ),
        padding: const EdgeInsets.only(
          left: 10.5,
          right: 23.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.5)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const Text(
                "POSTS AND CONTENT",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ExpansionTile(
                title: const Text(
                  "Can i delete my own posts",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  Wrap(
                    spacing: 5,
                    children: const [
                      Text(
                        "Yes, Simply click on",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Icon(Icons.more_horiz),
                      Text(
                        "on your post then select delete, after confirmation the post will be deleted",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text(
                  "Can I report a post?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  Wrap(
                    spacing: 5,
                    children: const [
                      Text(
                        "Yes, Simply click on",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Icon(Icons.more_horiz),
                      Text(
                        "on the post you want to report then select report post,",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "CONNECT WITH MEMBERS",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const ExpansionTile(
                title: Text(
                  "Can I follow other members?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: <Widget>[
                  ListTile(
                    subtitle: Text(
                        'Yes you can. Simply select Search users on the Home then click on Follow to connect with a member or search for a particular member then click on follow to connect with them'),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text(
                  "Can I message other members privately?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  Wrap(spacing: 5, children: const [
                    Text(
                        'Yes, you can message only the members you are following or the members that are following you.'),
                    Text(
                      "To message a member, from the navigation bar, click on messages",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                    Icon(CupertinoIcons.chat_bubble_2),
                    Text(
                      "Then from the floating button click on ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                    Icon(Icons.message),
                    Text(
                      "From the list of members you have connected with, send a private message to anyone or simply search for a member then begin your conversation",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                  ]),
                ],
              ),
              const Text(
                "MY PROFILE",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ExpansionTile(
                collapsedTextColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: const Text(
                  "How do I change my profile picture?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  Wrap(
                    spacing: 5,
                    children: const [
                      Text(
                        "From the home, select My Profile",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "then on your profile tap on the camera icon",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Icon(
                        Icons.camera_alt,
                        color: Colors.red,
                      ),
                      Text(
                        "beneath where your picture is supposed to appear",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "LIVE STREAMS",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const ExpansionTile(
                collapsedTextColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: Text(
                  "How do I know if a live stream is happening?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  ListTile(
                    subtitle: Text(
                      "If a live stream is about to happen you will receive a push notification to your phone letting you know. If you already have the app open a red banner will appear at the top of the screen alerting you that a live stream is either about to happen or is already in progress.",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
              ExpansionTile(
                collapsedTextColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: const Text(
                  "Can I watch the live stream full screen?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  Wrap(
                    spacing: 5,
                    children: const [
                      Text(
                        "Yes you can, just rotate your device so that it is horizontal and the stream will go full screen. Rotate your app to the vertical position again to exit full screen and view and post comments",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Icon(Icons.menu),
                      Text(
                        "from the navigation bar, then select",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "LOG OUT",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              const Text(
                "LOG OUT FROM APP",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              ExpansionTile(
                collapsedTextColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: const Text(
                  "How do I Log out from the App?",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                children: [
                  Wrap(
                    spacing: 5,
                    children: const [
                      Text(
                        "Simply click on the more menu",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Icon(Icons.menu),
                      Text(
                        "from the navigation bar, then select",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "LOG OUT",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              //Church Units
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.070,
        margin: const EdgeInsets.only(
          top: 10.0,
        ),
        padding: const EdgeInsets.all(
          10.2,
        ),
        decoration: BoxDecoration(
          color: ThemeColors.blackColor1,
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 1.5),
              blurRadius: 3.0,
              color: ThemeColors.primaryColor,
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                launch(
                    "mailto:support@sisterhoodglobal.org?subject=I want more Support=New%20plugin");
              },
              child: const Text(
                "support@sisterhoodglobal.org",
                style: TextStyle(fontSize: 18.0, color: ThemeColors.whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListItemsCard extends StatelessWidget {
  final String text;
  const ListItemsCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              backgroundColor: Colors.pinkAccent,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
