import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/user_chat_info.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:stacked/stacked.dart';

class ChatContactViewModel extends StreamViewModel {
  BuildContext context;
  bool _isLoading = false;
  var selectUserList = <String>[];
  var selectUserListPhoto = <photoList>[];
  var groupTitleController = TextEditingController();
  var groupDescController = TextEditingController();
  var searchController = TextEditingController();
  var focus = FocusNode();
  List<dynamic> searchUserList = [];
  List<dynamic> userList = <dynamic>[];
  bool _isForward = false;
  bool? _isSearch = false;
  bool? get isSearch => _isSearch;
  bool? isFirst = true;
  var allUser;

  set isSearch(bool? value) {
    _isSearch = value;
    notifyListeners();
  }

  void initialize(BuildContext context) async {
    this.context = context;
    searchController.addListener(listenerMethod);
    fetchAllUser();
    // KeyboardVisibilityController().onChange.listen((event) {
    //   print(event);
    //   if (!event) {
    //     focus.unfocus();
    //   }
    // });
  }

  void fetchAllUser()  async {
    isLoading = true;
    allUser = await GeneralManager.authS.getAllUser();
    isLoading = false;

  }

  void selectUserListUpdate(String gid,
      {isRemove = false, String? image, String? fullname}) {
    if (!isRemove) {
      selectUserList.add(gid);
      selectUserListPhoto
          .add(photoList(gid: gid, image: image, fullname: fullname));
    } else {
      selectUserList.remove(gid);
      selectUserListPhoto.removeWhere((element) => element.gid == gid);
    }
    notifyListeners();
  }

  bool get isforward => _isForward;

  set isforward(bool value) {
    _isForward = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  File? _imageFile;

  File? get imageFile => _imageFile;

  set imageFile(File? value) {
    _imageFile = value;
    notifyListeners();
  }

  ChatContactViewModel(this.context);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> get stream =>
      FirebaseService.instance!.getAllUserState();

  List<dynamic> get contacts {
    var list = [];
    for (var user in (allUser ?? [])) {
    // for (var user in []) {
      user as UserModel;
      if (user.id != GeneralManager.user.id) {
        var userChatInfo;
        for (var element
            in (data as QuerySnapshot<Map<String, dynamic>>).docs) {
          var currentUserChatInfo = UserChatInfo.fromJson(element.data());
          if (currentUserChatInfo.userGid == user.id) {
            userChatInfo = currentUserChatInfo;
            break;
          }
        }
        list.add([user, userChatInfo]);
        if (user.name != null) {
          if (isFirst!) {
            userList.add(user);
          }
        }
      }
    }
    isFirst = false;
    return list;
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
          uiConfig: UIConfig(uiThemeColor: Theme.of(context).primaryColorDark),
          cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    } catch (e) {
      print('$e');
    }
    if (resultList.isNotEmpty) {
      isLoading = true;
      imageFile = File((resultList.first).path!);
      isLoading = false;
    }
  }

  Future<String?> updateGrupPhotoFirebase(String chatId) async {
    if (imageFile != null) {
      isLoading = true;
      var url =
          await FirebaseService.instance!.changeGroupPhoto(imageFile, chatId);
      isLoading = false;
      return url;
    }
    return null;
  }

  void listenerMethod() {
    search(searchController.text);
  }

  void search(String value) {
    isSearch = value.isNotEmpty;
    searchUserList = userList.where((element) {
      return element!.name!.toLowerCase().contains(value.toLowerCase());
    }).toList();
    notifyListeners();
  }
}

class photoList {
  String? gid;
  String? image;
  String? fullname;
  photoList({this.gid, this.image, this.fullname});
}
