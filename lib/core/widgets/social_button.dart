import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.platformName,
    required this.platformIcon,
    required this.color,
    required this.onTap,
  }) : super(key: key);
  final void Function() onTap;
  final String platformIcon;
  final String platformName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.0,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.30),
              blurRadius: 7.5,
            ),
          ],
          borderRadius: BorderRadius.circular(2.5),
          color: (color != null) ? color : JanguAskColors.blueColor,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 20,
              child: SvgPicture.asset(
                platformIcon,
                width: 27.0,
                height: 27.0,
              ),
            ),
            Center(
              child: Text(
                platformName,
                style: const TextStyle(
                  color: JanguAskColors.whiteColor,
                  fontWeight: JanguAskFontWeight.kBoldText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
