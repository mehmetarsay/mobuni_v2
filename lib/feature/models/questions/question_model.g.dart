// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as int,
      userId: json['userId'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      universityId: json['universityId'] as int,
      text: json['text'] as String,
      updatedTime: json['updatedTime'] == null
          ? null
          : DateTime.parse(json['updatedTime'] as String),
      image: json['image'] as String?,
      commentCount: json['commentCount'] as int? ?? 0,
      departmentId: json['departmentId'] as int?,
      likeCount: json['likeCount'] as int? ?? 0,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdTime': instance.createdTime.toIso8601String(),
      'updatedTime': instance.updatedTime?.toIso8601String(),
      'text': instance.text,
      'image': instance.image,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'universityId': instance.universityId,
      'departmentId': instance.departmentId,
    };
