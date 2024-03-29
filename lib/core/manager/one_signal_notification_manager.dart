import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/progress/custom_progress_widget.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/app/private_constants.dart';
import 'package:mobuni_v2/core/constants/enum/notifications_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:mobuni_v2/feature/views/chat/chat_message/chat_message_view.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:mobuni_v2/feature/views/unavailabile_view.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OneSignalNotificationManager {
  static final OneSignalNotificationManager? _instance =
      OneSignalNotificationManager._init();

  static OneSignalNotificationManager? get instance => _instance;

  OneSignalNotificationManager._init();

  late BuildContext _context;

  static void initializeAppSplash() async {
    _instance?._initialize();
  }

  static void initializeApp(BuildContext context) async {
    _instance?._context = context;
    _instance?._initialize();
    _instance?._initializeHandler();
  }

  set context(BuildContext value) {
    _context = value;
  }

  void _initialize() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);
    await OneSignal.shared.setAppId(PrivateConstants.onesignalAppId);
    if (GeneralManager.isSignUser) {
      await OneSignal.shared
          .setExternalUserId(GeneralManager.user.id.toString());
    }
    // await OneSignal.shared.setLanguage('en');
    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      print('Accepted permission: $accepted');
    });
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
      // İzin değiştiğinde çağrılacak
      // (yani, kullanıcı iOS'ta izin isteminde İzin Ver'e dokunur)
      // return;
    });
    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
      if (changes.to.isSubscribed) {
        print('kayıt olundu');
        var deviceState = await OneSignal.shared.getDeviceState();
        if (deviceState != null && deviceState.userId != null) {
          // FirebaseService.instance!.updateUserOneSignalId(deviceState.userId!);
        }
      }
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
      // Abonelik değiştiğinde çağrılacak
      // (yani kullanıcı OneSignal'a kaydolur ve bir kullanıcı kimliği alır)
      // return;
    });
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState != null && deviceState.userId != null) {
      // FirebaseService.instance!.updateUserOneSignalId(deviceState.userId!);
      // await AuthenticateService.instance!
      //     .userOneSignalUpdate(deviceState.userId!);
    }
  }

  void _initializeHandler() async {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      // Ön planda bir bildirim alındığında çağrılacak
      // Bildirimi Görüntüle, bildirimi görüntülememek için boş parametre iletin
      print('setNotificationWillShowInForegroundHandler worked');
      print('one_signal: ${GeneralManager.activeChatReceiverGid}');

      var additionalData = event.notification.additionalData!;
      final type =
          (additionalData['notificationType'] as int).intToNotificationType;
      if (additionalData['senderUserGid'] != GeneralManager.user.id) {
        if (type == NotificationType.chat) {
          if (additionalData['senderUserGid'] !=
              GeneralManager.activeChatReceiverGid) {
            event.complete(null);
            showForegroundMessage(event.notification.title!,
                event.notification.body!, additionalData);
          } else {
            event.complete(null);
          }
        } else {
          event.complete(event.notification);
        }
      } else {
        event.complete(null);
      }
    });

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // Will be called whenever a notification is opened/button pressed.
      // Her bildirim açıldığında/düğmeye basıldığında çağrılır.
      print('setNotificationOpenedHandler worked');

      await navigateView(result.notification.additionalData!);
    });
  }

  void showForegroundMessage(
      String title, String body, Map<String, dynamic> data) {
    var userImage = data['userImage'];
    showTopSnackBar(
      _context,
      Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: _context.theme.primaryColor.withOpacity(0.9),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserPhoto(url: userImage),
              SizedBox(width: _context.dynamicWidth(0.02)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title,
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  CustomText(body,
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        print('onTap');
        await navigateView(data);
        // singleton.onClickNotification(message.data);
      },
    );
  }

  Future navigateView(Map<String, dynamic> data) async {
    final type = (data['notificationType'] as int).intToNotificationType;
    final gid = data['gid'];
    final dataId = data['dataId'] != null ? int.parse(data['dataId']) : 0;
    // final bool isComment = data['isComment'] ?? false;
    unawaited(showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ProgressIndicatorWidget(),
          );
        }));
    if (type == NotificationType.chat) {
      var result = await FirebaseService.instance!.getChatWithChatId(gid);
      if (result != null) {
        GeneralManager.navigationS.back();
        await GeneralManager.navigationS.navigateToView(ChatMessageView(
          chat: result,
          isCreated: false,
        ));
      } else {}
    } else if (type == NotificationType.questionLike ||
        type == NotificationType.questionComment ||
        type == NotificationType.questionCommentLike) {
          var question = await locator<QuestionService>().questionGetByQuestionId(questionId: dataId);
          GeneralManager.navigationS.back();
          if(question != null) {
            await GeneralManager.navigationS.navigateToView(CommentView(questionModel: question));
          }
    } else if (type == NotificationType.activityLike ||
        type == NotificationType.activityComment ||
        type == NotificationType.activityCommentLike ||
        type == NotificationType.activityJoined) {
          var activityList = await locator<ActivityService>().activityGet(activityId: dataId);
          GeneralManager.navigationS.back();
          if(activityList != null && activityList.isNotEmpty) {
            await GeneralManager.navigationS.navigateToView(CommentView(activityModel: activityList.first));
          }
    } else {
      GeneralManager.navigationS.back();
      await GeneralManager.navigationS.navigateToView(UnAvailableView());
    }
    // switch (type) {
    //   case NotificationType.chat:
    //     var result = await FirebaseService.instance!.getChatWithChatId(gid);
    //     if (result != null) {
    //       GeneralManager.navigationS.back();
    //       await GeneralManager.navigationS.navigateToView(ChatMessageView(
    //         chat: result,
    //         isCreated: false,
    //       ));
    //     } else {}
    //     break;
    //   default:
    //     GeneralManager.navigationS.back();
    //     await GeneralManager.navigationS.navigateToView(UnAvailableView());
    // }
  }
}
