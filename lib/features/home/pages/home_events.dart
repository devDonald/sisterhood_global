import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/files_widgets.dart';
import 'package:sisterhood_global/features/home/data/events_model.dart';
import 'package:sisterhood_global/features/home/pages/view_event_image.dart';

class HomeEvents extends StatefulWidget {
  const HomeEvents({Key? key}) : super(key: key);

  @override
  State<HomeEvents> createState() => _HomeEventsState();
}

class _HomeEventsState extends State<HomeEvents> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.whiteColor,
      appBar: AppBar(
        elevation: 3.0,
        title: const Text('Events', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
        backgroundColor: ThemeColors.pink.shade400,
        titleSpacing: -5.0,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
              top: 17.5, bottom: 5.0, left: 7.0, right: 7.0),
          //padding: EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 2.5),
                blurRadius: 10.5,
              ),
            ],
          ),
          child: RefreshIndicator(
            child: PaginateFirestore(
              onEmpty: Center(child: const Text("No Events yet")),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemsPerPage: 10,
              itemBuilder: (context, snap, index) {
                EventModel model = EventModel.fromSnapshot(snap[index]);

                return EventDetail(
                  title: model.title!,
                  date: model.date!,
                  location: model.venue!,
                  imageUrl: model.imageUrl!,
                  eventTap: () {
                    Get.to(ViewAttachedImage(
                      image: CachedNetworkImageProvider(model.imageUrl!),
                      text: model.title!,
                      url: model.imageUrl!,
                    ));
                  },
                );
              },
              // orderBy is compulsary to enable pagination
              query: eventsRef.orderBy('timestamp', descending: true),
              isLive: true,
              listeners: [
                refreshChangeListener,
              ],
              itemBuilderType: PaginateBuilderType.listView,
            ),
            onRefresh: () async {
              refreshChangeListener.refreshed = true;
            },
          )),
    );
  }
}
