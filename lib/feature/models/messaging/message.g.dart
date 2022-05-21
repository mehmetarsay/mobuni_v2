// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String?,
      message: json['message'] as String?,
      messageType: json['messageType'] as int?,
      sender: json['sender'] as String?,
      receiverList: (json['receiverList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isReadMap: (json['isReadMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
      time: dateTimeFromTimestamp(json['time'] as Timestamp?),
      imageList: (json['imageList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fileName: json['fileName'] as String?,
      filePath: json['filePath'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      gid: json['gid'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'messageType': instance.messageType,
      'sender': instance.sender,
      'receiverList': instance.receiverList,
      'isReadMap': instance.isReadMap,
      'time': dateTimeToTimestamp(instance.time),
      'imageList': instance.imageList,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'gid': instance.gid,
    };
