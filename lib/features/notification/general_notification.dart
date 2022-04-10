import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/chats/pages/chat_screen.dart';
import 'package:sisterhood_global/features/community/pages/talk_details.dart';
import 'package:sisterhood_global/features/home/pages/admin/manage_community_post.dart';
import 'package:sisterhood_global/features/notification/notification_model.dart';
import 'package:sisterhood_global/features/profile/pages/follow_user_screen.dart';
import 'package:sisterhood_global/features/profile/pages/my_profile.dart';

import '../../core/themes/theme_colors.dart';
import '../../core/widgets/profile_picture.dart';
import '../../core/widgets/screen_loading.dart';
import 'notification_type.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({Key? key}) : super(key: key);

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  String activityItemText = '';

  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
        backgroundColor: ThemeColors.whiteColor,
      ),
      backgroundColor: Colors.white,
      body: PaginateFirestore(
        onEmpty: Container(
          margin: const EdgeInsets.only(top: 170),
          child: const Center(
            child: Text(
              'Notifications will appear here',
            ),
          ),
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 15,
        itemBuilder: (context, snapshot, index) {
          if (snapshot != null) {
            NotificationModel _notice =
                NotificationModel.fromSnapshot(snapshot[index]);
            String userName = "", userProfilePhoto = "";

            Future<NotificationModel> _loadNotice() async {
              await _notice.loadUser();
              return _notice;
            }

            return FutureBuilder(
              future: _loadNotice(),
              builder: (BuildContext context,
                  AsyncSnapshot<NotificationModel> snaps) {
                if (snaps.hasData) {
                  if (snaps.data != null) {
                    userName = snaps.data!.user!.name!;
                    userProfilePhoto = snaps.data!.user!.photo!;
                  }
                }

                if (_notice.type == NotificationType.chat) {
                  activityItemText = "sent you a private chat";
                  GestureDetector(
                    onTap: () {},
                  );
                } else if (_notice.type == NotificationType.following) {
                  activityItemText = "started following you";
                } else if (_notice.type ==
                    NotificationType.contributionComment) {
                  activityItemText =
                      'replied: ${_notice.commentData} on your post';
                } else if (_notice.type == NotificationType.contribution) {
                  activityItemText = 'created a new post';
                } else if (_notice.type == NotificationType.contributionLike) {
                  activityItemText = 'liked your post';
                } else if (_notice.type == NotificationType.event) {
                  activityItemText = 'posted a new event';
                } else if (_notice.type == NotificationType.adminReport) {
                  activityItemText =
                      'Reported a Post demanding action from admin';
                } else if (_notice.type == NotificationType.adminAction) {
                  activityItemText =
                      'Made a new community Post, review and take action';
                } else if (_notice.type == NotificationType.talk) {
                  activityItemText = 'Started a new Let\'s talk About it Video';
                }

                return ListTile(
                  onTap: () {
                    switch (_notice.type) {
                      case NotificationType.chat:
                        Get.to(() => ChatScreen(
                            receiverId: _notice.ownerId!,
                            senderId: _notice.userId!,
                            receiverName: userName,
                            receiverPhoto: userProfilePhoto,
                            chatId: _notice.postId!));
                        break;
                      case NotificationType.following:
                        Get.to(() => ProfilePage());
                        break;
                      case NotificationType.adminAction:
                        Get.to(() => AdminCommunityHome());
                        break;
                      case NotificationType.talk:
                        Get.to(() => TalkDetails(
                            videoID: _notice.postId!,
                            videoTitle: _notice.commentData!,
                            isLive: true,
                            time: getTimestamp(_notice.createdAt!),
                            comments: '0'));
                        break;
                      case NotificationType.contribution:
                        break;
                    }
                  },
                  leading: GestureDetector(
                    onTap: () {
                      Get.to(() => FollowUserScreen(
                            name: userName,
                            userId: _notice.ownerId!,
                          ));
                    },
                    child: ProfilePicture(
                      image: CachedNetworkImageProvider(userProfilePhoto),
                      width: 40.5,
                      height: 40.0,
                    ),
                  ),
                  title: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: '$userName ',
                      style: const TextStyle(
                        color: ThemeColors.primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => FollowUserScreen(
                                name: userName,
                                userId: _notice.ownerId!,
                              ));
                        },
                      children: [
                        TextSpan(
                          text: activityItemText,
                          style: const TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTimestamp(_notice.createdAt!),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: ThemeColors.brownishGrey,
                        ),
                      ),
                    ],
                  ),

                  //
                );
              },
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 200),
              child: const ScreenLoading(),
            );
          }
        },
        // orderBy is compulsary to enable pagination
        query: feedRef
            .doc(auth.currentUser!.uid)
            .collection('feeds')
            .orderBy('timestamp', descending: true),
        isLive: true,

        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
