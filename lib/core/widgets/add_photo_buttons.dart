import 'package:flutter/material.dart';

import '../themes/theme_colors.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({
    Key? key,
    @required this.isPhotoAdded,
    @required this.fileImage,
    this.onClearTap,
    this.onAddImageTap,
  }) : super(key: key);

  final bool? isPhotoAdded;
  final Widget? fileImage;
  final Function()? onClearTap;
  final Function()? onAddImageTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 97.5,
      height: 85.0,
      color: ThemeColors.whiteLayerColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: isPhotoAdded!
                ? Container(
                    child: fileImage,
                  )
                : GestureDetector(
                    onTap: onAddImageTap,
                    child: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
          ),
          GestureDetector(
            onTap: onClearTap,
            child: Align(
              alignment: Alignment.topRight,
              child: isPhotoAdded!
                  ? Container(
                      decoration: const BoxDecoration(
                        color: ThemeColors.blackColor1,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: ThemeColors.whiteColor,
                        size: 15,
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
