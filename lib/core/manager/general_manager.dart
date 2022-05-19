import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';

class GeneralManager {
  static UserModel get user => locator<HiveManager>().hive.get(Constants.user);

  static NetworkManager get networkM => locator<NetworkManager>();
  static HiveManager get hiveM => locator<HiveManager>();

  static AuthService get authS => locator<AuthService>();
}