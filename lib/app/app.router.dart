// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../feature/views/auth/login/login_view.dart';
import '../feature/views/auth/register/register_view.dart';
import '../feature/views/home/bottomnav_view.dart';
import '../feature/views/question/subviews/question_add/question_add_view.dart';
import '../feature/views/splash/view/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String bottomNavView = '/bottom-nav-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String questionAddView = '/question-add-view';
  static const all = <String>{
    splashView,
    bottomNavView,
    loginView,
    registerView,
    questionAddView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.bottomNavView, page: BottomNavView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.questionAddView, page: QuestionAddView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashView(),
        settings: data,
      );
    },
    BottomNavView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BottomNavView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RegisterView(),
        settings: data,
      );
    },
    QuestionAddView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const QuestionAddView(),
        settings: data,
      );
    },
  };
}
