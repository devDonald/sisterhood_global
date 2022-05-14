import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';
import 'package:sisterhood_global/features/profile/pages/edit_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class OverViewBioCard extends StatelessWidget {
  const OverViewBioCard({
    Key? key,
    required this.bio,
    required this.email,
    required this.phone,
    required this.isOwner,
    required this.marital,
  }) : super(key: key);
  final String bio;
  final String email;
  final String phone, marital;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(
              0.0,
              4.0,
            ),
            color: ThemeColors.shadowColor,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bio',
                style: TextStyle(
                  color: ThemeColors.blackColor1,
                  fontWeight: JanguAskFontWeight.kBoldText,
                  fontSize: 18,
                ),
              ),
              isOwner
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => EditProfile(marital: marital));
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Edit Bio',
                            style: TextStyle(
                              color: ThemeColors.pink,
                              fontWeight: JanguAskFontWeight.kBoldText,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.edit,
                            color: ThemeColors.pink,
                            size: 17,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            bio,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Gender',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Female',
            style: TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Marital Status',
            style: TextStyle(
              color: ThemeColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            marital,
            style: const TextStyle(
              color: ThemeColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 15.0),
          GestureDetector(
            onTap: () {
              launch('tel:$phone');
            },
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: ThemeColors.blackColor1,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  phone,
                  style: const TextStyle(
                    color: ThemeColors.primaryGreyColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const Icon(
                Icons.email,
                color: ThemeColors.blackColor1,
                size: 18,
              ),
              const SizedBox(width: 12),
              Text(
                email,
                style: const TextStyle(
                  color: ThemeColors.primaryGreyColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
