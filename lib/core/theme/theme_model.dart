import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobuni_v2/core/constants/config/config.dart';

class ThemeModel {
  final lightMode = ThemeData(
      primaryColor: Config().appColor,
      iconTheme: IconThemeData(color: Colors.grey[900]),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColorDark:Colors.grey[800],
      primaryColorLight: Colors.white,
      secondaryHeaderColor: Colors.grey[600],
      shadowColor: Colors.grey[200],
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[900],
        ),
        actionsIconTheme: IconThemeData(color: Colors.grey[900]), systemOverlayStyle: SystemUiOverlayStyle.dark, toolbarTextStyle: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.6,
            wordSpacing: 1,
            color: Colors.grey[900],
          ),
        ).bodyText2, titleTextStyle: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.6,
            wordSpacing: 1,
            color: Colors.grey[900],
          ),
        ).headline6,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey[900]),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Config().appColor,
        unselectedItemColor: Colors.grey[500],
      ), colorScheme: ColorScheme.light(primary: Config().appColor).copyWith(secondary: Colors.grey));

  final darkMode = ThemeData(
      primaryColor: Config().appColor,
      iconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Color(0xff303030),
      brightness: Brightness.dark,
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.grey[800],
      secondaryHeaderColor: Colors.grey[400],
      shadowColor: Color(0xff282828),
      backgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        color: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(color: Colors.white), systemOverlayStyle: SystemUiOverlayStyle.light, toolbarTextStyle: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            letterSpacing: -0.6,
            wordSpacing: 1,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ).bodyText2, titleTextStyle: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            letterSpacing: -0.6,
            wordSpacing: 1,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ).headline6,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ), colorScheme: ColorScheme.dark(primary: Config().appColor2).copyWith(secondary: Colors.black));
}
