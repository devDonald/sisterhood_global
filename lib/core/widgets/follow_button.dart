import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

import '../themes/theme_colors.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final Function() onFollow;
  const FollowButton(
      {Key? key, required this.isFollowing, required this.onFollow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15.0,
        bottom: 15.0,
      ),
      width: double.infinity,
      height: 45.5,
      padding: const EdgeInsets.all(
        5.0,
      ),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            offset: const Offset(
              0.0,
              2.5,
            ),
            color: ThemeColors.primaryColor.withOpacity(
              0.35,
            ),
          )
        ],
      ),
      child: GestureDetector(
        onTap: onFollow,
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.whiteColor,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: Text(
              isFollowing ? "Unfollow" : 'Follow',
              style: const TextStyle(
                color: ThemeColors.primaryColor,
                fontWeight: JanguAskFontWeight.kBoldText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
