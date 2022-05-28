import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/constants/app/private_constants.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(PrivateConstants.onesignalAppId);
    if(GeneralManager.isSignUser) {
      await OneSignal.shared.setExternalUserId(GeneralManager.user.id.toString());
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
      var additionalData = event.notification.additionalData!;
      // final type =
      //     (additionalData['notificationType'] as int).intToNotificationType;
      // if (additionalData['senderUserGid'] != GlobalValue.user!.gid) {
      //   if (type == NotificationType.CHAT) {
      //     if (additionalData['senderUserGid'] !=
      //         GlobalValue.activeChatReceiverGid) {
      //       event.complete(null);
      //       showForegroundMessage(event.notification.title!,
      //           event.notification.body!, additionalData);
      //     } else {
      //       event.complete(null);
      //     }
      //   } else {
      //     event.complete(event.notification);
      //   }
      // } else {
      //   event.complete(null);
      // }
    });

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // Will be called whenever a notification is opened/button pressed.
      // Her bildirim açıldığında/düğmeye basıldığında çağrılır.
      print('setNotificationOpenedHandler worked');

      // await navigateView(result.notification.additionalData!);
    });
  }

}
