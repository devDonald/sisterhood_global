import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';
import 'package:sisterhood_global/features/community/controller/firebase_api.dart';
import 'package:sisterhood_global/features/community/data/reply_text_field.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../core/themes/theme_colors.dart';
import 'chat_responses.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String receiverPhoto;
  final String senderId;
  final String chatId;

  const ChatScreen({
    Key? key,
    required this.receiverId,
    required this.senderId,
    required this.receiverName,
    required this.receiverPhoto,
    required this.chatId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode textFeildFocus = FocusNode();
  TextEditingController comment = TextEditingController();
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  bool isGetUsers = false, isGetImageType = false;
  bool isTyping = false, isAppluad = false, isReply = false;

  bool iscommentToUser = false;
  String commentToId = '';
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      FirebaseApi.sendChat(auth.currentUser!.photoURL!, message, widget.chatId,
          widget.senderId, widget.receiverId, auth.currentUser!.displayName!);
    } catch (e) {
      print("an error chat: ${e.toString()}");
    }

    comment.clear();
  }

  String? name, email, photo, uid;

  getStorage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      photo = prefs.getString('photo');
      name = prefs.getString('name');
      uid = prefs.getString('uid');
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    //getStorage();
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
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          title: Row(
            children: [
              ProfilePicture(
                height: 50,
                width: 50,
                image: CachedNetworkImageProvider(widget.receiverPhoto),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.receiverName,
                style: const TextStyle(color: ThemeColors.blackColor1),
              )
            ],
          ),
          backgroundColor: ThemeColors.whiteColor,
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
              RefreshIndicator(
                child: PaginateFirestore(
                  shrinkWrap: true,
                  onEmpty:
                      const Center(child: Text('You have no chat history yet')),
                  physics: const BouncingScrollPhysics(),
                  itemsPerPage: 50,
                  itemBuilder: (context, snapshot, index) {
                    return StickyGroupedListView<dynamic, String>(
                      floatingHeader: true,
                      shrinkWrap: true,
                      stickyHeaderBackgroundColor: Colors.white,
                      physics: const BouncingScrollPhysics(),
                      elements: snapshot,
                      groupBy: (element) => element['date'],
                      itemScrollController: GroupedItemScrollController(),
                      order: StickyGroupedListOrder.DESC,
                      reverse: true,
                      groupSeparatorBuilder: (dynamic element) => SizedBox(
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.orange[300],
                              border: Border.all(
                                color: Colors.pinkAccent,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                element['date'],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (c, element) {
                        bool isOwner = false;
                        if (auth.currentUser!.uid == element['senderId']) {
                          isOwner = true;
                        } else {
                          isOwner = false;
                        }
                        return isOwner
                            ? ReceiverChatBox(
                                chatId: element['messageId'],
                                postId: widget.chatId,
                                receiverId: widget.chatId,
                                messageContent: element['messageContent'],
                                timeOfMessage: element['time'],
                              )
                            : SenderChatBox(
                                messageContent: element['messageContent'],
                                senderName: element['userName'],
                                senderPhoto: element['photo'],
                                timeOfMessage: element['time'],
                              );
                      },
                    );
                  },
                  // orderBy is compulsary to enable pagination
                  query: chatsRef
                      .doc(widget.chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: false),
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
                    msg: 'chat cannot be empty',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: ThemeColors.redColor,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
          ),
        ),
      ],
    );
  }
}
