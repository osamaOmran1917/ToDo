import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color darkScaffoldBackground = Color(0xFF060E1E);
  static const Color green = Color(0xFF61E757);
  static const Color red = Color(0xFFEC4B4B);

  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(size: 36),
          unselectedIconTheme: IconThemeData(size: 36)),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: lightPrimary),
          titleSmall: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          bodySmall: TextStyle(fontSize: 12, color: Colors.black)));

  static final darkTheme = ThemeData(
      primaryColor: lightPrimary,
      secondaryHeaderColor: Color(0xFF141922),
      scaffoldBackgroundColor: darkScaffoldBackground,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(size: 36),
          unselectedIconTheme: IconThemeData(size: 36)),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: lightPrimary),
          titleSmall: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          bodySmall: TextStyle(fontSize: 12, color: Colors.white)));
}
