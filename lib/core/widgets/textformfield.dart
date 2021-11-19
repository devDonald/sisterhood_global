import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/widgets/responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextCapitalization capitalization;
  final IconData icon;
  double width;
  double pixelRatio;
  bool large;
  bool medium;

  CustomTextField({
    required this.hint,
    required this.textEditingController,
    required this.keyboardType,
    this.capitalization = TextCapitalization.sentences,
    required this.icon,
    this.pixelRatio = 0.0,
    this.width = 0.0,
    this.large = false,
    this.medium = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(width, pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(width, pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.orange[200],
        obscureText: obscureText,
        textCapitalization: capitalization,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange[200], size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
