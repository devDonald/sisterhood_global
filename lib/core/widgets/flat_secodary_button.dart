import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

class FlatSecondaryButton extends StatelessWidget {
  const FlatSecondaryButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        (title != null) ? title : '',
        style: TextStyle(
          color: (color != null) ? color : ThemeColors.primaryColor,
          fontWeight: JanguAskFontWeight.kBoldText,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
