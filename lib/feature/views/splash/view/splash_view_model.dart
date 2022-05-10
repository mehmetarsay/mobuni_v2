import 'package:mobuni_v2/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();

  init(){
    Future.delayed(Duration(seconds: 3)).then((value) {
      navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    });
  }
}