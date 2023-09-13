import 'package:flutter/material.dart';



//this is where the light theme comes from the dark theme is default dark theme 
//if you need to chang the dark theme colors and make your own it can be done here same way with the light theme
class ThemeClass {

  Color lightPrimaryColor = Colors.white;
  Color lightSecondaryColor = Colors.white;

  Color accentColor = Colors.blue;

  Color darkPrimaryColor = Colors.black;
  Color darkSecondaryColor = Colors.grey;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff8d1c40)),
    colorScheme: const ColorScheme.light().copyWith(
      primary: Color(0xff8d1c40),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff8d1c40)),
    colorScheme: const ColorScheme.dark().copyWith(),
  );


}

ThemeClass _themeClass = ThemeClass();