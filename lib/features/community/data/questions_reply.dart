import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/other_widgets.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';
import 'package:sisterhood_global/features/community/controller/firebase_api.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class QuestionReply extends StatefulWidget {
  QuestionReply({
    required this.userName,
    required this.userPhoto,
    required this.category,
    required this.question,
    required this.timeOfPost,
    required this.ownerId,
    required this.isOwner,
    required this.postId,
  });
  final String userName, userPhoto;
  final String category;
  final String question;
  final String timeOfPost;
  final String ownerId;
  final bool isOwner;
  final String postId;

  @override
  _QuestionReplyState createState() => _QuestionReplyState();
}

class _QuestionReplyState extends State<QuestionReply> {
  FocusNode? focusNode;
  bool isTyping = false;
  final _controller = TextEditingController();
  String message = '';
  String _currentUserName = '', _currentUserId = '', _currentUserImage = '';

  void fetchDetails() async {
    User? _currentUser = FirebaseAuth.instance.currentUser;
    String authid = _currentUser!.uid;
    usersRef.doc(authid).get().then((ds) {
      if (ds.exists) {
        setState(() {
          _currentUserName = ds.data()!['name'];
          _currentUserId = ds.data()!['userId'];
          _currentUserImage = ds.data()!['photo'];
        });
      }
    });
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      await FirebaseApi.uploadMessage(_currentUserImage, message, widget.postId,
          widget.ownerId, _currentUserName, widget.ownerId);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }

    _controller.clear();
  }

  @override
  void initState() {
    fetchDetails();
    super.initState();
  }

  getTextKeyBoard() {
    focusNode!.requestFocus();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  ProgressDialog? pr;
  ScrollController _scrollController = ScrollController();

  Future<void> sendChat() async {}

  Widget buildInput() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.only(
        left: 16.5,
        right: 16.5,
        bottom: 15.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 7.5,
            offset: Offset(0.0, 2.5),
            color: Colors.black26,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Button send image
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
          ),

          // Edit text
          Flexible(
            child: TextFormField(
              onTap: getTextKeyBoard,
              onChanged: (change) {
                if (change != '') {
                  setState(() {
                    isTyping = true;
                    message = change;
                  });
                } else {
                  setState(() {
                    isTyping = false;
                  });
                }
              },
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              autofocus: false,
              enableSuggestions: true,
              focusNode: focusNode,
              controller: _controller,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 15.0),
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a reply...',
                hintStyle: TextStyle(color: Color(0xff8e8e8e)),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),

          isTyping
              ? GestureDetector(
                  onTap: () {
                    //send message
                    if (_controller.text != '') {
                      sendMessage();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    margin: EdgeInsets.only(right: 10, left: 5),
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.send,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr!.style(message: 'Please wait, sending reply');

    void choiceAction(String choice) {
      if (choice == GroupChatMenu.exitGroup) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })),
                    const SizedBox(width: 15),
                    const Text(
                      'Communication',
                      // maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //subject
                        Text(
                          (widget.category != null) ? widget.category : '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ), //level
                      ],
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.blueGrey,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        DeleteEditPopUp(
                          delete: () async {
                            await communityRef
                                .doc(widget.postId)
                                .delete()
                                .then((value) {});
                            Navigator.of(context).pop();
                          },
                          edit: () {},
                          isEditable: false,
                          isOwner: widget.isOwner, // widget.isOwner,
                        )
                      ],
                    ), //title
                    const SizedBox(height: 5.0),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 13.0,
                      ),
                      child: Center(
                        child: Text(
                          widget.question,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5.0),

                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 5.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          //time
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                Icons.timer,
                                size: 14.6,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 3.0),
                              Text(
                                widget.timeOfPost,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.blueGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ProfilePicture(
                                image: NetworkImage(
                                  (widget.userPhoto != null)
                                      ? widget.userPhoto
                                      : '',
                                ),
                                width: 30.0,
                                height: 29.5,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: 130,
                                child: Text(
                                  (widget.userName != null)
                                      ? widget.userName
                                      : '',
                                  // maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(270),
      ),
      body: Container(
        child: Stack(
          children: [
            const Text(
              'Responses',
              // maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: communityRef
                          .doc(widget.postId)
                          .collection('comments')
                          .orderBy('timestamp', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text("Loading...");

                        return StickyGroupedListView<dynamic, String>(
                          floatingHeader: true,
                          scrollDirection: Axis.vertical,
                          stickyHeaderBackgroundColor: Colors.orange,
                          physics: const BouncingScrollPhysics(),
                          elements: snapshot.data!.docs,
                          groupBy: (element) => element['date'],
                          itemScrollController: GroupedItemScrollController(),
                          order: StickyGroupedListOrder.DESC,
                          reverse: true,
                          groupSeparatorBuilder: (dynamic element) => Container(
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
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(20.0)),
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

                            if (_currentUserId == element['senderId']) {
                              isOwner = true;
                              print('senderId: $isOwner');
                            } else {
                              isOwner = false;
                            }

                            return isOwner
                                ? RecieverChatBox(
                                    chatId: element['messageId'],
                                    commentId: widget.postId,
                                    receiverId: widget.postId,
                                    messageContent: element['messageContent'],
                                    timeOfMessage: element['time'],
                                    recieverName: element['userName'],
                                    recieverPhoto: element['photo'],
                                  )
                                : SenderChatBox(
                                    messageContent: element['messageContent'],
                                    senderName: element['userName'],
                                    senderPhoto: element['photo'],
                                    timeOfMessage: element['time'],
                                  );
                          },
                        );
                      }),
                ),
                //TextPart
                Container(
                  child: Column(
                    children: [
                      buildInput(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextFeildButton extends StatelessWidget {
  const TextFeildButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Icon(
          icon,
          size: 19,
          color: Color(0xff8e8e8e),
        ),
      ),
    );
  }
}

class RecieverChatBox extends StatelessWidget {
  const RecieverChatBox({
    Key? key,
    required this.recieverName,
    required this.recieverPhoto,
    required this.timeOfMessage,
    required this.messageContent,
    required this.chatId,
    required this.receiverId,
    required this.commentId,
  }) : super(key: key);
  final String recieverName,
      recieverPhoto,
      timeOfMessage,
      messageContent,
      chatId,
      commentId,
      receiverId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 70.5,
        right: 13.9,
        bottom: 10.5,
      ),
      padding: EdgeInsets.only(
        right: 11.5,
        left: 19.6,
        top: 5.5,
        bottom: 5.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white, //for now
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(0.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$timeOfMessage',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey,
                    ),
                  ),
                  // PopupMenuButton(
                  //
                  //   itemBuilder: (context) {
                  //     var list = List<PopupMenuEntry<Object>>();
                  //     list.add(
                  //       PopupMenuItem(
                  //         child: Row(
                  //           children: [
                  //             Icon(
                  //               Icons.delete,
                  //               size: 17,
                  //               color: Colors.grey,
                  //             ),
                  //             SizedBox(width: 8),
                  //             GestureDetector(
                  //               onTap: () async {
                  //                 // usersRef
                  //                 //     .document(uid)
                  //                 //     .collection('groups')
                  //                 //     .document(groupId)
                  //                 //     .collection('chats')
                  //                 //     .document(chatId).delete().whenComplete(() =>
                  //                 //     Navigator.of(context).pop()
                  //                 // );
                  //
                  //
                  //               },
                  //               child: Text(
                  //                 "Delete",
                  //                 style: TextStyle(
                  //                   color: Colors.grey,
                  //                   fontSize: 17,
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //         value: 2,
                  //       ),
                  //     );
                  //     return list;
                  //   },
                  //   icon: Icon(
                  //     Icons.more_horiz,
                  //     size: 20,
                  //     color: kGreyColor,
                  //   ),
                  //   onSelected: (val) {
                  //     if (val) {
                  //       print('Delete');
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //
                  //           return DeleteDialog();
                  //         },
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            '$messageContent',
            style: TextStyle(fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}

class SenderChatBox extends StatelessWidget {
  SenderChatBox({
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
      margin: EdgeInsets.only(
        right: 70.5,
        left: 13.9,
        top: 10.0,
        bottom: 10.5,
      ),
      padding: EdgeInsets.only(
        right: 11.5,
        left: 19.6,
        top: 5.5,
        bottom: 5.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white, //for now
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ProfilePicture(
                    image: CachedNetworkImageProvider(
                      '$senderPhoto',
                    ),
                    width: 30.0,
                    height: 29.5,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '$senderName',
                    style: TextStyle(
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
                    '$timeOfMessage',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            '$messageContent',
            style: TextStyle(fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}

class GroupChatMenu {
  static const String exitGroup = 'Exit Group';
  static const List<String> choices = <String>[exitGroup];
}
