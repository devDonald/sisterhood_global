import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? title, description, date, venue, imageUrl, createdAt, postId;

  EventModel({
    this.title,
    this.description,
    this.date,
    this.venue,
    this.imageUrl,
    this.createdAt,
    this.postId,
  });

  EventModel.fromSnapshot(DocumentSnapshot snap) {
    description = snap['description'];
    date = snap['date'];
    title = snap['title'];
    venue = snap['venue'];
    imageUrl = snap['imageUrl'];
    createdAt = snap['createdAt'];
    postId = snap['postId'];
  }
}
