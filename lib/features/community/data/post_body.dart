import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/constants/contants.dart';

class CommentScreen extends StatefulWidget {
  final String? postId;
  final String? postOwner;
  final String? postMediaUrl;

  const CommentScreen({this.postId, this.postOwner, this.postMediaUrl});
  @override
  _CommentScreenState createState() => _CommentScreenState(
      postId: postId!, postOwner: postOwner!, postMediaUrl: postMediaUrl!);
}

class _CommentScreenState extends State<CommentScreen> {
  final String postId;
  final String postOwner;
  final String postMediaUrl;

  bool didFetchComments = false;
  List<Comment> fetchedComments = [];

  final TextEditingController _commentController = TextEditingController();

  _CommentScreenState(
      {required this.postId,
      required this.postOwner,
      required this.postMediaUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: buildComments(),
        ),
        const Divider(),
        ListTile(
          title: TextFormField(
            controller: _commentController,
            decoration: const InputDecoration(labelText: 'Write a comment...'),
            onFieldSubmitted: addComment,
          ),
          trailing: OutlineButton(
            onPressed: () {
              addComment(_commentController.text);
            },
            borderSide: BorderSide.none,
            child: const Text("Post"),
          ),
        ),
      ],
    );
  }

  Widget buildComments() {
    if (didFetchComments == false) {
      return FutureBuilder<List<Comment>>(
          future: getComments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: FractionalOffset.center,
                  child: const CircularProgressIndicator());
            }

            didFetchComments = true;
            fetchedComments = snapshot.data!;
            return ListView(
              children: snapshot.data!,
            );
          });
    } else {
      // for optimistic updating
      return ListView(children: fetchedComments);
    }
  }

  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    QuerySnapshot data =
        await communityRef.doc(postId).collection("comments").get();
    for (var doc in data.docs) {
      comments.add(Comment.fromDocument(doc));
    }
    return comments;
  }

  addComment(String comment) {
    _commentController.clear();
    communityRef.doc(postId).collection("comments").add({
      // "username": currentUserModel.username,
      // "comment": comment,
      // "timestamp": Timestamp.now(),
      // "avatarUrl": currentUserModel.photoUrl,
      // "userId": currentUserModel.id
    });

    //adds to postOwner's activity feed
    FirebaseFirestore.instance
        .collection("insta_a_feed")
        .doc(postOwner)
        .collection("items")
        .add({
      // "username": currentUserModel.username,
      // "userId": currentUserModel.id,
      // "type": "comment",
      // "userProfileImg": currentUserModel.photoUrl,
      // "commentData": comment,
      // "timestamp": Timestamp.now(),
      // "postId": postId,
      // "mediaUrl": postMediaUrl,
    });

    // add comment to the current listview for an optimistic update
    setState(() {
      // fetchedComments = List.from(fetchedComments)..add(Comment(
      //     username: currentUserModel.username,
      //     comment: comment,
      //     timestamp: Timestamp.now(),
      //     avatarUrl: currentUserModel.photoUrl,
      //     userId: currentUserModel.id
      // ));
    });
  }
}

class Comment extends StatelessWidget {
  final String? username;
  final String? userId;
  final String? avatarUrl;
  final String? comment;
  final Timestamp? timestamp;

  Comment(
      {this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot data) {
    return Comment(
      username: data['username'],
      userId: data['userId'],
      comment: data["comment"],
      timestamp: data["timestamp"],
      avatarUrl: data["avatarUrl"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment!),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl!),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
