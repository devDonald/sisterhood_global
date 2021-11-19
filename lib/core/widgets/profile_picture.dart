import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_images.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    required this.image,
    required this.width,
    required this.height,
    this.border,
  }) : super(key: key);
  final ImageProvider image;
  final double width;
  final double height;
  final Border? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: (image != null)
              ? image
              : const AssetImage(JanguAskImages.dummyUserPhoto),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
        border: border,
      ),
    );
  }
}
