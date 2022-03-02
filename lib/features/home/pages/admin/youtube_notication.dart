import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/notification/notification_type.dart';

class LivestreamNotification extends StatefulWidget {
  static const String id = 'LivestreamNotification';
  const LivestreamNotification({Key? key}) : super(key: key);

  @override
  _LivestreamNotificationState createState() => _LivestreamNotificationState();
}

class _LivestreamNotificationState extends State<LivestreamNotification> {
  final _title = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0.0, 2.5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const PostLabel(label: 'Livestream Title'),
                const SizedBox(height: 9.5),
                PostTextFeild(
                  height: 100,
                  isBorder: false,
                  capitalization: TextCapitalization.sentences,
                  hint: 'Type in the Title',
                  maxLines: 5, //fix
                  textController: _title,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: PrimaryButton(
                    width: 150,
                    height: 36.5,
                    blurRadius: 3.0,
                    roundedEdge: 5.0,
                    color: Colors.pink,
                    buttonTitle: 'Send Notification',
                    onTap: () async {
                      if (_title.text != '') {
                        await usersRef.get().then((value) {});
                        var result = await usersRef.get();
                        for (var res in result.docs) {
                          DocumentReference _docRef =
                              root.collection('live').doc();
                          CommunityDB.sendGeneralNotification(
                              _docRef.id,
                              res.id,
                              _title.text,
                              auth.currentUser!.displayName!,
                              'livestream',
                              NotificationType.livestream,
                              _title.text);
                        }
                        successToastMessage(
                            msg: 'livestream Notification sent');
                        Navigator.of(context).pop();
                      } else {
                        errorToastMessage(
                            msg: 'Title of Notification cannot be empty');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostTextFeild extends StatelessWidget {
  const PostTextFeild(
      {Key? key,
      required this.hint,
      required this.height,
      required this.maxLines,
      required this.textController,
      required bool isBorder,
      required this.capitalization})
      : super(key: key);
  final String hint;
  final double height;
  final int maxLines;
  final TextEditingController textController;
  final TextCapitalization capitalization;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        maxLines: maxLines,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        controller: textController,
      ),
    );
  }
}

class PostLabel extends StatelessWidget {
  const PostLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
