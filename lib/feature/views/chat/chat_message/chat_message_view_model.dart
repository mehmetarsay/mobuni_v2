import 'package:file_picker/file_picker.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/constants/enum/notifications_enum.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/models/messaging/message.dart';
import 'package:mobuni_v2/feature/models/messaging/user_chat_info.dart';
import 'package:mobuni_v2/feature/service/notification_service.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';

import '../chat_media_preview/chat_media_preview_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class ChatMessageViewModel extends MultipleStreamViewModel {
  late BuildContext context;
  Chat chat;
  var scrollController = ScrollController();
  var chatTextController = TextEditingController();
  bool _isExpanded = false,
      _showMenu = false,
      _isLoading = false,
      _isMoreAction = false;

  bool get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isExpanded => _isExpanded;

  set isExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  bool get showMenu => _showMenu;

  set showMenu(value) {
    _showMenu = value;
    notifyListeners();
  }

  bool get isMoreAction => _isMoreAction;

  set isMoreAction(value) {
    _isMoreAction = value;
    notifyListeners();
  }

  ChatMessageViewModel(this.chat);

  @override
  void initialise() async {
    super.initialise();
  }

  void onModelReadyInitialize(
      BuildContext context, String chatId, bool isSelect, dynamic data) async {
    this.context = context;
    if (isSelect) {
      isLoading = true;
      // if (data is Demand) {
      //   if (data.gid != null) {
      //     await sendDemandAndProperty(
      //         data.gid!, MessageType.DEMAND.index, 'talep');
      //   }
      // } else if (data is Property) {
      //   if (data.id != null) {
      //     await sendDemandAndProperty(
      //         data.id!, MessageType.PROPERTY.index, 'portföy');
      //   }
      // }
      isLoading = false;
    }

    await FirebaseService.instance!.chatUnReadMessageClear(chatId);
  }

  @override
  Map<String, StreamData> get streamsMap => {
        'message': StreamData<List<Map<String, dynamic>>>(
          FirebaseService.instance!.getChatMessages(chat.id!).asyncMap(
            (query) async {
              var futures = query.docs.map(
                (doc) async {
                  var data = doc.data();
                  var message = Message().fromJson(data);
                  await message.initSender();
                  return {'message' : message, 'referance' : doc.reference};
                },
              );
              return await Future.wait(futures);
            },
          ),
        ),
        if (chat.type == ChatType.SINGLE.index)
          'userState': StreamData<DocumentSnapshot<Map<String, dynamic>>>(
              FirebaseService.instance!.getUserChatInfo(chat.receiverUserId!)),
        'usersChatInfo': StreamData<QuerySnapshot<Map<String, dynamic>>>(
            FirebaseService.instance!.getUsersChatInfo(chat.users!)),
        'chat': StreamData<Chat>(
          FirebaseService.instance!.streamChat(chat.id!).asyncMap(
            (query) async {
              var data = query.data();
              var chat = Chat.fromJson(data!);
              await chat.receiverUserInit;
              return chat;
            },
          ),
        ),
        'chatRef': StreamData<DocumentSnapshot<Map<String, dynamic>>>(
            FirebaseService.instance!.streamChat(chat.id!))
      };

  bool get userState => dataMap!['userState']!.data() != null
      ? dataMap!['userState']!.data()['isOnline'] ?? false
      : false;

  String? get receiverActiveChat =>
      dataMap!['userState']!.data()['currentChatId'];

  DateTime? get lastSeen => dataMap!['userState']!.data() != null
      ? dataMap!['userState']!.data()['lastSeen'] != null
          ? dataMap!['userState']!.data()['lastSeen'].toDate()
          : null
      : null;

  Chat? get streamChat {
    return dataMap!['chat'];
  }

  void updateStreamChat(Chat chat) {
    (dataMap!['chatRef']! as DocumentSnapshot<Map<String, dynamic>>)
        .reference
        .update(chat.toJson());
  }

  List get inactiveUsersInThisChat {
    var userList = [];
    (dataMap!['usersChatInfo']! as QuerySnapshot<Map<String, dynamic>>)
        .docs
        .map((e) {
      var userChatInfo = UserChatInfo.fromJson(e.data());
      if (userChatInfo.currentChatId != chat.id) {
        userList.add(userChatInfo.id);
      }
    }).toList();
    return userList;
  }

  List<dynamic> get getMessages {
    return (dataMap!['message'] ?? []).map((documentSnapshot) {
      var message = documentSnapshot['message'];
          // Message().fromJson(documentSnapshot.data() as Map<String, dynamic>);
      if (!message.isReadMessage &&
          (message.receiverList ?? []).contains(GeneralManager.user.id)) {
        // message.read;
        message.updateReadWithuserId(GeneralManager.user.id!);
        documentSnapshot['referance']
            .update(message.toJson());
        var tempChat = streamChat;
        if (tempChat != null &&
            tempChat.lastMessage != null &&
            tempChat.lastMessage!.id == message.id) {
          print('Chat son mesajı güncellendi');
          tempChat.lastMessage = message;
          updateStreamChat(tempChat);
        }
      }

      /* 
      final delay = 1000;
      Future.delayed(Duration(milliseconds: delay), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      });*/
      return message;
    }).toList();
  }

  void sendMessage() async {
    var messageText = chatTextController.text;
    chatTextController.clear();
    if (messageText.isNotEmpty) {
      var receiverList = chat.users!.map((e) => e).toList();
      receiverList.remove(GeneralManager.user.id);
      var isReadList = <String, bool>{};
      receiverList
          .forEach((element) => isReadList.putIfAbsent(element, () => false));
      print('aaaa');
      var msg = Message(
          id: Uuid().v1(),
          message: messageText,
          messageType: MessageType.TEXT.index,
          sender: GeneralManager.user.id,
          receiverList: receiverList,
          isReadMap: isReadList,
          time: DateTime.now());
      print('debug sendMessage');
      await FirebaseService.instance!
          .sendChatMessage(chat.id!, msg, inactiveUsersInThisChat);
      // scrollToBottom(isDelayed: false);
      NotificationService.instance!.pushNotification(
          chat.type == ChatType.SINGLE.index
              ? '${GeneralManager.user.fullName}:'
              : chat.groupName!,
          chat.type == ChatType.SINGLE.index
              ? messageText
              : '${GeneralManager.user.fullName}: $messageText',
          NotificationType.chat,
          data: {
            'gid': chat.id,
            'userImage': GeneralManager.user.image,
            'chatType': chat.type
          },
          pushAllSubscribed: false,
          userList: inactiveUsersInThisChat,
          group: 'chat');
    }
  }

  void sendFile(String fileName, String filePath) async {
    try {
      isLoading = true;
      var receiverList = chat.users!.map((e) => e).toList();
      receiverList.remove(GeneralManager.user.id);
      var isReadList = <String, bool>{};
      receiverList
          .forEach((element) => isReadList.putIfAbsent(element, () => false));
      var msg = Message(
          id: Uuid().v1(),
          message: '',
          messageType: MessageType.FILE.index,
          sender: GeneralManager.user.id,
          receiverList: receiverList,
          isReadMap: isReadList,
          fileName: fileName,
          filePath: filePath,
          time: DateTime.now());
      chatTextController.clear();
      await FirebaseService.instance!
          .sendChatFileMessage(chat.id!, msg, inactiveUsersInThisChat);
      NotificationService.instance!.pushNotification(
          chat.type == ChatType.SINGLE.index
              ? '${GeneralManager.user.fullName}:'
              : chat.groupName!,
          '${chat.type == ChatType.SINGLE.index ? '' : '${GeneralManager.user.fullName}: '}1 Dosya',
          NotificationType.chat,
          data: {'gid': chat.id},
          pushAllSubscribed: false,
          userList: inactiveUsersInThisChat,
          group: 'chat');
      isExpanded = !isExpanded;
      if (!showMenu) showMenu = true;
      chatTextController.clear();
      // scrollToBottom(isDelayed: false);
    } finally {
      isLoading = false;
    }
  }

  Future<void> loadImages() async {
    var resultList = <Media>[];
    try {
      resultList = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 4,
          showGif: false,
          showCamera: true,
          compressSize: 500,
          uiConfig: UIConfig(uiThemeColor: Theme.of(context).primaryColorDark),
          cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    } catch (e) {
      print('$e');
    }
    await GeneralManager.navigationS.navigateToView(
        ChatMediaPreviewView(chat: chat, mediaList: resultList, type: 0));
  }

  void loadFile() async {
    try {
      var result = await FilePicker.platform.pickFiles();
      if (result != null) {
        sendFile(result.names.first!, result.paths.first!);
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('$e');
    }
  }

  void scrollToBottom({bool isDelayed = false}) {
    final delay = isDelayed ? 400 : 0;
    Future.delayed(Duration(milliseconds: delay), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: isDelayed ? 500 : 1),
          curve: Curves.easeOut);
    });
  }
}
