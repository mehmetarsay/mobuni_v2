// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../feature/models/messaging/chat.dart';
import '../feature/models/questions/question_model.dart';
import '../feature/views/auth/login/login_view.dart';
import '../feature/views/auth/register/register_view.dart';
import '../feature/views/chat/chat_home/chat_home_view.dart';
import '../feature/views/chat/chat_message/chat_message_view.dart';
import '../feature/views/home/bottomnav_view.dart';
import '../feature/views/profile/subviews/profile_redesign/profile_redesign_view.dart';
import '../feature/views/question/subviews/question_add/question_add_view.dart';
import '../feature/views/question/subviews/question_comments/question_comments_view.dart';
import '../feature/views/splash/view/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String bottomNavView = '/bottom-nav-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String questionAddView = '/question-add-view';
  static const String questionCommentsView = '/question-comments-view';
  static const String profileRedesignView = '/profile-redesign-view';
  static const String chatHomeView = '/chat-home-view';
  static const String chatMessageView = '/chat-message-view';
  static const all = <String>{
    splashView,
    bottomNavView,
    loginView,
    registerView,
    questionAddView,
    questionCommentsView,
    profileRedesignView,
    chatHomeView,
    chatMessageView,
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
    RouteDef(Routes.questionCommentsView, page: QuestionCommentsView),
    RouteDef(Routes.profileRedesignView, page: ProfileRedesignView),
    RouteDef(Routes.chatHomeView, page: ChatHomeView),
    RouteDef(Routes.chatMessageView, page: ChatMessageView),
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
    QuestionCommentsView: (data) {
      var args = data.getArgs<QuestionCommentsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => QuestionCommentsView(
          key: args.key,
          questionModel: args.questionModel,
        ),
        settings: data,
      );
    },
    ProfileRedesignView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProfileRedesignView(),
        settings: data,
      );
    },
    ChatHomeView: (data) {
      var args = data.getArgs<ChatHomeViewArguments>(
        orElse: () => ChatHomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatHomeView(
          key: args.key,
          isSelect: args.isSelect,
          data: args.data,
        ),
        settings: data,
      );
    },
    ChatMessageView: (data) {
      var args = data.getArgs<ChatMessageViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatMessageView(
          key: args.key,
          chat: args.chat,
          isCreated: args.isCreated,
          isSelect: args.isSelect,
          data: args.data,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// QuestionCommentsView arguments holder class
class QuestionCommentsViewArguments {
  final Key? key;
  final QuestionModel questionModel;
  QuestionCommentsViewArguments({this.key, required this.questionModel});
}

/// ChatHomeView arguments holder class
class ChatHomeViewArguments {
  final Key? key;
  final bool isSelect;
  final dynamic data;
  ChatHomeViewArguments({this.key, this.isSelect = false, this.data = ''});
}

/// ChatMessageView arguments holder class
class ChatMessageViewArguments {
  final Key? key;
  final Chat chat;
  final bool isCreated;
  final bool isSelect;
  final dynamic data;
  ChatMessageViewArguments(
      {this.key,
      required this.chat,
      required this.isCreated,
      this.isSelect = false,
      this.data = ''});
}
