import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/core/manager/provider_manager.dart';
import 'package:mobuni_v2/feature/views/auth/login/login_view.dart';
import 'package:mobuni_v2/feature/views/auth/register/register_view.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:mobuni_v2/feature/views/chat/chat_contact/chat_contact_view.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:mobuni_v2/feature/views/comments/service/comment_service.dart';
import 'package:mobuni_v2/feature/views/chat/chat_home/chat_home_view.dart';
import 'package:mobuni_v2/feature/views/chat/chat_message/chat_message_view.dart';
import 'package:mobuni_v2/feature/views/home/home_view.dart';
import 'package:mobuni_v2/feature/views/profile/service/profile_service.dart';
import 'package:mobuni_v2/feature/views/profile/subviews/profile_redesign/profile_redesign_view.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:mobuni_v2/feature/views/question/subviews/question_add/question_add_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view.dart';
import 'package:mobuni_v2/feature/widgets/photo/photo_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: QuestionAddView),
    MaterialRoute(page: CommentView),
    MaterialRoute(page: ProfileRedesignView),
    MaterialRoute(page: CustomPhotoView),
    MaterialRoute(page: ChatHomeView),
    MaterialRoute(page: ChatMessageView),
    MaterialRoute(page: ChatContactView),
  ],
  dependencies: [
    LazySingleton(classType: ProviderManager),
    LazySingleton(classType: NetworkManager),
    LazySingleton(classType: HiveManager),
    LazySingleton(classType: QuestionService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ProfileService),
    LazySingleton(classType: CommentService),
    LazySingleton(classType: NavigationService,environments: {Environment.dev}),
  ]
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/

}