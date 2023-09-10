import 'package:flutter/material.dart';

class ThemeClass {
 
  Color lightPrimaryColor = Color(0xff8d1c40);
  Color lightSecondaryColor = Color(0xff8d1c40);
  Color accentColor = Colors.blue;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff8d1c40)),
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.lightPrimaryColor,
      secondary: _themeClass.lightSecondaryColor,
    ),
  );

}

ThemeClass _themeClass = ThemeClass();