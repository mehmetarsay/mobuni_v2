import 'package:mobuni_v2/core/network/network_manager.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/views/auth/login/login_view.dart';
import 'package:mobuni_v2/feature/views/home/bottomnav_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../feature/services/question/question_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: BottomNavView),
    MaterialRoute(page: LoginView),
  ],
  dependencies: [
    LazySingleton(classType: NetworkManager),
    LazySingleton(classType: HiveService),
    LazySingleton(classType: QuestionService),
    LazySingleton(classType: NavigationService,environments: {Environment.dev}),
  ]
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/

}