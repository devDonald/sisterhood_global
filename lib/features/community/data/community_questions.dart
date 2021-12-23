import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/other_widgets.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';
import 'package:sisterhood_global/features/community/data/questions_reply.dart';
import 'package:sisterhood_global/features/home/pages/create_question.dart';

class QuestionsTab extends StatefulWidget {
  final String category;
  const QuestionsTab({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _QuestionsTabState createState() => _QuestionsTabState();
}

class _QuestionsTabState extends State<QuestionsTab> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.pink,
        title: Text(widget.category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
      ),
      body: RefreshIndicator(
        child: PaginateFirestore(
          shrinkWrap: true,
          emptyDisplay: Center(
            child: Container(
              child: Text('No Question Posted yet'),
            ),
          ),
          physics: BouncingScrollPhysics(),
          itemsPerPage: 25,
          itemBuilder: (index, context, snapshot) {
            CommunityModel _discuss =
                CommunityModel.fromSnapshot(snap: snapshot);
            if (snapshot.data() != null) {
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
                      CommunityModel.fromSnapshot(snap: snapshot);

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
                    onPostTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionReply(
                              question: doc.question!,
                              userName: _name,
                              userPhoto: _pics,
                              isOwner: doc.isOwner,
                              ownerId: doc.ownerId!,
                              postId: doc.postId!,
                              timeOfPost: getTimestamp(doc.createdAt!),
                              category: doc.category!,
                            ),
                          ));
                    },
                    category: doc.category!,
                    question: doc.question!,
                    userName: _name,
                    userPhoto: _pics,
                    isOwner: doc.isOwner,
                    ownerId: doc.ownerId!,
                    postId: doc.postId!,
                    timeOfPost: getTimestamp(doc.createdAt!),
                    onTapComment: () {},
                    onUserTap: () {},
                    noOfApplaud: '${doc.likeCount} $determinApplaud',
                    isApplauded: doc.likeToCard,
                    applaudColor: doc.likeToCard ? Colors.pink : Colors.grey,
                    noOfComment: '${doc.commentCount} $determinComment',
                    onTap: () {},
                  );
                },
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: 200),
                child: Container(),
              );
            }
          },
          // orderBy is compulsary to enable pagination
          query: communityRef
              .where('category', isEqualTo: widget.category)
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateQuestion(),
              ));
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
