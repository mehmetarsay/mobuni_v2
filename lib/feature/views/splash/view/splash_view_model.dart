import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final AuthService authService = locator<AuthService>();

  init() {
    GeneralManager.hiveM.hive.delete(Constants.users);
    Future.delayed(Duration(seconds: 3)).then((value) {
      
      if (authService.isLogin) {
        navigationService.pushNamedAndRemoveUntil(Routes.homeView);
      } else {
        navigationService.pushNamedAndRemoveUntil(Routes.loginView);
      }
    });
  }
}
