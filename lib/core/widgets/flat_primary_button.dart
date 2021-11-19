import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

class FlatPrimaryButton extends StatelessWidget {
  const FlatPrimaryButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.info,
  }) : super(key: key);
  final Function() onTap;
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: (info != null) ? info : '',
          style: const TextStyle(
            color: JanguAskColors.blackColor1,
            fontFamily: JanguAskFontFamily.primaryFontNunito,
            fontSize: 15.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: (title != null) ? title : '',
              style: const TextStyle(
                color: JanguAskColors.primaryColor,
                fontFamily: JanguAskFontFamily.primaryFontNunito,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
