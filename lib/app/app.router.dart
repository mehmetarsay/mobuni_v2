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
import '../feature/views/chat/chat_contact/chat_contact_view.dart';
import '../feature/views/chat/chat_home/chat_home_view.dart';
import '../feature/views/chat/chat_message/chat_message_view.dart';
import '../feature/views/comments/comment_view.dart';
import '../feature/views/home/home_view.dart';
import '../feature/views/profile/subviews/profile_redesign/profile_redesign_view.dart';
import '../feature/views/question/subviews/question_add/question_add_view.dart';
import '../feature/views/splash/view/splash_view.dart';
import '../feature/widgets/photo/photo_view.dart';

class Routes {
  static const String splashView = '/';
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String registerView = '/register-view';
  static const String questionAddView = '/question-add-view';
  static const String commentView = '/comment-view';
  static const String profileRedesignView = '/profile-redesign-view';
  static const String customPhotoView = '/custom-photo-view';
  static const String chatHomeView = '/chat-home-view';
  static const String chatMessageView = '/chat-message-view';
  static const String chatContactView = '/chat-contact-view';
  static const all = <String>{
    splashView,
    homeView,
    loginView,
    registerView,
    questionAddView,
    commentView,
    profileRedesignView,
    customPhotoView,
    chatHomeView,
    chatMessageView,
    chatContactView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.questionAddView, page: QuestionAddView),
    RouteDef(Routes.commentView, page: CommentView),
    RouteDef(Routes.profileRedesignView, page: ProfileRedesignView),
    RouteDef(Routes.customPhotoView, page: CustomPhotoView),
    RouteDef(Routes.chatHomeView, page: ChatHomeView),
    RouteDef(Routes.chatMessageView, page: ChatMessageView),
    RouteDef(Routes.chatContactView, page: ChatContactView),
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
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
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
    CommentView: (data) {
      var args = data.getArgs<CommentViewArguments>(
        orElse: () => CommentViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CommentView(
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
    CustomPhotoView: (data) {
      var args = data.getArgs<CustomPhotoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CustomPhotoView(
          key: args.key,
          imageUrl: args.imageUrl,
          imageTag: args.imageTag,
        ),
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
    ChatContactView: (data) {
      var args = data.getArgs<ChatContactViewArguments>(
        orElse: () => ChatContactViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatContactView(
          key: args.key,
          isCreateGroup: args.isCreateGroup,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// CommentView arguments holder class
class CommentViewArguments {
  final Key? key;
  final QuestionModel? questionModel;
  CommentViewArguments({this.key, this.questionModel});
}

/// CustomPhotoView arguments holder class
class CustomPhotoViewArguments {
  final Key? key;
  final String imageUrl;
  final String imageTag;
  CustomPhotoViewArguments(
      {this.key, required this.imageUrl, required this.imageTag});
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

/// ChatContactView arguments holder class
class ChatContactViewArguments {
  final Key? key;
  final bool isCreateGroup;
  ChatContactViewArguments({this.key, this.isCreateGroup = false});
}
