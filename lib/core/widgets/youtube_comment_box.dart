// import 'package:flutter/material.dart';
// import 'package:paginate_firestore/paginate_firestore.dart';
//
// import '../../features/community/pages/talk_details.dart';
// import '../constants/contants.dart';
//
// class YoutubeCommentBox extends StatelessWidget {
//   final String videoID;
//   const YoutubeCommentBox({Key? key, required this.videoID}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomSheet: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height * 0.5,
//         margin: const EdgeInsets.all(15.0),
//         padding: const EdgeInsets.all(25.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 5.0,
//               offset: Offset(0.0, 2.5),
//             ),
//           ],
//         ),
//         child: ListView(
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           children: [
//             const SizedBox(
//               height: 5,
//             ),
//             PaginateFirestore(
//               shrinkWrap: true,
//               onEmpty: const Center(child: Text('no comments')),
//               physics: const BouncingScrollPhysics(),
//               itemsPerPage: 15,
//               itemBuilder: (context, snapshot, index) {
//                 return CommentBox(
//                     messageContent: snapshot[index]['messageContent'],
//                     senderName: snapshot[index]['senderName'],
//                     senderPhoto: snapshot[index]['photo'],
//                     timeOfMessage: getTimestamp(snapshot[index]['createdAt']));
//               },
//               // orderBy is compulsary to enable pagination
//               query: talkRef
//                   .doc(videoID)
//                   .collection('comments')
//                   .orderBy('timestamp', descending: false),
//               isLive: true,
//               itemBuilderType: PaginateBuilderType.listView,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
