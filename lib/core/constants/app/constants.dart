import 'package:flutter/material.dart';

class Constants {
  static String authToken = 'authToken';
  static String mehmetPhoto = "https://pbs.twimg.com/profile_images/1486436054169268238/-jsp8MLq_400x400.jpg";
  static String user = 'user';
  static String users = 'users';
  static get titleShadows => [
        Shadow(
          offset: Offset(0, 4.0),
          blurRadius: 4.0,
          color: Color(0xff000000).withOpacity(0.25),
        ),
      ];
}
