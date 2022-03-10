import 'package:flutter/material.dart';
import 'package:janguask_app_v2/presentation_layer/themes/theme_colors.dart';

class AppBarButtonIcon extends StatelessWidget {
  const AppBarButtonIcon({
    this.onTap,
    this.icon,
  });
  final Function onTap;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      width: 36.5,
      height: 36.5,
      child: Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: JanguAskColors.primaryGreyColor.withOpacity(0.05),
        child: InkWell(
          child: icon,
          onTap: onTap,
        ),
      ),
    );
  }
}
