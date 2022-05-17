import 'package:flutter/material.dart';

class Constants {
  static String authToken = 'authToken';
  static get titleShadows => [
        Shadow(
          offset: Offset(0, 4.0),
          blurRadius: 4.0,
          color: Color(0xff000000).withOpacity(0.25),
        ),
      ];
}
