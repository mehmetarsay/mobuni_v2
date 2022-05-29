import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:mobuni_v2/core/constants/app/firebase_constants.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/messaging/chat.dart';
import 'package:mobuni_v2/feature/models/messaging/message.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:ntp/ntp.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  static FirebaseService? _instance;

  static FirebaseService? get instance {
    _instance ??= FirebaseService._init();
    return _instance;
  }

  FirebaseService._init();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<UserModel> getUser(String userId) async {
    var ds = await _firebaseFirestore
        .collection(FirebaseConstants.user)
        .doc(userId)
        .get();
    return UserModel.fromJson(ds.data() as Map<String, dynamic>);
  }

  /// Giriş yapmış kullanıcının aktiflik, son görülme ve aktif chat bilgilerini günceller
  Future updateUserState(bool isOnline, {String? currentCahtId}) async {
    var docRef = await _firebaseFirestore
        .collection(FirebaseConstants.user)
        .doc(GeneralManager.user.id)
        .get();
    var data = {
      'isOnline': isOnline,
      'currentChatId': currentCahtId,
      'lastSeen': Timestamp.now(),
      'userId': GeneralManager.user.id
    };
    if (docRef.data() != null) {
      await docRef.reference.update(data);
    } else {
      await docRef.reference.set(data);
    }
  }

  // ///
  // Future getModelSubscriberOneSignalList(String model, String gid,
  //     {bool isMyUser = true}) async {
  //   var userList = await getModelSubscriberUser(model, gid);
  //   if (isMyUser) {
  //     if ((userList as List).contains(GeneralManager.user.id)) {
  //       userList.remove(GeneralManager.user.id);
  //     }
  //   }
  //   return await getOneSignalIdList(userList);
  // }

  // /// Verilen kullanıcı listesindeki tüm kullanıcıların one signal id listesini getirir
  // Future getOneSignalIdList(List userList) async {
  //   var list = [];
  //   if (userList.isNotEmpty) {
  //     var result = await _firebaseFirestore
  //         .collection(FirebaseConstants.user)
  //         .where('userId', whereIn: userList)
  //         .get();
  //     result.docs
  //         .map((e) => list.addAll(e.data()['oneSignalIdList'] ?? []))
  //         .toList();
  //   }
  //   print(list);
  //   return list;
  // }

  /// Bir modelin kayıtlı abone kullanıcı listesini getirir
  Future getModelSubscriberUser(String model, String gid) async {
    var result = await _firebaseFirestore.collection(model).doc(gid).get();
    return result.data() != null
        ? result.data()!['subscriberUserList'] ?? []
        : [];
  }

  // /// Bir modelin kayıtlı abone kullanıcı listesine ekleme veya çıkarma yapar
  // Future updateModelSubscriberUser(String model, String gid,
  //     {List? userList, isAdd = true}) async {
  //   var docRef = await _firebaseFirestore.collection(model).doc(gid).get();
  //   var subscriberUserList =
  //       docRef.data() != null ? docRef.data()!['subscriberUserList'] ?? [] : [];
  //   var subscriberUserSet = <dynamic>{};
  //   subscriberUserSet.addAll(subscriberUserList);
  //   if (isAdd) {
  //     if (userList == null) {
  //       subscriberUserSet.add(GeneralManager.user.id!);
  //     } else {
  //       subscriberUserSet.addAll(userList);
  //     }
  //   } else {
  //     subscriberUserSet.remove(GeneralManager.user.id!);
  //   }
  //   await docRef.reference
  //       .set({'gid': gid, 'subscriberUserList': subscriberUserSet.toList()});
  // }

  // /// Bir kullanıcının kayıtlı one signal id listesini getirir
  // Future<dynamic> getUserOneSignalIdList(String userId) async {
  //   var result = await _firebaseFirestore
  //       .collection(FirebaseConstants.user)
  //       .doc(userId)
  //       .get();
  //   if (result != null) {
  //     var resultList = (result.data() ?? {})['oneSignalIdList'] ?? [];
  //     var newList = <String>[];
  //     (resultList as List).forEach((element) {
  //       newList.add(element);
  //     });
  //     return newList;
  //   } else {
  //     return <String>[];
  //   }
  // }

  // /// Bir kullanıcının kayıtlı one signal id listesine ekleme veya çıkarma yapar
  // void updateUserOneSignalId(String oneSignalId, {isAdd = true}) async {
  //   var docRef = await _firebaseFirestore
  //       .collection(FirebaseConstants.user)
  //       .doc(GeneralManager.user.id)
  //       .get();
  //   var list =
  //       docRef.data() != null ? docRef.data()!['oneSignalIdList'] ?? [] : [];
  //   var set = <dynamic>{};
  //   set.addAll(list);
  //   if (isAdd) {
  //     set.add(oneSignalId);
  //   } else {
  //     set.remove(oneSignalId);
  //   }
  //   var data = {
  //     'userId': GeneralManager.user.id,
  //     'oneSignalIdList': set.toList()
  //   };
  //   if (docRef.data() != null) {
  //     await docRef.reference.update(data);
  //   } else {
  //     await docRef.reference.set(data);
  //   }
  // }

  /// Kullanıcının bulunduğu sohbetleri listeler. Akış sağlar
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(String userId) {
    return _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .orderBy('updateTime', descending: true)
        .where('users', arrayContainsAny: [userId]).snapshots();
  }

  /// [chatId] ile chat bilgilerini getirir
  Future<Chat?> getChatWithChatId(String chatId) async {
    var result = await _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatId)
        .get();
    if (result != null) {
      var chat = Chat().fromJson(result.data()!);
      chat.receiverUserInit;
      return chat;
    } else {
      return null;
    }
  }

  /// [chatId] ile mesajları listeler. Akışı sağlar
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamChat(String chatId) {
    return _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatId)
        .snapshots();
  }

  Future<Chat> getChat(List<String> userList, ChatType chatType,
      {String? groupName, String? groupDesc}) async {
    // var userList = [userId, receiverId];
    var querySnapshot;
    if (userList.length == 2) {
      userList.sort((a, b) => a.compareTo(b));
      querySnapshot = await _firebaseFirestore
          .collection(FirebaseConstants.chat)
          .where('users', isEqualTo: userList)
          .get();
    }

    if (userList.length > 2 || querySnapshot.docs.isEmpty) {
      var docRef = _firebaseFirestore.collection(FirebaseConstants.chat).doc();
      var chat = Chat(
          id: docRef.id,
          type: chatType.index,
          users: userList,
          updateTime: await NTP.now(),
          groupName: groupName,
          groupDesc: groupDesc,
          groupFounder: GeneralManager.user.id!);
      await docRef.set(chat.toJson());
      chat.receiverUserInit;
      return chat;
    } else {
      var chat = Chat().fromJson(querySnapshot.docs.first.data());
      chat.receiverUserInit;
      return chat;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {
    return _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatId)
        .collection(FirebaseConstants.messaging)
        .orderBy('time')
        .limitToLast(20)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserChatInfo(
      String userId) {
    return _firebaseFirestore
        .collection(FirebaseConstants.user)
        .doc(userId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersChatInfo(List userList) {
    userList.remove(GeneralManager.user.id);
    return _firebaseFirestore
        .collection(FirebaseConstants.user)
        .where('userId', whereIn: userList)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserState() {
    return _firebaseFirestore.collection(FirebaseConstants.user).snapshots();
  }

  Future chatUnReadMessageClear(String chatId) async {
    var chatRef = await _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatId)
        .get();
    var chat = Chat.fromJson(chatRef.data()!);
    chat.unReadInfo!
        .putIfAbsent(GeneralManager.user.id!, () => UnReadInfo())!
        .counterClear;
    await chatRef.reference.update(chat.toJson());
  }

  Future sendChatMessage(
      String chatId, Message message, List inactiveUsersInThis) async {
    var chatRef = await _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatId)
        .get();
    await chatRef.reference
        .collection(FirebaseConstants.messaging)
        .doc(message.id)
        .set(message.toJson());
    var chat = Chat.fromJson(chatRef.data()!);
    if (inactiveUsersInThis.isNotEmpty) {
      inactiveUsersInThis.forEach((element) {
        if (element != GeneralManager.user.id) {
          chat.unReadInfo!.putIfAbsent(element, () => UnReadInfo())!.counter();
        }
      });
    }
    chat.lastMessage = message;
    chat.updateTime = await NTP.now();
    await chatRef.reference.update(chat.toJson());
  }

  Future sendChatFileMessage(
      String chatId, Message message, List inactiveUsersInThis) async {
    var ref = _firebaseStorage.ref('chat');
    var result = await ref.child(Uuid().v1()).putFile(File(message.filePath!));
    if (result.state == TaskState.success) {
      message.filePath = await result.ref.getDownloadURL();
      await sendChatMessage(chatId, message, inactiveUsersInThis);
    }
  }

  Future sendChatImageMessage(String chatId, Message message,
      List<Media> mediaList, List inactiveUsersInThis) async {
    var ref = _firebaseStorage.ref('chat');
    var mediaNameList = <String>[];
    for (var media in mediaList) {
      try {
        var result = await ref.child(Uuid().v1()).putFile(File(media.path!));
        if (result.state == TaskState.success) {
          mediaNameList.add(await result.ref.getDownloadURL());
        }
      } on FirebaseException catch (e) {
        print('Firebase Storage upload File Error: $e');
      }
    }
    message.imageList = mediaNameList;
    await sendChatMessage(chatId, message, inactiveUsersInThis);
  }

  Future<String?> changeGroupPhoto(File? photo, String chatid) async {
    var ref = _firebaseStorage.ref('group');
    try {
      var result = await ref.child(Uuid().v1()).putFile(File(photo!.path));
      if (result.state == TaskState.success) {
        var url = await result.ref.getDownloadURL();
        var docRef = await _firebaseFirestore
            .collection(FirebaseConstants.chat)
            .doc(chatid)
            .get();
        var data = {
          'groupPhoto': url,
        };
        await docRef.reference.update(data);
        return url;
      }
    } on FirebaseException catch (e) {
      print('Firebase Storage upload File Error: $e');
    }
    return null;
  }

  Future updateGroup(
      String? chatid, String? groupName, String? groupDesc) async {
    var docRef = await _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatid)
        .get();

    var data = {'groupName': groupName, 'groupDesc': groupDesc};
    await docRef.reference.update(data);
  }

  Future deleteGroup(String? chatid) async {
    var docRef =
        _firebaseFirestore.collection(FirebaseConstants.chat).doc(chatid);

    await docRef.delete();
  }

  Future userDeleteGroup(String? chatid, List<String>? users) async {
    var docRef = await _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatid)
        .get();

    var data = {'users': users};
    await docRef.reference.update(data);
  }

  Future exitGroup(String? chatid, List<String> users) async {
    var docRef = await _firebaseFirestore
        .collection(FirebaseConstants.chat)
        .doc(chatid)
        .get();
    if (users.contains(GeneralManager.user.id)) {
      users.remove(GeneralManager.user.id);
    }
    var rnd = Random();
    var groupFounder = users[rnd.nextInt(users.length)].toString();
    var data = {'users': users, 'groupFounder': groupFounder};
    await docRef.reference.update(data);
  }
}
