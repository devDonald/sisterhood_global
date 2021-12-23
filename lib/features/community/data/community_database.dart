import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/community/data/community_model.dart';
import 'package:sisterhood_global/features/notification/notification_type.dart';

class CommunityDB {
  static addContemplation(CommunityModel todomodel) async {
    DocumentReference docRef = communityRef.doc();
    todomodel.postId = docRef.id;
    docRef.set(todomodel.toJson()).then((doc) async {
      successToastMessage(msg: 'Contemplation Added');
      await usersRef.get().then((value) {});
      var result = await usersRef.get();
      result.docs.forEach((res) {
        sendGeneralNotification(
            docRef.id,
            todomodel.ownerId!,
            todomodel.question!,
            auth.currentUser!.displayName!,
            todomodel.category!,
            NotificationType.prayer,
            'New Contemplation added');
      });
    }).catchError((onError) async {
      errorToastMessage(msg: onError.toString());
    });
  }

  static Stream<List<CommunityModel>> communityStream(String category) {
    return communityRef
        .where('category', isEqualTo: category)
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

  static updateCommunity(documentId, CommunityModel update) {
    communityRef.doc(documentId).update(update.communityUpdate());
  }

  static deleteCommunity(String documentId) {
    communityRef.doc(documentId).delete();
  }

  static void handleDiscussionLikes(String postId, String ownerId,
      String discussion, String senderName, String category) async {
    await communityRef
        .doc(postId)
        .update({'likes.${auth.currentUser!.uid}': true});

    addLikeToActivityFeed(postId, ownerId, discussion, senderName, category);
  }

  static void handleDiscussionUnlike(String postId, String ownerId,
      String discussion, String senderName, String category) async {
    await communityRef
        .doc(postId)
        .update({'likes.${auth.currentUser!.uid}': false});
    removeLikeFromActivityFeed(postId, ownerId, discussion, senderName);
  }

  static void addLikeToActivityFeed(String postId, String ownerId,
      String discussion, String senderName, String category) {
    // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
    bool isNotPostOwner = auth.currentUser!.uid != ownerId;
    if (isNotPostOwner) {
      root.collection('feed').doc(ownerId).collection('feeds').doc(postId).set({
        "type": NotificationType.prayerLike,
        "userId": auth.currentUser!.uid,
        "seen": false,
        "commentData": 'liked Video',
        "data": discussion,
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
      root.collection('feed').doc(ownerId).collection('feeds').doc(postId).set({
        "type": type,
        "userId": auth.currentUser!.uid,
        "seen": false,
        "commentData": commentData,
        "data": discussion,
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
