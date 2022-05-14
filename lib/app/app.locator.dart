// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/network/network_manager.dart';
import '../feature/services/hive/hive_services.dart';
import '../feature/services/question/question_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NetworkManager());
  locator.registerLazySingleton(() => HiveService());
  locator.registerLazySingleton(() => QuestionService());
  locator
      .registerLazySingleton(() => NavigationService(), registerFor: {"dev"});
}
