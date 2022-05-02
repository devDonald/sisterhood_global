import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/features/home/pages/admin/create_event.dart';

import '../../../../core/widgets/display_event.dart';

class EventHome extends StatefulWidget {
  EventHome({Key? key}) : super(key: key);

  @override
  _EventHomeState createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('All Events', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream:
                eventsRef.orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("Loading..."),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("Loading..."),
                );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap = snapshot.data!.docs[index];

                    return EventList(
                      eventTitle: snap['title'],
                      description: snap['description'],
                      onDeleteTap: () {
                        showDeleteDialog(context, snap['postId']);
                      },
                      onTapEvent: () {
                        Get.to(ViewAttachedImage(
                          image: CachedNetworkImageProvider(snap['imageUrl']),
                          text: snap['title'],
                          url: snap['imageUrl'],
                        ));
                      },
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeColors.blackColor1,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const CreateEvent());
        },
      ),
    );
  }
}

class EventList extends StatelessWidget {
  EventList({
    Key? key,
    required this.description,
    required this.eventTitle,
    required this.onDeleteTap,
    required this.onTapEvent,
  }) : super(key: key);
  String eventTitle;
  String description;
  Function() onDeleteTap, onTapEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapEvent,
      child: ListTile(
        leading: const Icon(
          Icons.event_note,
          color: ThemeColors.blackColor1,
        ),
        title: Text(
          eventTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        subtitle: Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: ThemeColors.primaryGreyColor,
            fontSize: 13.5,
          ),
        ),
        trailing: GestureDetector(
          onTap: onDeleteTap,
          child: const Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}

showDeleteDialog(BuildContext context, String eventId) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("yes"),
    onPressed: () async {
      await eventsRef.doc(eventId).get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      }).then((value) async {
        Fluttertoast.showToast(
            msg: "Event removed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      });
    },
  );
  Widget continueButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Event"),
    content: Text("Would you like to remove this Event?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
