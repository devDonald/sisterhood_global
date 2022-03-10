import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';
import 'package:sisterhood_global/features/community/controller/firebase_api.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/community/data/questions_reply.dart';
import 'package:sisterhood_global/features/community/data/reply_text_field.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/themes/theme_text.dart';
import '../../../core/widgets/display_event.dart';
import '../../../core/widgets/linkify_text_widget.dart';
import '../../../core/widgets/other_widgets.dart';

class CommentScreen extends StatefulWidget {
  final String category;
  final String question;
  final String userName;
  final String userPhoto;
  final String noOfApplaud;
  final String noOfComment;
  final String timeOfPost;
  final String ownerId, imageUrl;
  final bool isApplauded, isOwner, withImage;
  final String postId;
  final Function() onUserTap;
  final Color applaudColor;

  const CommentScreen({
    Key? key,
    required this.category,
    required this.noOfApplaud,
    required this.noOfComment,
    required this.question,
    required this.timeOfPost,
    required this.ownerId,
    required this.userName,
    required this.userPhoto,
    this.isApplauded = false,
    required this.applaudColor,
    this.isOwner = false,
    required this.onUserTap,
    required this.postId,
    required this.withImage,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  FocusNode textFeildFocus = FocusNode();
  TextEditingController comment = TextEditingController();

  bool isGetUsers = false, isGetImageType = false;
  bool isTyping = false, isAppluad = false, isReply = false;

  bool iscommentToUser = false;
  String commentToId = '';
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      await FirebaseApi.uploadMessage(
          auth.currentUser!.photoURL!,
          message,
          widget.postId,
          widget.ownerId,
          auth.currentUser!.displayName!,
          widget.ownerId,
          widget.category,
          widget.question);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }

    comment.clear();
  }

  @override
  void initState() {
    textFeildFocus.requestFocus();
    super.initState();
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  void dispose() {
    textFeildFocus.dispose();
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userName,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink,
        ),
        body: buildPage(),
      ),
    );
  }

  Widget buildPage() {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeader(),
              const Divider(
                thickness: 2.0,
              ),
              const SizedBox(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: communityRef
                      .doc(widget.postId)
                      .collection('comments')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return StickyGroupedListView<dynamic, String>(
                      floatingHeader: true,
                      shrinkWrap: true,
                      stickyHeaderBackgroundColor: Colors.white,
                      physics: const BouncingScrollPhysics(),
                      elements: snapshot.data!.docs,
                      groupBy: (element) => element['date'],
                      itemScrollController: GroupedItemScrollController(),
                      order: StickyGroupedListOrder.DESC,
                      reverse: true,
                      groupSeparatorBuilder: (dynamic element) =>
                          const SizedBox(
                        height: 2,
                        child: Align(),
                      ),
                      itemBuilder: (c, element) {
                        bool isOwner = false;

                        if (auth.currentUser!.uid == element['senderId']) {
                          isOwner = true;
                        } else {
                          isOwner = false;
                        }

                        return isOwner
                            ? RecieverBox(
                                commentId: element['messageId'],
                                postId: widget.postId,
                                receiverId: widget.postId,
                                messageContent: element['messageContent'],
                                timeOfMessage: element['time'],
                              )
                            : SenderBox(
                                messageContent: element['messageContent'],
                                senderName: element['userName'],
                                senderPhoto: element['photo'],
                                timeOfMessage: element['time'],
                              );
                      },
                    );
                  }),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: DiscussionTextField(
            discussionFocusNode: textFeildFocus,
            isTyping: isTyping, //
            discussionController: comment,
            onChanged: (String val) {
              if (val.isNotEmpty) {
                setState(() {
                  isTyping = true;
                });
              } else {
                setState(() {
                  isTyping = false;
                });
              }
            },

            sendMessage: () {
              if (comment.text != '') {
                message = comment.text;
                sendMessage();
              } else {
                Fluttertoast.showToast(
                    msg: 'comment cannot be empty',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: JanguAskColors.redColor,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    bool isApplaud = widget.isApplauded;
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
        color: JanguAskColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.5),
            blurRadius: 3.0,
            color: JanguAskColors.whiteColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //subject
              GestureDetector(
                onTap: widget.onUserTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ProfilePicture(
                      image: CachedNetworkImageProvider(
                        widget.userPhoto,
                      ),
                      width: 30.0,
                      height: 29.5,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.userName,
                      // maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: JanguAskColors.primaryGreyColor,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 12.0,
                        fontFamily: JanguAskFontFamily.secondaryFontLato,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                  ],
                ),
              ),
              DeleteEditPopUp(
                delete: () async {
                  await communityRef
                      .doc(widget.postId)
                      .delete()
                      .then((value) async {
                    await usersRef
                        .doc(widget.ownerId)
                        .update({"posts": FieldValue.increment(-1)});
                  });
                  Navigator.of(context).pop();
                },
                isOwner: widget.isOwner,
                edit: () {
                  Navigator.of(context).pop();
                },
                report: () {
                  Navigator.of(context).pop();
                }, // widget.isOwner,
              )
              //level
            ],
          ),

          const Divider(
            height: 20,
            color: JanguAskColors.pinkishGreyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.750,
                  child: LinkifyTextWidget(messageContent: widget.question),
                ),
              ),
            ],
          ), //title

          const SizedBox(height: 17.5),
          widget.withImage
              ? GestureDetector(
                  onTap: () {
                    Get.to(ViewAttachedImage(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                      text: '',
                      url: widget.imageUrl,
                    ));
                  },
                  child: CachedNetworkImage(imageUrl: widget.imageUrl))
              : Container(),
          const SizedBox(height: 10.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.timer,
                    size: 14.6,
                    color: JanguAskColors.primaryGreyColor,
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    widget.timeOfPost,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: JanguAskColors.primaryGreyColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //applaud
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isApplaud == false) {
                          CommunityDB.handleDiscussionLikes(
                              widget.postId,
                              widget.ownerId,
                              widget.question,
                              auth.currentUser!.displayName!,
                              widget.category);
                          isApplaud = true;
                        } else {
                          CommunityDB.handleDiscussionUnlike(
                              widget.postId,
                              widget.ownerId,
                              widget.question,
                              auth.currentUser!.displayName!,
                              widget.category);
                          isApplaud = false;
                        }
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 3.0),
                        Text(
                          widget.noOfApplaud,
                          style: const TextStyle(
                            fontSize: 11.0,
                            color: JanguAskColors.primaryGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 22.5,
                  ),
                  //comment
                  Row(
                    children: <Widget>[
                      Text(
                        widget.noOfComment,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: JanguAskColors.primaryGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
