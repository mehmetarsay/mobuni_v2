// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
      content: json['content'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      universityId: json['universityId'] as int?,
      university: json['university'] == null
          ? null
          : UniversityModel.fromJson(
              json['university'] as Map<String, dynamic>),
      createdTime: json['createdTime'] == null
          ? null
          : DateTime.parse(json['createdTime'] as String),
      updatedTime: json['updatedTime'] == null
          ? null
          : DateTime.parse(json['updatedTime'] as String),
      activityStartTime: json['activityStartTime'] == null
          ? null
          : DateTime.parse(json['activityStartTime'] as String),
      activityEndTime: json['activityEndTime'] == null
          ? null
          : DateTime.parse(json['activityEndTime'] as String),
      commentCount: json['commentCount'] as int?,
      likeCount: json['likeCount'] as int?,
      maxUser: json['maxUser'] as int?,
      ticketPrice: json['ticketPrice'] as int?,
      isActive: json['isActive'] as bool?,
      isExternal: json['isExternal'] as bool?,
      timeout: json['timeout'] as bool?,
      activityCategories: (json['activityCategories'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      isJoined: json['isJoined'] as bool?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user', instance.user);
  writeNotNull('userId', instance.userId);
  writeNotNull('content', instance.content);
  writeNotNull('title', instance.title);
  writeNotNull('image', instance.image);
  writeNotNull('universityId', instance.universityId);
  writeNotNull('university', instance.university);
  writeNotNull('createdTime', instance.createdTime?.toIso8601String());
  writeNotNull('updatedTime', instance.updatedTime?.toIso8601String());
  writeNotNull(
      'activityStartTime', instance.activityStartTime?.toIso8601String());
  writeNotNull('activityEndTime', instance.activityEndTime?.toIso8601String());
  writeNotNull('commentCount', instance.commentCount);
  writeNotNull('likeCount', instance.likeCount);
  writeNotNull('maxUser', instance.maxUser);
  writeNotNull('ticketPrice', instance.ticketPrice);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('isExternal', instance.isExternal);
  writeNotNull('timeout', instance.timeout);
  writeNotNull('activityCategories', instance.activityCategories);
  writeNotNull('isJoined', instance.isJoined);
  return val;
}
