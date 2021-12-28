import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/widgets/responsive_ui.dart';
import 'package:sisterhood_global/features/community/data/community_questions.dart';
import 'package:sisterhood_global/features/home/pages/ngo_page.dart';

import 'create_question.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
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
                  children: [
                    SizedBox(
                      width: 250.0,
                      child: TypewriterAnimatedTextKit(
                        speed: const Duration(milliseconds: 200),
                        totalRepeatCount: 4,
                        repeatForever: true,
                        onTap: () {},
                        text: const [
                          "Are you worried or Disturbed?",
                          "Do you need anybody to pray or talk with you?",
                          "You can drop a prayer request or question so that someone can pray with you or respond immediately",
                          "We are family. feel free to respond to somebody's prayer or question"
                        ],
                        textStyle: const TextStyle(
                            fontSize: 23.0,
                            fontFamily: "Agne",
                            color: Colors.black),
                        textAlign: TextAlign.start, // or Alignment.topLeft
                      ),
                    ),
                  ],
                ),
              ),
              ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      CommunityCard(
                        image: 'images/finance.png',
                        title: 'Finances',
                        onTap: () {
                          Get.to(
                              () => const QuestionsTab(category: 'Finances'));
                        },
                      ),
                      CommunityCard(
                        image: 'images/relationship.png',
                        title: 'Relationship',
                        onTap: () {
                          Get.to(() =>
                              const QuestionsTab(category: 'Relationship'));
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CommunityCard(
                        image: 'images/family.png',
                        title: 'Family',
                        onTap: () {
                          Get.to(() => const QuestionsTab(category: 'Family'));
                        },
                      ),
                      CommunityCard(
                        image: 'images/education.jpeg',
                        title: 'Education',
                        onTap: () {
                          Get.to(
                              () => const QuestionsTab(category: 'Education'));
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CommunityCard(
                        image: 'images/spirituality.jpeg',
                        title: 'Spirituality',
                        onTap: () {
                          Get.to(() =>
                              const QuestionsTab(category: 'Spirituality'));
                        },
                      ),
                      CommunityCard(
                        image: 'images/health.png',
                        title: 'Health',
                        onTap: () {
                          Get.to(() => const QuestionsTab(category: 'Health'));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const CreateQuestion());
        },
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
