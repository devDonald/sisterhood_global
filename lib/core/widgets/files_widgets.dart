import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';

Widget buildEventType(context) {
  return Container(
    margin: const EdgeInsets.only(
      left: 16.5,
      right: 16.5,
    ),
    padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
    width: double.infinity,
    height: 125.5,
    decoration: const BoxDecoration(
      color: JanguAskColors.whiteColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 4.5,
          offset: Offset(0.0, -3.5),
          color: JanguAskColors.shadowColor,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Column(
            children: const [
              Icon(
                Icons.video_collection,
                size: 50,
              ),
              Text('Video Event'),
            ],
          ),
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: const [
              Icon(
                Icons.photo,
                size: 50,
              ),
              Text('Image Event'),
            ],
          ),
        ),
      ],
    ),
  );
}

class DiscussOutlineButton extends StatelessWidget {
  const DiscussOutlineButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);
  final Function() onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 14.0,
          bottom: 14.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: child,
      ),
    );
  }
}

class EventDetail extends StatelessWidget {
  final String title, date, location, imageUrl;
  final Function() eventTap;
  const EventDetail(
      {Key? key,
      required this.title,
      required this.date,
      required this.location,
      required this.imageUrl,
      required this.eventTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: eventTap,
      child: Material(
        elevation: 5.0,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 5.0, left: 0.0, right: 0.0, bottom: 5.0),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height / 45),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.pink,
                          size: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 50,
                        ),
                        Text(
                          date,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height / 70),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.pink,
                          size: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 50,
                        ),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 4,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height / 70),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
              Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
