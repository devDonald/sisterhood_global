import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/features/chats/data/history_model.dart';
import 'package:sisterhood_global/features/chats/pages/list_chats_widget.dart';
import 'package:sisterhood_global/features/chats/pages/new_chat_members.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import 'chat_screen.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        child: PaginateFirestore(
          shrinkWrap: true,
          onEmpty: const Center(child: Text('You have no chat history yet')),
          physics: const BouncingScrollPhysics(),
          itemsPerPage: 50,
          itemBuilder: (context, snapshot, index) {
            HistoryModel _model = HistoryModel.fromSnapshot(snapshot[index]);

            Future<HistoryModel> _load() async {
              await _model.loadUser();
              await _model.loadLastChat();
              return _model;
            }

            return FutureBuilder(
              future: _load(),
              builder:
                  (BuildContext context, AsyncSnapshot<HistoryModel> snap) {
                return ChatListCard(
                  onTap: () {
                    Get.to(() => ChatScreen(
                        receiverId: _model.otherPerson!,
                        senderId: auth.currentUser!.uid,
                        receiverName: snap.data!.user!.name!.toUpperCase(),
                        receiverPhoto: snap.data!.user!.photo!,
                        chatId: _model.chatId!));
                  },
                  userName: snap.data?.user!.name!.toUpperCase(),
                  currentMessage: snap.data?.lastChat!.messageContent,
                  time: getTimestamp('${snap.data?.lastChat!.createdAt}'),
                  isSeen: snap.data?.lastChat!.seen,
                  pics: snap.data?.user!.photo!,
                );
              },
            );
          },
          // orderBy is compulsary to enable pagination
          query: usersRef
              .doc(auth.currentUser!.uid)
              .collection('chats')
              .orderBy('timestamp', descending: true),
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
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: ThemeColors.blackColor1,
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const NewChatMembers());
        },
      ),
    );
  }
}
