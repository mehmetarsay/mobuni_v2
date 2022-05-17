
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/initialize/theme/theme_notifier.dart';
import 'package:mobuni_v2/core/model/theme/theme_model.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/services/hive/storage_encryption.dart';
import 'package:mobuni_v2/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(environment: Environment.dev);

  ///hive initialize and encryption
  final hiveService = locator<HiveService>();
  var encryptionKey = await StorageEncryption().getEncryptionKey();
  await hiveService.init(encryptionKey);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(builder: (_, mode, child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(
            child: 
            LoadingAnimationWidget.staggeredDotsWave(
                color: context.theme.primaryColor,
                size: 50),
          ),
          child: MaterialApp(
            title: 'MobUni',
            debugShowCheckedModeBanner: false,
            theme: ThemeModel().lightMode,
            darkTheme: ThemeModel().darkMode,
            themeMode:
                mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
          ),
        );
      }),
    );
  }
}
