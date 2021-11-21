import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';
import 'package:sisterhood_global/features/profile/pages/edit_profile.dart';

class OverViewBioCard extends StatelessWidget {
  const OverViewBioCard({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.gender,
  }) : super(key: key);
  final String name;
  final String email;
  final String phone;
  final String country;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: JanguAskColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            offset: Offset(
              0.0,
              4.0,
            ),
            color: JanguAskColors.shadowColor,
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
                'Name',
                style: TextStyle(
                  color: JanguAskColors.blackColor1,
                  fontWeight: JanguAskFontWeight.kBoldText,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => EditProfile());
                },
                child: Row(
                  children: const [
                    Text(
                      'Edit Bio',
                      style: TextStyle(
                        color: JanguAskColors.kellyGreen,
                        fontWeight: JanguAskFontWeight.kBoldText,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.edit,
                      color: JanguAskColors.kellyGreen,
                      size: 17,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            name,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: JanguAskColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            'Country',
            style: TextStyle(
              color: JanguAskColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            country,
            style: TextStyle(
              color: JanguAskColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            'Gender',
            style: TextStyle(
              color: JanguAskColors.blackColor1,
              fontWeight: JanguAskFontWeight.kBoldText,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            gender,
            style: TextStyle(
              color: JanguAskColors.primaryGreyColor,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: JanguAskColors.primaryGreyColor,
                size: 18,
              ),
              SizedBox(width: 12),
              Text(
                phone,
                style: TextStyle(
                  color: JanguAskColors.primaryGreyColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Icon(
                Icons.email,
                color: JanguAskColors.primaryGreyColor,
                size: 18,
              ),
              SizedBox(width: 12),
              Text(
                email,
                style: TextStyle(
                  color: JanguAskColors.primaryGreyColor,
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
