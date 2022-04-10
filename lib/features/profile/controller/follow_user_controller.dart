import 'package:sisterhood_global/core/constants/contants.dart';

class FollowController {
  Future<void> followUser(String currentUser, String userToFollow,
      bool isFollowing, String username) async {
    if (isFollowing == true) {
      await usersRef
          .doc(userToFollow)
          .collection('followers')
          .doc(currentUser)
          .get()
          .then((doc) async {
        if (doc.exists) {
          doc.reference.delete();
        }
        await usersRef
            .doc(userToFollow)
            .update({'followersList.$currentUser': false});
      });
      await usersRef
          .doc(currentUser)
          .collection('following')
          .doc(userToFollow)
          .get()
          .then((doc) async {
        if (doc.exists) {
          doc.reference.delete();
        }
        await usersRef
            .doc(currentUser)
            .update({'followingList.$userToFollow': false});
      });
    } else {
      //follow the user
      await usersRef
          .doc(userToFollow)
          .collection('followers')
          .doc(currentUser)
          .set({}).then((doc) async {
        await usersRef
            .doc(userToFollow)
            .update({'followersList.$currentUser': true});
      });
      await usersRef
          .doc(currentUser)
          .collection('following')
          .doc(userToFollow)
          .set({}).then((doc) async {
        await usersRef
            .doc(currentUser)
            .update({'followingList.$userToFollow': true});
      });

      bool isNotPostOwner = currentUser != userToFollow;
      if (isNotPostOwner) {
        root
            .collection('feed')
            .doc(userToFollow)
            .collection('feeds')
            .doc()
            .set({
          "type": "Following",
          "userId": currentUser,
          "seen": false,
          "commentData": 'started following you',
          "ownerId": userToFollow,
          "postId": currentUser,
          'createdAt': createdAt,
          "category": 'following',
          "discussion": 'started following you',
          "timestamp": timestamp,
          "username": username,
        });
      }
    }
  }
}
