// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/manager/hive/hive_manager.dart';
import '../core/manager/network_manager.dart';
import '../core/manager/provider_manager.dart';
import '../feature/views/activity/service/activity_service.dart';
import '../feature/views/auth/service/auth_service.dart';
import '../feature/views/comments/service/comment_service.dart';
import '../feature/views/profile/service/profile_service.dart';
import '../feature/views/question/service/question_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => ProviderManager());
  locator.registerLazySingleton(() => NetworkManager());
  locator.registerLazySingleton(() => HiveManager());
  locator.registerLazySingleton(() => QuestionService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProfileService());
  locator.registerLazySingleton(() => CommentService());
  locator.registerLazySingleton(() => ActivityService());
  locator
      .registerLazySingleton(() => NavigationService(), registerFor: {"dev"});
}
