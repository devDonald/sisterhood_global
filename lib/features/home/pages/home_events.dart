import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/widgets/files_widgets.dart';
import 'package:sisterhood_global/features/home/data/eventsModel.dart';

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
    return Container(
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
        child: Container(
            child: RefreshIndicator(
          child: PaginateFirestore(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemsPerPage: 20,
            itemBuilder: (index, context, snap) {
              EventModel model = EventModel.fromSnapshot(snap);
              return eventDetail(model.title!, model.date!, model.venue!,
                  model.imageUrl!, context);
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
        )));
  }
}
