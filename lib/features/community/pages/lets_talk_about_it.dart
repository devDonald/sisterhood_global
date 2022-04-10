import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/widgets/responsive_ui.dart';
import 'package:sisterhood_global/features/community/pages/talk/talk_widget.dart';
import 'package:sisterhood_global/features/community/pages/talk_details.dart';
import 'package:sisterhood_global/features/home/data/talk_model.dart';

import '../../../core/constants/contants.dart';

class TalkAboutIt extends StatefulWidget {
  const TalkAboutIt({
    Key? key,
  }) : super(key: key);

  @override
  _TalkAboutItState createState() => _TalkAboutItState();
}

class _TalkAboutItState extends State<TalkAboutIt> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
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
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        child: PaginateFirestore(
          shrinkWrap: true,
          onEmpty: const Center(
            child: Text('No talks yet'),
          ),
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 10,
          itemBuilder: (context, snapshot, index) {
            TalkModel doc = TalkModel.fromSnapshot(snap: snapshot[index]);

            return TalkWidget(
                videoID: doc.videoId!,
                title: doc.videoTitle!,
                date: getTimestamp(doc.createdAt!),
                like: '${doc.likeCount}',
                comment: '${doc.commentCount}',
                isLive: doc.isLive!,
                onPlay: () {
                  Get.to(() => TalkDetails(
                        comments: doc.commentCount!,
                        videoID: doc.videoId!,
                        videoTitle: doc.videoTitle!,
                        isLive: doc.isLive!,
                        time: getTimestamp(doc.createdAt!),
                      ));
                },
                isLiked: doc.likeToCard!);
          },
          // orderBy is compulsory to enable pagination
          query: talkRef.orderBy('timestamp', descending: true),
          isLive: true,
          listeners: [
            refreshChangeListener,
          ],
          itemBuilderType: PaginateBuilderType.listView,
        ),
        onRefresh: () async {
          refreshChangeListener.refreshed = true;
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
