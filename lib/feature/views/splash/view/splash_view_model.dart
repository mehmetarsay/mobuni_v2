import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/manager/one_signal_notification_manager.dart';
import 'package:mobuni_v2/feature/models/activity_category/activity_category_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final AuthService authService = locator<AuthService>();

  init() async{
    GeneralManager.hiveM.hive.delete(Constants.users);
    OneSignalNotificationManager.initializeAppSplash();


    Future.delayed(Duration(seconds: 3)).then((value)async {
      if (authService.isLogin) {
        await getCategory();
        navigationService.pushNamedAndRemoveUntil(Routes.homeView);
      } else {
        navigationService.pushNamedAndRemoveUntil(Routes.loginView);
      }
    });

  }

  getCategory()async{
    List<ActivityCategoryModel> categoryList = await authService.getAllCategory();
    authService.saveCategory(categoryList);
  }
}
