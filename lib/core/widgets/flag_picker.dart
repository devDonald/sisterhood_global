import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class FlagPicker extends StatelessWidget {
  const FlagPicker({
    Key? key,
    required this.flagCode,
  }) : super(key: key);
  final String flagCode;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 30,
      child: CountryCodePicker(
        padding: EdgeInsets.zero,
        // onInit: () {},
        initialSelection: flagCode,
        enabled: false,
        showCountryOnly: true,
        showFlag: true,
        hideMainText: true,
        showOnlyCountryWhenClosed: false,
        alignLeft: true,
        flagWidth: 30.5,
      ),
    );
  }
}
