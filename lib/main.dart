import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/core/manager/hive/storage_encryption.dart';
import 'package:mobuni_v2/core/theme/theme_model.dart';
import 'package:mobuni_v2/core/theme/theme_notifier.dart';
import 'package:mobuni_v2/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(environment: Environment.dev);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///hive initialize and encryption
  final hiveService = locator<HiveManager>();
  var encryptionKey = kIsWeb ? null : await StorageEncryption().getEncryptionKey();
  await hiveService.init(encryptionKey: encryptionKey);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  timeago.setLocaleMessages('tr', timeago.TrMessages());
  timeago.setDefaultLocale('tr');
  tz.initializeTimeZones();
  final locationName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(locationName));
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
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: context.theme.primaryColor,
              size: 50,
            ),
          ),
          child: GestureDetector(
            onTap: (){
              var currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
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
          ),
        );
      }),
    );
  }
}
