import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/constants/config/config.dart';

class ThemeModel {
  final lightMode = ThemeData(
    primaryColor: Config().appColor,
    accentColor: Colors.grey,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: Colors.grey[100],
    brightness: Brightness.light,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    secondaryHeaderColor: Colors.grey[600],
    shadowColor: Colors.grey[200],
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[900],
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.6,
          wordSpacing: 1,
          color: Colors.grey[900],
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontWeight: FontWeight.bold,fontSize: 14,color:Colors.black
      ),
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey[900]),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Config().appColor,
      unselectedItemColor: Colors.grey[500],
    ),
  );




  final darkMode = ThemeData(
      primaryColor: Config().appColor,
      accentColor: Colors.black,
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
        brightness: Brightness.dark,
        color: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            letterSpacing: -0.6,
            wordSpacing: 1,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontWeight: FontWeight.bold,fontSize: 14,color:Colors.white
        ),
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ));
}