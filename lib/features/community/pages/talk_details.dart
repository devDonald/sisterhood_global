import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/profile_picture.dart';
import '../controller/firebase_api.dart';

class TalkDetails extends StatefulWidget {
  static const routeName = "TalkDetails";
  final String videoID, videoTitle, time, comments;
  final bool isLive;

  const TalkDetails(
      {Key? key,
      required this.videoID,
      required this.videoTitle,
      required this.isLive,
      required this.time,
      required this.comments})
      : super(key: key);
  @override
  _TalkDetailsState createState() => _TalkDetailsState();
}

class _TalkDetailsState extends State<TalkDetails> {
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;
  int progress = 0;

  FocusNode textFeildFocus = FocusNode();

  TextEditingController comment = TextEditingController();

  bool isGetUsers = false, isGetImageType = false;

  bool isTyping = false, isAppluad = false, isReply = false;
  void sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      await FirebaseApi.sendYoutubeChat(
        auth.currentUser!.photoURL!,
        comment.text,
        widget.videoID,
        auth.currentUser!.uid,
        adminId,
        auth.currentUser!.displayName!,
      );
    } catch (e) {
      e.toString();
    }

    comment.clear();
  }

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: YoutubePlayerFlags(
        mute: false,
        enableCaption: false,
        autoPlay: true,
        isLive: widget.isLive,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override //landingDataController
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.red,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Let/s Talk About It",
                style: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white, size: 35),
            backgroundColor: ThemeColors.pink.shade400,
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                player,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Text(
                                      widget.videoTitle,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.keyboard_arrow_down,
                                  //   color: Colors.white,
                                  //   size: 30,
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Icon(
                                    Icons.timer,
                                    size: 14.6,
                                    color: ThemeColors.blackColor1,
                                  ),
                                  const SizedBox(width: 3.0),
                                  Text(
                                    widget.time,
                                    style: const TextStyle(
                                      fontSize: 11.0,
                                      color: ThemeColors.blackColor1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(color: Colors.grey.withOpacity(0.3)),
                        const SizedBox(height: 10),
                        ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Comments",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.comments,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showMaterialModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.56,
                                                margin:
                                                    const EdgeInsets.all(15.0),
                                                padding:
                                                    const EdgeInsets.all(25.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 5.0,
                                                      offset: Offset(0.0, 2.5),
                                                    ),
                                                  ],
                                                ),
                                                child: showCommentBox(),
                                              ));
                                    },
                                    child: const Icon(
                                      Icons.unfold_more,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                padding: const EdgeInsets.only(top: 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      backgroundImage: const AssetImage(''),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "This is comment section.",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showCommentBox() {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: 'Add Comment',
                  content: TextFormField(
                    controller: comment,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 5,
                    minLines: 2,
                    decoration: InputDecoration(
                      hintText: "type comment here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                  radius: 25,
                  cancel: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        //Get.back();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                      )),
                  confirm: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        if (comment.text != '') {
                          sendMessage();
                          Navigator.of(context).pop();
                        } else {
                          errorToastMessage(msg: 'comment cannot be empty');
                        }
                      },
                      child: const Text('Send')),
                );
              },
              child: Row(
                children: [
                  ProfilePicture(
                    image: CachedNetworkImageProvider(
                        auth.currentUser!.photoURL ?? ''),
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Add a comment'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
        PaginateFirestore(
          shrinkWrap: true,
          onEmpty: const Center(child: Text('no comments')),
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 15,
          itemBuilder: (context, snapshot, index) {
            return CommentBox(
                messageContent: snapshot[index]['messageContent'],
                senderName: snapshot[index]['senderName'],
                senderPhoto: snapshot[index]['photo'],
                timeOfMessage: getTimestamp(snapshot[index]['createdAt']));
          },
          // orderBy is compulsary to enable pagination
          query: talkRef
              .doc(widget.videoID)
              .collection('comments')
              .orderBy('timestamp', descending: false),
          isLive: true,
          itemBuilderType: PaginateBuilderType.listView,
        )
      ],
    );
  }
}

class CommentBox extends StatelessWidget {
  const CommentBox({
    Key? key,
    required this.senderName,
    required this.senderPhoto,
    required this.messageContent,
    required this.timeOfMessage,
  }) : super(key: key);
  final String senderName, senderPhoto, timeOfMessage, messageContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      padding: const EdgeInsets.only(
        right: 11.5,
        left: 19.6,
        top: 5.5,
        bottom: 5.5,
      ),
      constraints: const BoxConstraints(
        minWidth: 50,
        maxWidth: double.infinity,
      ),
      decoration: const BoxDecoration(
        color: Colors.white, //for now
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ProfilePicture(
                    image: CachedNetworkImageProvider(
                      senderPhoto,
                    ),
                    width: 30.0,
                    height: 29.5,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    senderName,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    timeOfMessage,
                    style: const TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            messageContent,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: 'serif'),
          ),
          //LinkifyTextWidget(messageContent: messageContent),
        ],
      ),
    );
  }
}
