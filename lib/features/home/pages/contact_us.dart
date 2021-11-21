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
        elevation: 3.0,
        backgroundColor: JanguAskColors.primaryColor,
        title: const Text('Contact Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ContactButtonWithICon(
              icon: Icons.call,
              title: '+2348036795246',
              onTap: () {
                launch("tel: +2348036795246");
              },
              description: 'Our call center is open to you 24/7'),
          ContactButtonWithICon(
              icon: Icons.email,
              title: 'sisterhoodgloballapp@gmail.com',
              onTap: () {
                launch(
                    "mailto:sisterhoodgloballapp@gmail.com?subject=Feedback and Enquiry=New%20plugin");
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
              description: 'Follow our facebook page')
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
    return Container(
      width: double.infinity,
      height: 70.0,
      margin: const EdgeInsets.only(
        top: 8.5,
        bottom: 8.5,
        left: 20,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
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
                color: JanguAskColors.primaryColor,
              ),
              SizedBox(width: 9.2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 9.2),
                  Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(height: 9.2),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: JanguAskColors.blackColor1,
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
