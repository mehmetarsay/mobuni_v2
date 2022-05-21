import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/feature/utils/helpers.dart';

part 'user_chat_info.g.dart';

@JsonSerializable()
class UserChatInfo extends BaseModel{
  String? userGid;
  bool? isOnline;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: dateTimeToTimestamp, disallowNullValue: false)
  DateTime? lastSeen;
  String? currentChatId;
  List<String>? oneSignalIdList;

  UserChatInfo(
      {this.userGid,
      this.isOnline,
      this.lastSeen,
      this.currentChatId,
      this.oneSignalIdList});

  factory UserChatInfo.fromJson(Map<String, dynamic> json) => _$UserChatInfoFromJson(json);
  @override
  UserChatInfo fromJson(Map<String, dynamic> json) => _$UserChatInfoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserChatInfoToJson(this);
}
