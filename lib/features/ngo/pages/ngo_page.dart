import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/widgets/responsive_ui.dart';

import '../../../core/widgets/menu_drawer.dart';

class NGOPage extends StatefulWidget {
  const NGOPage({Key? key}) : super(key: key);

  @override
  _NGOPageState createState() => _NGOPageState();
}

class _NGOPageState extends State<NGOPage> {
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'NGO',
          style: TextStyle(),
        ),
      ),
      drawer: MenuDrawer(),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 10.5,
                  bottom: 5.0,
                ),
                padding: const EdgeInsets.only(
                  left: 10.5,
                  right: 10.5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.5)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Center(
                      child: Text(
                        "NONNIE ROBERSON NGO",
                        style: TextStyle(
                            fontSize: 19.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Women of purpose NGO",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.pinkAccent,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Creating Women of purpose from the backstreets",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.pinkAccent,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "\nGiving assurance on the unyielding zeal of the group, pastor Nonnie said, ‘’ We will keep Going forward, with full assurance that this move of God cannot be stopped, and the gates of hell cannot prevail against the church of God.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "\nProstitution remains a plague not only in Nigerian society but also in the 'developed countries.' But the form of prostitution that doesn't get much attention is where women have to 'use what they have to get what they want. It is against this backdrop that New Wine Ministries is keen on establishing 'Women of Purpose,' a non-governmental organization (NGO) that seeks to restore the dignity of womanhood.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () async {},
                textColor: Colors.white,
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  width:
                      _large ? _width / 3 : (_medium ? _width / 3 : _width / 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                      colors: <Color>[Colors.orange[200]!, Colors.pinkAccent],
                    ),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Support the Vision',
                      style: TextStyle(
                          fontSize: _large ? 14 : (_medium ? 12 : 10))),
                ),
              ),
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

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.image,
  }) : super(key: key);
  final Function() onTap;
  final String title, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.40,
          height: MediaQuery.of(context).size.height * 0.20,
          margin: const EdgeInsets.only(
              top: 17.5, bottom: 5.0, left: 15.0, right: 7.0),
          //padding: EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.10,
                  )
                ],
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
