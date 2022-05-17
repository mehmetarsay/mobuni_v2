// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      tableId: json['tableId'] as int,
      tableType: json['tableType'] as int,
      content: json['content'] as String,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'tableId': instance.tableId,
      'tableType': instance.tableType,
      'content': instance.content,
      'createdTime': instance.createdTime?.toIso8601String(),
      'updateTime': instance.updateTime?.toIso8601String(),
    };
