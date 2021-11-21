import 'package:flutter/material.dart';

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
        elevation: 3.0,
        backgroundColor: Colors.pink,
        title: const Text('About Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
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
              const ExpansionTile(
                title: Text(
                  "Our Mandate",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                        'The God-Life Assembly has been called to raise a pure breed of believers, a kingdom minded people divergent in assignments, roles and functions according to the distribution of grace, but unified in destiny pressing onward daily to be conformed to the fullness of the image of the Christ, a generation who will weary the Devil'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Our Culture",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ViewOurCulture(
                      //               image: 'images/love.png',
                      //             )));
                    },
                    child: ListTile(
                      title: Text(
                        'Love',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ViewOurCulture(
                      //               image: 'images/worship.png',
                      //             )));
                    },
                    child: ListTile(
                      title: Text(
                        'Worship',
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: ListTile(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ViewOurCulture(
                        //               image: 'images/word.png',
                        //             )));
                      },
                      title: Text(
                        'Word',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ViewOurCulture(
                      //               image: 'images/prayer.png',
                      //             )));
                    },
                    child: ListTile(
                      title: Text(
                        'Prayer',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ViewOurCulture(
                      //               image: 'images/love.png',
                      //             )));
                    },
                    child: ListTile(
                      title: Text(
                        'Accountability',
                      ),
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: Text(
                  "Our Branches",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[],
              ),
              //Church Units
              ExpansionTile(
                title: Text(
                  "Church Units",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
