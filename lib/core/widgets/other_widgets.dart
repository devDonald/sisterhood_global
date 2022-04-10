import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';
import 'package:sisterhood_global/core/widgets/profile_picture.dart';
import 'package:sisterhood_global/features/community/data/community_database.dart';
import 'package:sisterhood_global/features/community/pages/report_user.dart';

import '../../features/home/pages/view_event_image.dart';
import 'linkify_text_widget.dart';

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
    required this.isOwner,
    required this.isVerified,
    required this.isPinned,
    required this.onUserTap,
    required this.postId,
    required this.withImage,
    required this.imageUrl,
    required this.isAdmin,
  }) : super(key: key);
  final String category;
  final String question;
  final String userName;
  final String userPhoto;
  final String noOfApplaud;
  final String noOfComment;
  final String timeOfPost;
  final String ownerId, imageUrl;
  final bool isApplauded, isOwner, withImage, isVerified, isAdmin, isPinned;
  final String postId;
  final Function() onTapComment;
  final Function() onUserTap;
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
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.5),
            blurRadius: 3.0,
            color: ThemeColors.primaryColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //subject
              GestureDetector(
                onTap: widget.onUserTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ProfilePicture(
                      image: CachedNetworkImageProvider(
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
                        color: ThemeColors.primaryGreyColor,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 12.0,
                        fontFamily: JanguAskFontFamily.secondaryFontLato,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                  ],
                ),
              ),
              widget.isAdmin
                  ? AdminPopUp(
                      deleteTap: () async {
                        Get.defaultDialog(
                          title: 'Delete Post',
                          middleText: 'Do you want to delete this post?',
                          barrierDismissible: false,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                await communityRef
                                    .doc(widget.postId)
                                    .delete()
                                    .then((value) {
                                  successToastMessage(
                                      msg: 'Post Deleted Successfully');
                                });
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Confirm')),
                        );
                      },
                      editTap: () {},
                      pinTap: () async {
                        Get.defaultDialog(
                          title: widget.isPinned ? 'Unpin Post' : 'Pin Post',
                          middleText: widget.isPinned
                              ? 'Do you want to Unpin this post?'
                              : 'Do you want to Pin this post?',
                          barrierDismissible: true,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                await communityRef.doc(widget.postId).update({
                                  "isPinned": widget.isPinned ? false : true
                                });
                                successToastMessage(
                                    msg: widget.isPinned
                                        ? 'post unpinned'
                                        : 'post pinned');
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Confirm')),
                        );
                      },
                      isOwner: true,
                      isPinned: widget.isPinned,
                      isApproved: widget.isVerified,
                      approveTap: () async {
                        Get.defaultDialog(
                          title: widget.isVerified
                              ? 'UnApprove Post'
                              : 'Approve Post',
                          middleText: widget.isVerified
                              ? 'Do you want to UnApprove this post?'
                              : 'Do you want to Approve this post?',
                          barrierDismissible: true,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                await communityRef.doc(widget.postId).update({
                                  "isApproved": widget.isVerified ? false : true
                                });
                                successToastMessage(
                                    msg: widget.isVerified
                                        ? 'post unapproved'
                                        : 'post approved');
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Confirm')),
                        );
                      })
                  : DeleteEditPopUp(
                      delete: () async {
                        Get.defaultDialog(
                          title: 'Delete Post',
                          middleText: 'Do you want to delete this post?',
                          barrierDismissible: false,
                          radius: 25,
                          cancel: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                              )),
                          confirm: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green),
                              onPressed: () async {
                                await communityRef
                                    .doc(widget.postId)
                                    .delete()
                                    .then((value) {});
                                successToastMessage(
                                    msg: 'Post Deleted Successfully');
                                Get.back();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Confirm')),
                        );
                        //Navigator.of(context).pop();
                      },
                      isOwner: widget.isOwner, edit: () {},
                      report: () {
                        Get.to(() => ReportPost(
                            ownerId: widget.ownerId,
                            postId: widget.postId,
                            ownerName: widget.userName));
                      }, // widget.isOwner,
                    )
              //level
            ],
          ),

          const Divider(
            height: 20,
            color: ThemeColors.pinkishGreyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onTapComment,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.750,
                    child: LinkifyTextWidget(
                      scroll: const NeverScrollableScrollPhysics(),
                      messageContent: widget.question,
                      maxLength: 6,
                    ),
                  ),
                ),
              ),
            ],
          ), //title
          const SizedBox(height: 5),

          // widget.question.length > 200
          //     ? GestureDetector(
          //         onTap: widget.onTapComment, child: const Text('Show More'))
          //     : Container(),
          GestureDetector(
              onTap: widget.onTapComment, child: const Text('Show More')),
          const SizedBox(height: 17.5),
          widget.withImage
              ? Center(
                  child: GestureDetector(
                      onTap: () {
                        Get.to(ViewAttachedImage(
                          image: CachedNetworkImageProvider(widget.imageUrl),
                          text: '',
                          url: widget.imageUrl,
                        ));
                      },
                      child: CachedNetworkImage(imageUrl: widget.imageUrl)),
                )
              : Container(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: widget.isVerified
                    ? Image.asset(
                        'images/verified.jpeg',
                        width: 50,
                        height: 40,
                      )
                    : Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.noOfApplaud,
                    style: const TextStyle(
                      color: ThemeColors.primaryGreyColor,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    widget.noOfComment,
                    style: const TextStyle(
                      color: ThemeColors.primaryGreyColor,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 5.0),

          const Divider(
            height: 2,
            color: ThemeColors.pinkishGreyColor,
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
                    color: ThemeColors.primaryGreyColor,
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    widget.timeOfPost,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: ThemeColors.primaryGreyColor,
                    ),
                  ),
                ],
              ),
              Row(
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
                              widget.category);
                          isApplaud = true;
                        } else {
                          CommunityDB.handleDiscussionUnlike(
                              widget.postId,
                              widget.ownerId,
                              widget.question,
                              auth.currentUser!.displayName!,
                              widget.category);
                          isApplaud = false;
                        }
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.heart,
                          size: 18.8,
                          color: isApplaud
                              ? Colors.pink
                              : ThemeColors.primaryGreyColor,
                        ),
                        const SizedBox(width: 3.0),
                        const Text(
                          'Like',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ThemeColors.primaryGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 22.5,
                  ),
                  //comment
                  GestureDetector(
                    onTap: widget.onTapComment,
                    child: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.comment,
                          size: 15.6,
                          color: ThemeColors.primaryGreyColor,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Comment',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: ThemeColors.primaryGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserSearchTile extends StatelessWidget {
  const UserSearchTile({
    Key? key,
    required this.onTap,
    required this.userName,
    required this.profileImage,
    required this.country,
  }) : super(key: key);
  final Function() onTap;
  final String userName;
  final String profileImage, country;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            onTap: onTap,
            leading: ProfilePicture(
              image: CachedNetworkImageProvider(
                profileImage,
              ),
              width: 40,
              height: 40,
            ),
            title: Text(userName,
                style: const TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            subtitle: Text(
              country,
              style: const TextStyle(color: Colors.black54),
            )),
        const Divider(
          height: 1,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class UserSearchFollow extends StatelessWidget {
  const UserSearchFollow({
    Key? key,
    this.onTap,
    this.userName,
    this.country,
    this.profileImage,
    this.isFollowing = false,
    this.onFollow,
  }) : super(key: key);
  final Function()? onTap, onFollow;
  final String? userName;
  final String? country;
  final String? profileImage;
  final bool? isFollowing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ProfilePicture(
        image: CachedNetworkImageProvider(
          profileImage ?? '',
        ),
        width: 40,
        height: 40,
      ),
      title: Text((userName!)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(country!),
          const SizedBox(height: 5),
          //Text(state!),
        ],
      ),
      trailing: GestureDetector(
        onTap: onFollow,
        child: Container(
          width: 86,
          height: 33,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            color: (isFollowing!)
                ? ThemeColors.primaryPink300
                : ThemeColors.kellyGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
              child: Text(
            (isFollowing!) ? 'Following' : 'Follow',
            style: const TextStyle(
              color: ThemeColors.whiteColor,
              fontSize: 12,
            ),
          )),
        ),
      ),
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
    required this.report,
  }) : super(key: key);
  final Function() delete;
  final Function() edit, report;
  final bool isEditable, isOwner;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        isOwner
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: delete,
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
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
        (isEditable)
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: edit,
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
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

        !isOwner
            ? list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.report_outlined,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: report,
                        child: const Text(
                          "Report Post",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              )
            : null;
        return list;
      },
      icon: const Icon(
        Icons.more_horiz,
        size: 20,
        color: ThemeColors.primaryGreyColor,
      ),
    );
  }
}

class AdminPopUp extends StatelessWidget {
  const AdminPopUp({
    Key? key,
    required this.deleteTap,
    required this.editTap,
    this.isEditable = false,
    this.isOwner = false,
    required this.pinTap,
    required this.approveTap,
    this.isPinned = false,
    this.isApproved = false,
  }) : super(key: key);
  final Function() deleteTap;
  final Function() editTap, pinTap, approveTap;
  final bool isEditable, isOwner, isPinned, isApproved;
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
                      const Icon(
                        Icons.delete,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: deleteTap,
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: ThemeColors.brownishGrey,
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
                            const Icon(
                              Icons.edit,
                              size: 17,
                              color: ThemeColors.primaryGreyColor,
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: editTap,
                              child: const Text(
                                "Edit Post",
                                style: TextStyle(
                                  color: ThemeColors.brownishGrey,
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

              list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: approveTap,
                        child: Text(
                          isApproved ? "UnApprove Post" : "Approve Post",
                          style: const TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              );

              list.add(
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.pin_drop,
                        size: 17,
                        color: ThemeColors.primaryGreyColor,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: pinTap,
                        child: Text(
                          isPinned ? "UnPin Post" : "Pin Post",
                          style: const TextStyle(
                            color: ThemeColors.brownishGrey,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  value: 1,
                ),
              );
              return list;
            },
            icon: const Icon(
              Icons.more_horiz,
              size: 20,
              color: ThemeColors.primaryGreyColor,
            ),
          )
        : Container();
  }
}
