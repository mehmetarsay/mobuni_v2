import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:provider/provider.dart';
import '/feature/views/splash/view/splash_view.dart';
import '/core/initialize/provider_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MultiProvider(
    child: MyApp(),
    providers: ProviderManager.instance!.dependItems,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobUni',
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
