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
  String senderName = '', senderPhoto = '', senderId = '';

  void _fetchUserData() async {
    try {
      usersRef.doc(auth.currentUser!.uid).get().then((ds) {
        if (ds.exists) {
          setState(() {
            senderName = ds.data()!['name'];
            senderPhoto = ds.data()!['photo'];
            senderId = ds.data()!['userId'];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      FirebaseApi.sendChat(senderPhoto, message, widget.chatId, widget.senderId,
          widget.receiverId, senderName);
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
    _fetchUserData();
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
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
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
                style: const TextStyle(color: ThemeColors.whiteColor),
              )
            ],
          ),
          backgroundColor: ThemeColors.pink.shade400,
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
                    bool isOwner = false;
                    if (auth.currentUser!.uid == snapshot[index]['senderId']) {
                      isOwner = true;
                    } else {
                      isOwner = false;
                    }

                    return isOwner
                        ? ReceiverChatBox(
                            chatId: snapshot[index]['messageId'],
                            postId: widget.chatId,
                            receiverId: widget.receiverId,
                            messageContent: snapshot[index]['messageContent'],
                            timeOfMessage:
                                getTimestamp(snapshot[index]['createdAt']),
                          )
                        : SenderChatBox(
                            messageContent: snapshot[index]['messageContent'],
                            senderName: snapshot[index]['userName'],
                            senderPhoto: snapshot[index]['photo'],
                            timeOfMessage:
                                getTimestamp(snapshot[index]['createdAt']),
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
