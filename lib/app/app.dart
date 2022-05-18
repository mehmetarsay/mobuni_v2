import 'package:mobuni_v2/core/network/network_manager.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/views/auth/login/login_view.dart';
import 'package:mobuni_v2/feature/views/auth/register/register_view.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:mobuni_v2/feature/views/home/bottomnav_view.dart';
import 'package:mobuni_v2/feature/views/profile/subviews/profile_redesign/profile_redesign_view.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:mobuni_v2/feature/views/question/subviews/question_comments/question_comments_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../feature/views/question/subviews/question_add/question_add_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: BottomNavView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: QuestionAddView),
    MaterialRoute(page: QuestionCommentsView),
    MaterialRoute(page: ProfileRedesignView),
  ],
  dependencies: [
    LazySingleton(classType: NetworkManager),
    LazySingleton(classType: HiveService),
    LazySingleton(classType: QuestionService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: NavigationService,environments: {Environment.dev}),
  ]
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/

}