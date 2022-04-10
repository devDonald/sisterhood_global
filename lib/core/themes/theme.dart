import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: ThemeColors.whiteColor,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: ThemeColors.whiteColor,
        fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: ThemeColors.purpleColor,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: ThemeColors.primaryPink300,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: ThemeColors.blackColor1,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: ThemeColors.primaryPink300,
        ));
  }
}
