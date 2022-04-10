import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';

class AppBarButtonIcon extends StatelessWidget {
  const AppBarButtonIcon({
    this.onTap,
    this.icon,
  });
  final Function()? onTap;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      width: 36.5,
      height: 36.5,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: ThemeColors.primaryGreyColor.withOpacity(0.05),
        child: InkWell(
          child: icon,
          onTap: onTap,
        ),
      ),
    );
  }
}
