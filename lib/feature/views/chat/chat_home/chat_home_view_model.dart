import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/manager/general_manager.dart';

class ChatHomeViewModel extends StreamViewModel<List<Chat>> {
  late BuildContext context;
  var searchController = TextEditingController();
  var focus = FocusNode();
  List<dynamic> searchChatList = [];
  List<dynamic> chatList = <dynamic>[];
  bool? _isSearch = false;
  bool? get isSearch => _isSearch;

  set isSearch(bool? value) {
    _isSearch = value;
    notifyListeners();
  }

  void initialize(BuildContext context) async {
    this.context = context;
    searchController.addListener(listenerMethod);
    await Future.delayed(Duration(seconds: 1));
    // await AuthenticateService.instance!.getAllUser().then((value) async {
    //   for (var i in value!) {
    //     if (i.gid != "") {
    //       await i.oneSignalIdInit();
    //     }
    //   }
    //   GlobalValue.userList = value;
    // });
    // KeyboardVisibilityController().onChange.listen((event) {
    //   print(event);
    //   if (!event) {
    //     focus.unfocus();
    //   }
    // });
    chatList = getChats;
  }

  @override
  Stream<List<Chat>> get stream =>
      FirebaseService.instance!.getChats(GeneralManager.user.id!).asyncMap(
        (query) async {
          var futures = query.docs.map(
            (doc) async {
              var data = doc.data();
              var chat = Chat.fromJson(data);
              await chat.receiverUserInit;
              return chat;
            },
          );
          return await Future.wait(futures);
        },
      );

  List<Chat> get getChats {
    return data ?? [];
  }

  void listenerMethod() {
    search(searchController.text);
  }

  void search(String value) {
    isSearch = value.isNotEmpty;
    searchChatList = chatList.where((element) {
      var query = element.type == 1
          ? element.groupName
          : element.receiverUser?.fullName;
      return query.toLowerCase().contains(value.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
