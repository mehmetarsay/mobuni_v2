// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: json['id'] as String?,
      type: json['type'] as int?,
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      unReadInfo: (json['unReadInfo'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                e == null
                    ? null
                    : UnReadInfo.fromJson(e as Map<String, dynamic>)),
          ) ??
          {},
      updateTime: dateTimeFromTimestamp(json['updateTime'] as Timestamp?),
      groupName: json['groupName'] as String?,
      groupDesc: json['groupDesc'] as String?,
      groupPhoto: json['groupPhoto'] as String?,
      groupFounder: json['groupFounder'] as String?,
    )
      ..lastMessage = json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>)
      ..receiverUser = json['receiverUser'] == null
          ? null
          : UserModel.fromJson(json['receiverUser'] as Map<String, dynamic>);

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'users': instance.users,
      'unReadInfo': UnReadInfoMapToMap(instance.unReadInfo),
      'lastMessage': messageToJson(instance.lastMessage),
      'updateTime': dateTimeToTimestamp(instance.updateTime),
      'groupName': instance.groupName,
      'groupDesc': instance.groupDesc,
      'groupPhoto': instance.groupPhoto,
      'groupFounder': instance.groupFounder,
      'receiverUser': instance.receiverUser,
    };

UnReadInfo _$UnReadInfoFromJson(Map<String, dynamic> json) => UnReadInfo(
      unReadMessage: json['unReadMessage'] as int? ?? 0,
    );

Map<String, dynamic> _$UnReadInfoToJson(UnReadInfo instance) =>
    <String, dynamic>{
      'unReadMessage': instance.unReadMessage,
    };
