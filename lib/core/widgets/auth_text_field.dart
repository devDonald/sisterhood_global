import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField({
    this.width,
    Key? key,
    this.label,
    required this.controller,
    this.textCapitalization,
    this.keyBoardType,
    this.obsecureText,
    this.textInputAction,
    this.maxLength,
  }) : super(key: key);
  final double? width;
  final String? label;
  bool? obsecureText;
  final TextEditingController controller;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (label != null)
              ? RichText(
                  text: TextSpan(
                    text: (label != null) ? label : '',
                    style: const TextStyle(
                      color: JanguAskColors.primaryGreyColor,
                      fontFamily: JanguAskFontFamily.primaryFontNunito,
                      fontWeight: JanguAskFontWeight.kBoldText,
                      fontSize: 15.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: (label != null) ? '*' : '',
                        style: const TextStyle(
                          color: JanguAskColors.primaryColor,
                          fontFamily: JanguAskFontFamily.primaryFontNunito,
                          fontWeight: JanguAskFontWeight.kBoldText,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(height: 0),
          (label != null) ? const SizedBox(height: 10) : Container(height: 0),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: JanguAskColors.whiteColor,
              borderRadius: BorderRadius.circular(2.5),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 7.5,
                  offset: Offset(0.0, 2.5),
                  color: JanguAskColors.shadowColor,
                )
              ],
            ),
            width: width,
            // width: double.infinity,
            // height: 40.0,
            child: TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: (textInputAction != null)
                  ? textInputAction
                  : TextInputAction.done,
              obscureText: (obsecureText! != null) ? obsecureText! : false,
              keyboardType:
                  (keyBoardType != null) ? keyBoardType : TextInputType.name,
              textCapitalization: (textCapitalization! != null)
                  ? textCapitalization!
                  : TextCapitalization.none,
              maxLength: (maxLength != null) ? maxLength : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
