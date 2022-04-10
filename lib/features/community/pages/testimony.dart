import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/widgets/responsive_ui.dart';
import 'package:sisterhood_global/features/community/pages/community_comment_screen.dart';
import 'package:sisterhood_global/features/notification/notification_type.dart';

import '../../../core/constants/contants.dart';
import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/other_widgets.dart';
import '../../profile/pages/follow_user_screen.dart';
import '../data/community_model.dart';
import 'create_contribution.dart';

class Testimony extends StatefulWidget {
  const Testimony({
    Key? key,
  }) : super(key: key);

  @override
  _TestimonyState createState() => _TestimonyState();
}

class _TestimonyState extends State<Testimony> {
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
              child: Text('No Post yet'),
            ),
            physics: const BouncingScrollPhysics(),
            itemsPerPage: 10,
            itemBuilder: (context, snapshot, index) {
              CommunityModel _discuss =
                  CommunityModel.fromSnapshot(snap: snapshot[index]);

              String _name = '', _pics = '';

              Future<CommunityModel> _load() async {
                await _discuss.loadUser();
                return _discuss;
              }

              return FutureBuilder(
                future: _load(),
                builder:
                    (BuildContext context, AsyncSnapshot<CommunityModel> snap) {
                  if (snap.hasData) {
                    if (snap.data != null) {
                      _name = snap.data!.user!.name!;
                      _pics = snap.data!.user!.photo!;
                    }
                  }

                  CommunityModel doc =
                      CommunityModel.fromSnapshot(snap: snapshot[index]);

                  int comment = int.parse(doc.commentCount!);
                  String singleComment = 'comment';
                  String aboveOneComment = 'comments';
                  String determinComment =
                      comment > 1 ? aboveOneComment : singleComment;
                  //
                  int applaud = int.parse(doc.likeCount!);
                  String singleApplaud = 'like';
                  String aboveOneApplaud = 'likes';
                  String determinApplaud =
                      applaud > 1 ? aboveOneApplaud : singleApplaud;

                  return QuestionCard(
                    isPinned: doc.isPinned!,
                    isAdmin: false,
                    category: doc.category!,
                    question: doc.body!,
                    userName: _name,
                    userPhoto: _pics,
                    isVerified: doc.isApproved!,
                    isOwner: doc.isOwner!,
                    ownerId: doc.ownerId!,
                    postId: doc.postId!,
                    withImage: doc.withImage!,
                    imageUrl: doc.imageLink!,
                    timeOfPost: getTimestamp(doc.createdAt!),
                    onTapComment: () {
                      Get.to(() => CommentScreen(
                            question: doc.body!,
                            userName: _name,
                            withImage: doc.withImage!,
                            imageUrl: doc.imageLink!,
                            userPhoto: _pics,
                            isOwner: doc.isOwner!,
                            ownerId: doc.ownerId!,
                            postId: doc.postId!,
                            timeOfPost: getTimestamp(doc.createdAt!),
                            category: doc.category!,
                            noOfApplaud: '${doc.likeCount} $determinApplaud',
                            isApplauded: doc.likeToCard!,
                            applaudColor:
                                doc.likeToCard! ? Colors.pink : Colors.grey,
                            noOfComment: '${doc.commentCount} $determinComment',
                            onUserTap: () {
                              if (!doc.isOwner!) {
                                Get.to(() => FollowUserScreen(
                                    name: _name, userId: doc.ownerId!));
                              }
                            },
                          ));
                    },
                    onUserTap: () {
                      if (!doc.isOwner!) {
                        Get.to(() => FollowUserScreen(
                            name: _name, userId: doc.ownerId!));
                      }
                    },
                    noOfApplaud: '${doc.likeCount} $determinApplaud',
                    isApplauded: doc.likeToCard!,
                    applaudColor: doc.likeToCard! ? Colors.pink : Colors.grey,
                    noOfComment: '${doc.commentCount} $determinComment',
                  );
                },
              );
            },
            // orderBy is compulsary to enable pagination
            query: communityRef
                .where('isApproved', isEqualTo: true)
                .where('category', isEqualTo: PostType.testimony)
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
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Get.to(() => const CreateContribution(
                  isAdmin: false,
                  category: PostType.testimony,
                ));
          },
        ));
  }
}
