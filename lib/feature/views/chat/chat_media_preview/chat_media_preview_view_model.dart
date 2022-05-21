import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:mobuni_v2/feature/models/messaging/message.dart';
import 'package:mobuni_v2/feature/models/messaging/user_chat_info.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:ntp/ntp.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class ChatMediaPreviewViewModel extends StreamViewModel {
  BuildContext context;
  Chat? chat;
  final List<Media>? mediaList;
  var controller = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ChatMediaPreviewViewModel(this.context, this.chat, this.mediaList);

  // @override
  // // TODO: implement stream
  // Stream<DocumentSnapshot<Map<String, dynamic>>> get stream =>
  //     FirebaseService.instance!.getUserChatInfo(chat!.receiverUser!.gid!);

  @override
  // TODO: implement stream
  Stream<QuerySnapshot<Map<String, dynamic>>> get stream =>
      FirebaseService.instance!.getUsersChatInfo(chat!.users!);

  // String? get receiverActiveChat => data.data()['currentChatId'];
  List get inactiveUsersInThisChat {
    var userList = [];
    (data as QuerySnapshot<Map<String, dynamic>>).docs.map((e) {
      var userChatInfo = UserChatInfo.fromJson(e.data());
      if (userChatInfo.currentChatId != chat!.id) {
        userList.add(userChatInfo.userGid);
      }
    }).toList();
    return userList;
  }

  List get usersOneSignalIdList {
    var oneSignalIdList = [];
    (data as QuerySnapshot<Map<String, dynamic>>).docs.map((e) {
      var userChatInfo = UserChatInfo.fromJson(e.data());
      if (userChatInfo.currentChatId != chat!.id) {
        oneSignalIdList.addAll(userChatInfo.oneSignalIdList ?? []);
      }
    }).toList();
    return oneSignalIdList;
  }

  void sendMessage() async {
    GeneralManager.navigationS.back();
    try {
      isLoading = true;
      var receiverList = chat!.users!.map((e) => e).toList();
      receiverList.remove(GeneralManager.user.id);
      var isReadList = <String, bool>{};
      receiverList
          .forEach((element) => isReadList.putIfAbsent(element, () => false));
      var msg = Message(
          id: Uuid().v1(),
          message: controller.text,
          messageType: MessageType.IMAGE.index,
          sender: GeneralManager.user.id,
          receiverList: receiverList,
          isReadMap: isReadList,
          time: await NTP.now());
      await FirebaseService.instance!.sendChatImageMessage(
          chat!.id!, msg, mediaList!, inactiveUsersInThisChat);
      isLoading = false;

      // NotificationService.instance!.pushNotification(
      //     chat!.type == ChatType.SINGLE.index
      //         ? '${GeneralManager.user.fullName}:'
      //         : chat!.groupName!,
      //     (chat!.type == ChatType.SINGLE.index
      //             ? ''
      //             : '${GeneralManager.user.fullName}: ') +
      //         (controller.text.isEmpty ? 'Fotoğraf' : controller.text),
      //     NotificationType.CHAT,
      //     data: {'gid': chat!.id},
      //     pushAllSubscribed: false,
      //     userList: usersOneSignalIdList);
    } finally {
      isLoading = false;
    }
  }
}
