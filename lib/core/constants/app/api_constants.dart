import 'package:flutter/foundation.dart';
import 'package:mobuni_v2/core/constants/app/private_constants.dart';

class ApiConstants {
  static String baseUrl = kReleaseMode
      ? PrivateConstants.productionUrl
      : PrivateConstants.developmentUrl;
  
  static String login = 'User/Login';
  static String register = 'User/Register';
}
