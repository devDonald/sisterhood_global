import 'dart:core';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';

class CountryCodeButton extends StatefulWidget {
  const CountryCodeButton({
    Key? key,
    this.countryCode,
    this.initialCode,
    this.onChanged,
    this.onInit,
    this.height,
    required this.onSelectCode,
    this.code,
  }) : super(key: key);
  final CountryCode? countryCode;
  final String? initialCode, code;
  final Function? onChanged;
  final Function? onInit;
  final Function onSelectCode;
  final double? height;

  @override
  _CountryCodeButtonState createState() => _CountryCodeButtonState();
}

class _CountryCodeButtonState extends State<CountryCodeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
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
      // width: double.infinity,
      height: (widget.height != null) ? widget.height : 47.5,

      child: Center(
        child: CountryCodePicker(
          onChanged: (CountryCode code) {
            print(code.name);
            print(code.dialCode);
            print(code.code);
            widget.onSelectCode(code.dialCode, code.code, code.name);
          },

          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection:
              (widget.initialCode != null) ? widget.initialCode : 'NG',

          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,

          // optional. aligns the flag and the Text left
          alignLeft: true,
          flagWidth: 18.5,
          textStyle: const TextStyle(
            color: JanguAskColors.primaryGreyColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
          padding: const EdgeInsets.only(
            top: 7.0,
            bottom: 7.0,
            left: 10.0,
            right: 10.0,
          ),
        ),
      ),
    );
  }
}
