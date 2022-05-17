// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      universityId: json['universityId'] as int?,
      text: json['text'] as String?,
      updatedTime: json['updatedTime'] == null
          ? null
          : DateTime.parse(json['updatedTime'] as String),
      image: json['image'] as String?,
      commentCount: json['commentCount'] as int? ?? 0,
      likeCount: json['likeCount'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      university: json['university'] == null
          ? null
          : UniversityModel.fromJson(
              json['university'] as Map<String, dynamic>),
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userId', instance.userId);
  writeNotNull('createdTime', instance.createdTime?.toIso8601String());
  writeNotNull('updatedTime', instance.updatedTime?.toIso8601String());
  writeNotNull('text', instance.text);
  writeNotNull('image', instance.image);
  val['commentCount'] = instance.commentCount;
  val['likeCount'] = instance.likeCount;
  writeNotNull('universityId', instance.universityId);
  writeNotNull('user', instance.user);
  writeNotNull('university', instance.university);
  val['isLiked'] = instance.isLiked;
  return val;
}
