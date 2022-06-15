// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chat_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChatInfo _$UserChatInfoFromJson(Map<String, dynamic> json) => UserChatInfo(
      id: json['id'] as String?,
      isOnline: json['isOnline'] as bool?,
      lastSeen: dateTimeFromTimestamp(json['lastSeen'] as Timestamp?),
      currentChatId: json['currentChatId'] as String?,
      oneSignalIdList: (json['oneSignalIdList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserChatInfoToJson(UserChatInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isOnline': instance.isOnline,
      'lastSeen': dateTimeToTimestamp(instance.lastSeen),
      'currentChatId': instance.currentChatId,
      'oneSignalIdList': instance.oneSignalIdList,
    };
