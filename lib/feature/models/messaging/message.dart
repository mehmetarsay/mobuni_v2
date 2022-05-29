
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';

import '../../utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message extends BaseModel {
  String? id;
  String? message;
  int? messageType;
  String? sender;
  List<String>? receiverList;
  Map<String, bool>? isReadMap;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp)
  DateTime? time;
  List<String>? imageList;
  String? fileName;
  String? filePath;
  double? latitude;
  double? longitude;
  String? gid;

  @JsonKey(ignore: true)
  String? senderName;

  Message(
      {this.id,
      this.message,
      this.messageType,
      this.sender,
      this.receiverList,
      this.isReadMap,
      this.time,
      this.imageList,
      this.fileName,
      this.filePath,
      this.latitude,
      this.longitude,
      this.gid}) {
    isReadMap ??= <String, bool>{};
  }

  bool get isReadMessage {
    for (var i in isReadMap!.values) {
      if (i == false) {
        return false;
      }
    }
    return true;
  }

  void updateReadWithuserId(String userId) {
    isReadMap!.update(userId, (value) => true, ifAbsent: () => true);
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    var messageClass = _$MessageFromJson(json);
    messageClass.initSender();
    return messageClass;
  }

  @override
  Message fromJson(Map<String, dynamic> json) {
    var messageClass = _$MessageFromJson(json);
    messageClass.initSender();
    return messageClass;
  }

  @override
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  void initSender() async {
    // var senderUser  = await GeneralManager.authS.getUserById(sender!);
    var senderUser  = await FirebaseService.instance!.getUser(sender!);;
    senderName = senderUser.fullName;
    // for (var user in GeneralManager.userList!) {
    //   user as User;
    //   if (user.id == sender) {
    //     senderName = user.fullName;
    //   }
    // }
  }
}
