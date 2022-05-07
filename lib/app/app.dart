import 'package:mobuni_v2/core/network/network_manager.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NetworkManager),
  ]
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/

}