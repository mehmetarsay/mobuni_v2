import 'dart:io';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:stacked/stacked.dart';

class ChatGroupInfoViewModel extends BaseViewModel {
  BuildContext context;
  Chat chat;
  var groupTitleController = TextEditingController();
  var groupDescController = TextEditingController();
  bool _isLoading = false;
  ChatGroupInfoViewModel(this.context, this.chat);

  // @override
  // Stream<QuerySnapshot<Map<String, dynamic>>> get stream =>
  //     FirebaseService.instance!.getAllUserState();

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  List _users = []; 
  List<dynamic> get getGroupUsers => _users;
  // List<dynamic> get getGroupUsers {
  //   var list = [];

  //   for (var userGid in chat.users!) {
  //     var user = GeneralManager.userDummy;
  //     // GeneralManager.userList!.firstWhere((element) => (element as User).gid == userGid);
  //     user as UserModel;
  //     var userChatInfo;
  //     for (var element in (data as QuerySnapshot<Map<String, dynamic>>).docs) {
  //       var currentUserChatInfo = UserChatInfo.fromJson(element.data());
  //       if (currentUserChatInfo.userGid == user.id) {
  //         userChatInfo = currentUserChatInfo;
  //         break;
  //       }
  //     }
  //     list.add([user, userChatInfo]);
  //   }
  //   return list;
  // }

  Future getUsers(List users) async {
    for(var i in users){
      var user = await GeneralManager.authS.getUserById(i);
      _users.add(user);
    }
    notifyListeners();
  }

  void initialize(BuildContext context, List? users) async {
    isLoading = true;
    this.context = context;
    groupTitleController.text = chat.groupName ?? '';
    groupDescController.text = chat.groupDesc ?? '';
    await getUsers(users!);
    isLoading = false;
  }

  File? _imageFile;

  File? get imageFile => _imageFile;

  set imageFile(File? value) {
    _imageFile = value;
    notifyListeners();
  }

  void imgFromGallery() async {
    var resultList = <Media>[];
    try {
      resultList = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 1,
          showGif: false,
          showCamera: true,
          compressSize: 500,
          uiConfig:
              UIConfig(uiThemeColor: Theme.of(context).colorScheme.tertiary),
          cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    } catch (e) {
      print('$e');
    }
    if (resultList.isNotEmpty) {
      isLoading = true;
      imageFile = File((resultList.first).path!);
      var url =
          await FirebaseService.instance!.changeGroupPhoto(imageFile, chat.id!);
      if (url != null) {
        chat.groupPhoto = url;
      }

      await Fluttertoast.showToast(
          msg: 'Group Fotoğrafı Başarıyla Güncellendi',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      Navigator.pop(context);
      isLoading = false;
    }
  }

  void updateGroup() async {
    await FirebaseService.instance!.updateGroup(
        chat.id, groupTitleController.text, groupDescController.text);
    chat.groupName = groupTitleController.text;
    chat.groupDesc = groupDescController.text;
    notifyListeners();
    await Fluttertoast.showToast(
        msg: 'Group Başarıyla Güncellendi',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    Navigator.pop(context);
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }

  Future deleteGroup() async {
    await FirebaseService.instance!.deleteGroup(chat.id);
    await Fluttertoast.showToast(
        msg: 'Group Başarıyla Silindi',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    Navigator.pop(context);
    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }
  }

  Future deleteUserGroup(String userGid) async {
    chat.users!.removeWhere((element) => element == userGid);
    chat.users!.add(GeneralManager.user.id!);
    await FirebaseService.instance!.userDeleteGroup(chat.id, chat.users);
    Navigator.pop(context);
    await Fluttertoast.showToast(
        msg: 'Kişi Çıkarıldı',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    chat.users!.removeWhere((element) => element == GeneralManager.user.id);
    notifyListeners();
  }

  Future exitGroup(bool state) async {
    await FirebaseService.instance!.exitGroup(chat.id, chat.users!);
    Navigator.pop(context);
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    if (state) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }

    await Fluttertoast.showToast(
        msg: 'Gruptan Çıkıldı',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}
