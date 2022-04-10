import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 5,
          backgroundColor: ThemeColors.primaryGreyColor,
        ),
        SizedBox(height: 10),
        Text(
          'Loading Please Wait',
          style: TextStyle(
            color: ThemeColors.primaryGreyColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
