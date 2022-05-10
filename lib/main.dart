
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/initialize/theme/theme_notifier.dart';
import 'package:mobuni_v2/core/model/theme/theme_model.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/services/hive/storage_encryption.dart';
import 'package:mobuni_v2/feature/views/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '/core/initialize/provider_manager.dart';
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
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (_,mode,child) {
          return MaterialApp(
            title: 'MobUni',
            debugShowCheckedModeBanner: false,
            theme: ThemeModel().lightMode,
            darkTheme: ThemeModel().darkMode,
            themeMode: mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
            home: HomeView(),
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
          );
        }
      ),
    );
  }
}

