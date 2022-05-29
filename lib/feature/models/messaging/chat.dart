import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/core/constants/enum/chat_enums.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/utils/helpers.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';

import 'message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

Map<String, dynamic>? UnReadInfoMapToMap(Map<String, UnReadInfo?>? map) {
  var newMap = <String, dynamic>{};
  if (map != null) {
    map.entries
        .map((e) => newMap.putIfAbsent(e.key, () => e.value!.toJson()))
        .toList();
  }
  return newMap;
}

@JsonSerializable()
class Chat extends BaseModel {
  String? id;
  int? type;
  List<String>? users;
  @JsonKey(toJson: UnReadInfoMapToMap, defaultValue: <String, UnReadInfo?>{})
  Map<String, UnReadInfo?>? unReadInfo;
  @JsonKey(toJson: messageToJson)
  Message? lastMessage;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime? updateTime;
  String? groupName;
  String? groupDesc;
  String? groupPhoto;
  String? groupFounder;

  /// Bireysel mesajlaşma ise karşıdaki alıcı bilgilerini tutar
  @JsonKey(ignore: true)
  String? receiverUserId;
  @JsonKey(ignore: true)
  UserModel? receiverUser;

  Chat({
    this.id,
    this.type,
    this.users,
    this.unReadInfo,
    this.updateTime,
    this.groupName,
    this.groupDesc,
    this.groupPhoto,
    this.groupFounder,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var chat = _$ChatFromJson(json);
    chat.receiverUserInit;
    return chat;
  }

  @override
  Chat fromJson(Map<String, dynamic> json) {
    var chat = _$ChatFromJson(json);
    chat.receiverUserInit;
    return chat;
  }

  @override
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Future get receiverUserInit async {
    if (type == ChatType.SINGLE.index) {
      receiverUserId;
      for (var i in users!) {
        if (i != GeneralManager.user.id) receiverUserId = i;
      }
      // receiverUser = await GeneralManager.authS.getUserById(receiverUserId!);
      receiverUser = await FirebaseService.instance!.getUser(receiverUserId!);
    }
  }
}

Map<String, dynamic>? messageToJson(Message? message) {
  if (message != null) {
    return message.toJson();
  } else {
    return null;
  }
}

@JsonSerializable()
class UnReadInfo extends BaseModel {
  @JsonKey(defaultValue: 0)
  int? unReadMessage;

  UnReadInfo({this.unReadMessage});

  void counter() {
    print('counter' + unReadMessage.toString() );
    this.unReadMessage = (unReadMessage ?? 0) + 1;
  }

  void get counterClear => unReadMessage = 0;

  factory UnReadInfo.fromJson(Map<String, dynamic> json) =>
      _$UnReadInfoFromJson(json);

  @override
  UnReadInfo fromJson(Map<String, dynamic> json) => _$UnReadInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnReadInfoToJson(this);
}
