import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/community/data/report_model.dart';

import '../../../../core/themes/theme_colors.dart';

class UsersReports extends StatefulWidget {
  const UsersReports({Key? key}) : super(key: key);

  @override
  State<UsersReports> createState() => _UsersReportsState();
}

class _UsersReportsState extends State<UsersReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        title: Text(
          'Users Reports',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme:
            const IconThemeData(color: ThemeColors.blackColor1, size: 35),
      ),
      backgroundColor: ThemeColors.whiteColor,
      body: PaginateFirestore(
        onEmpty: Container(
          margin: const EdgeInsets.only(top: 170),
          child: const Center(
            child: Text(
              'No User post',
            ),
          ),
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemsPerPage: 15,
        itemBuilder: (context, snapshot, index) {
          ReportModel report = ReportModel.fromSnapshot(snap: snapshot[index]);

          return Container(
              margin: const EdgeInsets.only(
                left: 3.0,
                right: 3.0,
                bottom: 5.0,
              ),
              padding: const EdgeInsets.only(
                right: 5.5,
                left: 5.5,
                top: 5.5,
                bottom: 5.5,
              ),
              decoration: const BoxDecoration(
                color: Colors.white, //for now
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(0.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(report.reporterName!,
                            style: const TextStyle(
                              color: ThemeColors.primaryColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                        const Text(' reported a post',
                            style: TextStyle(
                              color: ThemeColors.primaryColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(getTimestamp(report.createdAt!),
                            style: const TextStyle(
                              color: ThemeColors.blackColor1,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Post Owner: ',
                            style: TextStyle(
                              color: ThemeColors.blueColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(report.ownerName!,
                            style: const TextStyle(
                              color: ThemeColors.blackColor1,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Reason: ',
                            style: TextStyle(
                              color: ThemeColors.blueColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(report.reportTitle!,
                            maxLines: 2,
                            style: const TextStyle(
                              color: ThemeColors.blackColor1,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Requested Actions: ',
                            style: TextStyle(
                              color: ThemeColors.blueColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(report.reportActions!,
                            maxLines: 2,
                            style: const TextStyle(
                              color: ThemeColors.blackColor1,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ))
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(report.status!,
                          style: const TextStyle(
                            color: ThemeColors.blackColor1,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          )),
                    )
                  ]));
        },
        // orderBy is compulsory to enable pagination
        query: reportRef
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .orderBy('timestamp', descending: true),
        isLive: true,

        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
