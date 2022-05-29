import 'package:mobuni_v2/core/constants/app/private_constants.dart';
import 'package:mobuni_v2/core/constants/enum/notifications_enum.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';

class NotificationService {
  static NotificationService? _instance;

  static NotificationService? get instance {
    _instance ??= NotificationService._init();
    return _instance;
  }

  NotificationService._init();

  final _networkManager = GeneralManager.networkM;

  void pushNotification(
    String title,
    String body,
    NotificationType notificationType, {
    Map<String, dynamic>? data,
    String? largeIcon,
    bool pushAllSubscribed = true,
    List? userList,
    String? sendAfter = '',
    String? group = '',
  }) async {
    data ??= {};
    data.addAll({
      'notificationType': notificationType.index,
      'senderUserGid': GeneralManager.user.id
    });
    var isPush = false;
    if (pushAllSubscribed) {
      isPush = true;
    }
    if (!pushAllSubscribed && userList!.isNotEmpty) {
      isPush = true;
    }
    if (isPush) {
      await _networkManager.pushNotification(
        {
          'app_id': PrivateConstants.onesignalAppId,
          if (pushAllSubscribed)
            'included_segments': ['Subscribed Users']
          else
            'include_external_user_ids': userList,
          'data': data,
          'headings': {'en': title},
          'contents': {'en': body},
          // 'android_channel_id': notificationType.notificationTypeToAndroidChannel,
          // 'small_icon': 'ic_stat_c21',
          'large_icon': largeIcon,
          'ios_badgeType': 'Increase',
          'ios_badgeCount': 1,
          if (group != '') 'android_group': group,
          if (group != '') 'thread_id': group,
          if (sendAfter != '') 'send_after': sendAfter,
          // if (notificationType == NotificationType.BELL) 'ios_sound': 'bell.wav'
          //'${ApplicationConstants.USER_IMAGE_BASE_PATH}${GlobalValue.user!.image}',
        },
      );
    }
  }
}
