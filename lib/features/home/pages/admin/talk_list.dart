import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/home/pages/admin/admin_add_talk.dart';

import '../../../../core/themes/theme_colors.dart';
import '../../../community/pages/talk_details.dart';
import '../../data/talk_model.dart';

class TalkListHome extends StatefulWidget {
  const TalkListHome({Key? key}) : super(key: key);

  @override
  _TalkListHomeState createState() => _TalkListHomeState();
}

class _TalkListHomeState extends State<TalkListHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Talk About it Videos",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: talkRef.orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("Loading..."),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("Loading..."),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    TalkModel doc = TalkModel.fromSnapshot(
                        snap: snapshot.data!.docs[index]);

                    DocumentSnapshot snap = snapshot.data!.docs[index];

                    return TalkList(
                      videoTitle: snap['videoTitle'],
                      onDeleteTap: () {
                        Get.defaultDialog(
                          title: 'Delete Talk Video',
                          middleText:
                              'Are you sure you want to delete talk video? ',
                          barrierDismissible: false,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                //Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                await talkRef.doc(snap['videoId']).delete();
                                Navigator.of(context).pop();
                                successToastMessage(msg: 'video deleted');
                              },
                              child: const Text('Confirm')),
                        );
                      },
                      onTapEvent: () {
                        Get.to(() => TalkDetails(
                              comments: doc.commentCount!,
                              videoID: doc.videoId!,
                              videoTitle: doc.videoTitle!,
                              isLive: doc.isLive!,
                              time: getTimestamp(doc.createdAt!),
                            ));
                      },
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.blackColor1,
        key: null,
        child: const Icon(
          Icons.add_a_photo,
          color: ThemeColors.whiteColor,
        ),
        onPressed: () {
          Get.to(() => const PostTalkAdmin());
        },
      ),
    );
  }
}

class TalkList extends StatelessWidget {
  TalkList({
    Key? key,
    required this.videoTitle,
    required this.onDeleteTap,
    required this.onTapEvent,
  }) : super(key: key);
  String videoTitle;
  Function() onDeleteTap, onTapEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapEvent,
      child: ListTile(
        leading: const Icon(
          Icons.video_collection_sharp,
          color: ThemeColors.blackColor3,
        ),
        title: Text(
          videoTitle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        trailing: GestureDetector(
          onTap: onDeleteTap,
          child: const Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}
