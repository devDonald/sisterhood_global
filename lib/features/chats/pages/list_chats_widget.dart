import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';

class ChatListCard extends StatelessWidget {
  const ChatListCard(
      {Key? key,
      this.userName,
      this.currentMessage,
      this.time,
      required this.onTap,
      this.pics,
      this.isSeen})
      : super(key: key);
  final String? userName, currentMessage, time, pics;
  final Function() onTap;
  final bool? isSeen;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: ProfilePicture(
              image: CachedNetworkImageProvider(pics!),
              height: 50,
              width: 50,
            ),
            title: Text(
              userName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Row(
              children: [
                isSeen!
                    ? const Icon(
                        Icons.done_all,
                        size: 10,
                      )
                    : const Icon(
                        Icons.done,
                        size: 10,
                      ),
                const SizedBox(
                  width: 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    currentMessage!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
            trailing: Text(time!),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
