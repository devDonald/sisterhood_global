import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('About us', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.5,
          bottom: 10.0,
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
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ExpansionTile(
                title: const Text(
                  "Our Founder",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Image.asset('images/nonnie.png'),
                  const ListTile(
                    title: Text('PROPHETESS NONNIE NONYE ROBERSON',
                        style: TextStyle(
                          color: ThemeColors.blackColor1,
                          fontWeight: JanguAskFontWeight.kBoldText,
                          fontSize: 18,
                        )),
                    subtitle: Text(
                        '\nThe life of a blazing Amazon and Ambassador for Christ Nonnie Roberson, a seasoned Nigerian-born midwife, Seer, Prophetess of God, and a mother with an infectious and insatiable love for the works of God in the body of Christ. \nShe was popularly known for her cry for repentance in the church, on the pulpit, and in the heart. \n\nProphetess Nonnie has through wisdom by the Holy Spirit skillfully and delicately untied those who were held bound, Led and mentored God\'s children with the word of God, to help them make a great impact in their lifetime, and to fulfill the destiny Apart from being a passionate lover of Christ, she was a successful entrepreneur and understood how to navigate the marketplace ministry.\n \nHer work reaches out to the poor, outcast, and downtrodden in society.Having pastored a local assembly for 10 years, she saw the need to reach out to the unchurched. This she did through her outreach programs to prisons, hospitals, prostitutes, drug addicts, widows, and orphans.She was the convener of The New Wine ministries, Women in Clergy Group, and Sisterhood Africa/Global, a closed group of over 3million women who she ministered to and counselled.\n\n She headed various projects such as Christ on the Street, detained by Birth, and Rising Army and lost more.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                  "Our Story",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Look How far we have come",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome to the place where women all around the globe experience unprecedented miracles, find strong unshakable love with other women, and connect deeply with GOD",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Community:",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "We are not just another platform for women. We link arms like God’s Children, encouraging one another, listen long, celebrate, pray, ask, learn for the purpose of equipping ourselves and pointing others to the eternal hope of  Christ. We ask you to join us the way you are, there’s a place for you.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "“A good friend knows all the stories. A sister has lived it with you.”",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //t1
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "In 2017, it was impressed in Nonnie Roberson’s heart to set up a platform where women can come together, pray together, love each other, receive godly counsels, express how they feel inside, and get solutions to their problems with abounding testimonies.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  //t2

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\nWithin a short while, This page grew to over 3 million active members.. Indeed, Sisterhood Africa (Now Sisterhood Global) has since become a house of solutions and testimonies. It is a place of solace for many women in Africa, and around the world. The testimonies shared on SHA were too mysterious to be understood by unbelievers and some believers.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  //t3
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\nGiving assurance on the unyielding zeal of the group, pastor Nonnie said, ‘’ We will keep Going forward, with full assurance that this move of God cannot be stopped, and the gates of hell cannot prevail against the church of God.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),

                  //t4

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\nAfter the demise of Nonnie Roberson in 2019, Sisterhood Global continues to elicit positive responses globally, the group has explained its universal approach to solving the plights of women in the world.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),

              const ExpansionTile(
                title: Text(
                  "Our Mission and Values",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Driven by our mission to tackle global problems associated with women through effective use of social media. We are guided by the following values to Empower women with the Word of God",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "SisterHood is:",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListItemsCard(text: 'Celebrating with others'),
                  ListItemsCard(text: 'Accepting'),
                  ListItemsCard(text: 'Supportive'),
                  ListItemsCard(text: 'Empowering'),
                  ListItemsCard(text: 'Connecting in a meaningful way'),
                  ListItemsCard(text: 'Never Alon'),
                  ListItemsCard(text: 'A sense of Belonging'),
                  ListItemsCard(text: 'Mentoring'),
                  ListItemsCard(text: 'Diverse'),
                  ListItemsCard(text: 'Sharing'),
                  ListItemsCard(text: 'Non-Competitive'),
                  ListItemsCard(text: 'Uplifting'),
                  ListItemsCard(text: 'Loving'),
                  ListItemsCard(text: 'NonJudgemental'),
                  ListItemsCard(text: 'Beautiful'),
                  ListItemsCard(text: 'Prayer'),
                  ListItemsCard(text: 'Forgiving'),
                  ListItemsCard(text: 'Nurturing'),
                  ListItemsCard(text: 'Togetherness'),
                  ListItemsCard(text: 'Love'),
                  ListItemsCard(text: 'Faith'),
                  ListItemsCard(text: 'Trust'),
                  ListItemsCard(text: ''),
                ],
              ),
              //Church Units
            ],
          ),
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
