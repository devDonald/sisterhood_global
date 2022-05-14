import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';
import 'package:sisterhood_global/features/community/data/report_model.dart';
import 'package:sisterhood_global/features/home/data/talk_model.dart';
import 'package:sisterhood_global/features/notification/notification_type.dart';

class CommunityDB {
  static addContemplation(CommunityModel todomodel) async {
    DocumentReference docRef = communityRef.doc();
    todomodel.postId = docRef.id;
    docRef.set(todomodel.toJson()).then((doc) async {
      await usersRef
          .doc(todomodel.ownerId)
          .update({"posts": FieldValue.increment(1)});
      sendGeneralNotification(
          docRef.id,
          adminId,
          todomodel.body!,
          auth.currentUser!.displayName!,
          todomodel.category!,
          NotificationType.adminAction,
          'New Post awaiting Admin Approval');

      successToastMessage(
          msg: 'Contribution Added to community, awaiting Admin Approval');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static addTalk(TalkModel talkModel) async {
    await talkRef
        .doc(talkModel.videoId)
        .set(talkModel.toJson())
        .then((doc) async {
      await usersRef.get().then((value) {});
      var result = await usersRef.get();
      for (var res in result.docs) {
        sendGeneralNotification(
            talkModel.videoId!,
            res.id,
            talkModel.videoTitle!,
            'Sisterhood Global',
            'Live Talk',
            NotificationType.talk,
            talkModel.videoTitle!);
      }

      successToastMessage(msg: 'Live Talk Added successfully');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static addReport(ReportModel reportModel) async {
    DocumentReference docRef = reportRef.doc();
    reportModel.reportId = docRef.id;
    docRef.set(reportModel.toJson()).then((doc) async {
      sendGeneralNotification(
          docRef.id,
          adminId,
          reportModel.reportTitle!,
          auth.currentUser!.displayName!,
          'Post Report',
          NotificationType.adminReport,
          reportModel.reportTitle!);
      successToastMessage(msg: 'Report Sent to Admin');
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  Future<String?> uploadFile(File file) async {
    try {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child("community")
          .child(Path.basename(file.path));
      await storageReference.putFile(file);

      var url = await storageReference.getDownloadURL();

      return url;
    } catch (error) {
      return null;
    }
  }

  static Stream<List<CommunityModel>> communityStream() {
    return communityRef
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<CommunityModel> todos = [];
      for (var todo in query.docs) {
        final todoModel = CommunityModel.fromSnapshot(snap: todo);
        todos.add(todoModel);
      }
      return todos;
    });
  }

  Future<CommunityModel> singleStream(String postId) async {
    try {
      DocumentSnapshot _doc = await communityRef.doc(postId).get();

      return CommunityModel.fromSnapshot(snap: _doc);
    } catch (e) {
      rethrow;
    }
  }

  static updateCommunity(documentId, CommunityModel update) {
    communityRef.doc(documentId).update(update.communityUpdate());
  }

  static deleteCommunity(String documentId, String ownerId) async {
    await communityRef.doc(documentId).delete();
  }

  static void handleDiscussionLikes(String postId, String ownerId,
      String discussion, String senderName, String category) async {
    await communityRef
        .doc(postId)
        .update({'likes.${auth.currentUser!.uid}': true});

    addLikeToActivityFeed(postId, ownerId, discussion, senderName,
        NotificationType.contributionLike);
  }

  static void handleDiscussionUnlike(String postId, String ownerId,
      String discussion, String senderName, String category) async {
    await communityRef
        .doc(postId)
        .update({'likes.${auth.currentUser!.uid}': false});
    removeLikeFromActivityFeed(postId, ownerId, discussion, senderName);
  }

  static void handleTalkLikes(
      String postId, String ownerId, String talk, String senderName) async {
    await talkRef.doc(postId).update({'likes.${auth.currentUser!.uid}': true});

    addLikeToActivityFeed(
        postId, ownerId, talk, senderName, NotificationType.talk);
  }

  static void handleTalkUnlike(
      String postId, String ownerId, String talk, String senderName) async {
    await talkRef.doc(postId).update({'likes.${auth.currentUser!.uid}': false});
    removeLikeFromActivityFeed(postId, ownerId, talk, senderName);
  }

  static Future<void> addLikeToActivityFeed(String postId, String ownerId,
      String discussion, String senderName, String category) async {
    // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
    bool isNotPostOwner = auth.currentUser!.uid != ownerId;
    if (isNotPostOwner) {
      DocumentReference _docRef =
          root.collection('feed').doc(ownerId).collection('feeds').doc();
      await _docRef.set({
        "type": category,
        "userId": auth.currentUser!.uid,
        "seen": false,
        "commentData": 'liked Video',
        "discussion": discussion,
        "ownerId": ownerId,
        "category": category,
        "postId": postId,
        'createdAt': createdAt,
        "timestamp": timestamp,
        "username": senderName,
      });
    }
  }

  static void removeLikeFromActivityFeed(
      String postId, String ownerId, String videoUrl, String senderName) {
    bool isNotPostOwner = auth.currentUser!.uid != ownerId;

    if (isNotPostOwner) {
      root.collection('feed').doc(postId).get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }
  }

  static void sendGeneralNotification(
      String postId,
      String ownerId,
      String discussion,
      String senderName,
      String category,
      String type,
      commentData) {
    // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
    bool isNotPostOwner = auth.currentUser!.uid != ownerId;
    if (isNotPostOwner) {
      DocumentReference _docRef =
          root.collection('feed').doc(ownerId).collection('feeds').doc();
      _docRef.set({
        "type": type, //type of notification
        "userId": auth.currentUser!.uid,
        "seen": false,
        "commentData": commentData, //comment made
        "discussion": discussion, //the main discussion comment was made on
        "ownerId": ownerId,
        "category": category,
        "postId": postId,
        'createdAt': createdAt,
        "timestamp": timestamp,
        "username": senderName,
      });
    }
  }
}
