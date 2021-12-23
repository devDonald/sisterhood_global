import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';

class FilesDropDownButton extends StatelessWidget {
  const FilesDropDownButton({
    Key? key,
    required this.hint,
    required this.onChanged,
    required this.items,
    required this.value,
    this.isBorder,
  }) : super(key: key);
  final Widget hint;
  final Function(String?) onChanged;
  final List<String> items;
  final String value;
  final bool? isBorder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: hint,
      value: value,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 25.0,
      elevation: 0,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        border: (isBorder != null)
            ? (isBorder!)
                ? const OutlineInputBorder()
                : const OutlineInputBorder(borderSide: BorderSide.none)
            : const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.category,
    required this.noOfApplaud,
    required this.noOfComment,
    required this.question,
    required this.timeOfPost,
    required this.ownerId,
    required this.userName,
    required this.userPhoto,
    this.isApplauded = false,
    required this.onTapComment,
    required this.applaudColor,
    required this.onPostTap,
    this.isOwner = false,
    required this.onUserTap,
    required this.postId,
    required this.onTap,
  }) : super(key: key);
  final String category;
  final String question;
  final String userName;
  final String userPhoto;
  final String noOfApplaud;
  final String noOfComment;
  final String timeOfPost;
  final String ownerId;
  final bool isApplauded, isOwner;
  final String postId;
  final Function() onTapComment;
  final Function() onPostTap;
  final Function() onUserTap, onTap;
  final Color applaudColor;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  GlobalKey btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isApplaud = widget.isApplauded;
    return Container(
      width: double.infinity,
      // height: 320.5,
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 15.0,
      ),
      padding: const EdgeInsets.all(
        12.2,
      ),
      decoration: BoxDecoration(
        color: JanguAskColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.5),
            blurRadius: 3.0,
            color: JanguAskColors.shadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //subject
              GestureDetector(
                onTap: widget.onUserTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ProfilePicture(
                      image: NetworkImage(
                        widget.userPhoto,
                      ),
                      width: 30.0,
                      height: 29.5,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.userName,
                      // maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: JanguAskColors.primaryGreyColor,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 12.0,
                        fontFamily: JanguAskFontFamily.secondaryFontLato,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                  ],
                ),
              ),
              //level
            ],
          ),
          const Divider(
            height: 20,
            color: JanguAskColors.pinkishGreyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onPostTap,
                child: SizedBox(
                  width: 182.0,
                  child: Text(
                    widget.question,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: JanguAskFontWeight.kBoldText,
                    ),
                  ),
                ),
              ),
              DeleteEditPopUp(
                delete: () async {
                  await communityRef
                      .doc(widget.postId)
                      .delete()
                      .then((value) {});
                  Navigator.of(context).pop();
                },
                isOwner: widget.isOwner, edit: () {}, // widget.isOwner,
              )
            ],
          ), //title

          const SizedBox(height: 17.5),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.noOfApplaud,
                style: const TextStyle(
                  color: JanguAskColors.primaryGreyColor,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 15.0),
              Text(
                widget.noOfComment,
                style: const TextStyle(
                  color: JanguAskColors.primaryGreyColor,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),

          const Divider(
            height: 2,
            color: JanguAskColors.pinkishGreyColor,
          ),
          const SizedBox(height: 5.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.timer,
                    size: 14.6,
                    color: JanguAskColors.primaryGreyColor,
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    (widget.timeOfPost != null) ? widget.timeOfPost : '',
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: JanguAskColors.primaryGreyColor,
                    ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //applaud
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isApplaud == false) {
                            CommunityDB.handleDiscussionLikes(
                              widget.postId,
                              widget.ownerId,
                              widget.question,
                              auth.currentUser!.displayName!,
                              widget.category
                            );
                            isApplaud = true;
                          } else {
                            CommunityDB.handleDiscussionUnlike(
                              widget.postId,
                              widget.ownerId,
                              widget.question,
                              auth.currentUser!.displayName!,
                              widget.category
                            );
                            isApplaud = false;
                          }
                        });
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.heart,
                              size: 18.8,
                              color: isApplaud
                                  ? Colors.pink
                                  : JanguAskColors.primaryGreyColor,
                            ),
                            SizedBox(width: 3.0),
                            const Text(
                              'Like',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: JanguAskColors.primaryGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22.5,
                    ),
                    //comment
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.comment,
                              size: 15.6,
                              color: JanguAskColors.primaryGreyColor,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'Comment',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: JanguAskColors.primaryGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserSearchTile extends StatelessWidget {
  const UserSearchTile(
      {Key? key,
      required this.onTap,
      required this.userName,
      required this.profileImage,
      required this.country})
      : super(key: key);
  final Function() onTap;
  final String userName;
  final String profileImage, country;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ProfilePicture(
        image: CachedNetworkImageProvider(
          profileImage,
        ),
        width: 40,
        height: 40,
      ),
      title: Text(userName),
      trailing: Text(country),
    );
  }
}

class DeleteEditPopUp extends StatelessWidget {
  const DeleteEditPopUp({
    Key? key,
    required this.delete,
    required this.edit,
    this.isEditable = false,
    this.isOwner = false,
  }) : super(key: key);
  final Function() delete;
  final Function() edit;
  final bool isEditable, isOwner;
  @override
  Widget build(BuildContext context) {
    return (isOwner)
        ? PopupMenuButton(
            itemBuilder: (context) {
              var list = <PopupMenuEntry<Object>>[];
              list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 17,
                        color: JanguAskColors.primaryGreyColor,
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: delete,
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: JanguAskColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              );
              (isEditable)
                  ? list.add(
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 17,
                              color: JanguAskColors.primaryGreyColor,
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: edit,
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: JanguAskColors.brownishGrey,
                                  fontSize: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                        value: 1,
                      ),
                    )
                  : Container();

              return list;
            },
            icon: Icon(
              Icons.more_horiz,
              size: 20,
              color: JanguAskColors.primaryGreyColor,
            ),
          )
        : Container();
  }
}
