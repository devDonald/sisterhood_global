import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/community/pages/talk_details.dart';

import '../../../../core/themes/theme_colors.dart';
import '../../../../core/widgets/linkify_text_widget.dart';

class TalkWidget extends StatelessWidget {
  final String title, date, like, comment, videoID;
  final bool isLive, isLiked;
  final Function() onPlay;
  const TalkWidget(
      {Key? key,
      required this.title,
      required this.date,
      required this.like,
      required this.comment,
      required this.isLive,
      required this.onPlay,
      required this.isLiked,
      required this.videoID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isApplaud = isLiked;
    return Container(
      width: double.infinity,
      // height: 320.5,
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 15.0,
      ),
      padding: const EdgeInsets.all(
        12.2,
      ),
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.5),
            blurRadius: 3.0,
            color: ThemeColors.primaryColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onPlay,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.850,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset('images/talk.png'),
                  ),
                ),
              ),
            ],
          ), //title
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.750,
                    child: LinkifyTextWidget(
                      scroll: const NeverScrollableScrollPhysics(),
                      messageContent: title,
                      maxLength: 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: isLive
                    ? Image.asset(
                        'images/livee.jpeg',
                        width: 50,
                        height: 40,
                      )
                    : Container(),
              ),
            ],
          ),
          const SizedBox(height: 5.0),

          const Divider(
            height: 2,
            color: ThemeColors.pinkishGreyColor,
          ),
          const SizedBox(height: 5.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.timer,
                    size: 14.6,
                    color: ThemeColors.primaryGreyColor,
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //applaud
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (isApplaud == false) {
                            CommunityDB.handleTalkLikes(
                                videoID,
                                adminId,
                                'Liked Talk Video',
                                auth.currentUser!.displayName!);
                            isApplaud = true;
                          } else {
                            CommunityDB.handleTalkUnlike(
                                videoID,
                                adminId,
                                'Liked Talk Video',
                                auth.currentUser!.displayName!);
                            isApplaud = false;
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.heart,
                              size: 18.8,
                              color: isApplaud
                                  ? Colors.pink
                                  : ThemeColors.primaryGreyColor,
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              like,
                              style: const TextStyle(
                                fontSize: 11.0,
                                color: ThemeColors.primaryGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //comments
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => TalkDetails(
                                comments: comment,
                                videoID: videoID,
                                videoTitle: title,
                                isLive: isLive,
                                time: date,
                              ));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.comment,
                              size: 18.8,
                              color: ThemeColors.primaryGreyColor,
                            ),
                            const SizedBox(width: 3.0),
                            Text(
                              comment,
                              style: const TextStyle(
                                fontSize: 11.0,
                                color: ThemeColors.primaryGreyColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 22.5,
                  ),
                  //comment
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
