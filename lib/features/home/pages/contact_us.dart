import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
    //checkInGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ContactButtonWithICon(
              icon: Icons.call,
              title: '+18326129993',
              onTap: () {
                launch("tel: +18326129993");
              },
              description: 'Our call center is open to you 24/7'),
          ContactButtonWithICon(
              icon: Icons.email,
              title: 'contact@sisterhoodglobal.org',
              onTap: () {
                launch(
                    "mailto:contact@sisterhoodglobal.org?subject=Feedback and Enquiry=New%20plugin");
              },
              description: 'email us for any feedback'),
          ContactButtonWithICon(
              icon: Icons.facebook,
              title: 'Sisterhood-Africa/Global',
              onTap: () {
                launch("https://web.facebook.com/groups/315162048963439");
              },
              description: 'Join our closed facebook group'),
          ContactButtonWithICon(
              icon: FontAwesomeIcons.instagram,
              title: 'sisterhoodglobal',
              onTap: () {
                launch("https://www.instagram.com/sisterhoodglobal/?hl=en");
              },
              description: 'Follow us on Instagram'),
          ContactButtonWithICon(
              icon: FontAwesomeIcons.facebook,
              title: 'SisterHood-Africa',
              onTap: () {
                launch("https://web.facebook.com/shgafrica");
              },
              description: 'Follow our facebook page'),
          ContactButtonWithICon(
              icon: FontAwesomeIcons.internetExplorer,
              title: 'Contact Website',
              onTap: () {
                launch("https://www.sisterhoodglobal.org");
              },
              description:
                  'Check our website\n(www.sisterhoodglobal.org)\n for more information'),
          ContactButtonWithICon(
              icon: FontAwesomeIcons.locationArrow,
              title: 'Tolani Adewole',
              onTap: () {},
              description:
                  'Tolani Adewole \n3rd floor, suite 01, Nusaiba tower.\nAhmadu Bello way, Abuja 900108')
        ],
      ),
    );
  }
}

class ContactButtonWithICon extends StatelessWidget {
  const ContactButtonWithICon({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.description,
  }) : super(key: key);
  final IconData icon;
  final String title, description;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height * 0.120,
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: ThemeColors.pinkishGreyColor,
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
                color: ThemeColors.primaryColor,
              ),
              SizedBox(width: 9.2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: ThemeColors.blackColor3,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5.2),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      color: ThemeColors.blackColor1,
                      fontSize: 14.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
