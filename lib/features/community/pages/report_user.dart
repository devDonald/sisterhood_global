import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/community/data/report_model.dart';

import '../../../core/themes/theme_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/community_database.dart';

class ReportPost extends StatefulWidget {
  final String ownerId, postId, ownerName;
  static const String id = 'ReportPost';
  ReportPost(
      {Key? key,
      required this.ownerId,
      required this.postId,
      required this.ownerName})
      : super(key: key);

  @override
  _ReportPostState createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
  final reportTitle = TextEditingController();
  final reportDetails = TextEditingController();
  final _recommendations = TextEditingController();

  sendReport() async {
    ReportModel model = ReportModel(
      createdAt: createdAt,
      timestamp: timestamp,
      reportTitle: reportTitle.text,
      reportDetails: reportDetails.text,
      ownerId: widget.ownerId,
      reportActions: _recommendations.text,
      status: 'Pending Action',
      actionsTaken: 'Reviewing',
      postId: widget.postId,
      reporterName: auth.currentUser!.displayName,
      ownerName: widget.ownerName,
      userId: auth.currentUser!.uid,
    );
    await CommunityDB.addReport(model);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Post', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 15.0,
            left: 10,
            right: 10,
            bottom: 30, //fNow
          ),
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 20,
            bottom: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0.0, 2.5),
                color: ThemeColors.shadowColor,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 22),
              TextFormField(
                controller: reportTitle,
                decoration: const InputDecoration(
                  hintText: 'Report Title',
                  hintStyle: TextStyle(
                    color: ThemeColors.primaryGreyColor,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: reportDetails,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Report Details',
                  hintStyle: TextStyle(
                    color: ThemeColors.primaryGreyColor,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _recommendations,
                decoration: const InputDecoration(
                  hintText: 'Recommended Actions',
                  hintStyle: TextStyle(
                    color: ThemeColors.primaryGreyColor,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 49),
              Align(
                alignment: Alignment.bottomRight,
                child: PrimaryButton(
                  onTap: () async {
                    if (reportTitle.text != '' &&
                        reportDetails.text != '' &&
                        _recommendations.text != '') {
                      sendReport();
                    } else {
                      errorToastMessage(msg: 'all fields must be completed');
                    }
                  },
                  buttonTitle: 'Send Report',
                  color: ThemeColors.primaryColor,
                  blurRadius: 3,
                  roundedEdge: 5,
                  width: double.infinity,
                  height: 36.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
