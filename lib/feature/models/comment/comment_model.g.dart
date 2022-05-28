// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      activityId: json['activityId'] as int?,
      questionId: json['questionId'] as int?,
      content: json['content'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
      likeCount: json['likeCount'] as int?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      isLiked: json['isLiked'] as bool?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('user', instance.user);
  writeNotNull('activityId', instance.activityId);
  writeNotNull('questionId', instance.questionId);
  writeNotNull('content', instance.content);
  writeNotNull('createdTime', instance.createdTime?.toIso8601String());
  writeNotNull('updateTime', instance.updateTime?.toIso8601String());
  writeNotNull('likeCount', instance.likeCount);
  writeNotNull('isLiked', instance.isLiked);
  return val;
}
