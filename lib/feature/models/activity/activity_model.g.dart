// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityModelAdapter extends TypeAdapter<ActivityModel> {
  @override
  final int typeId = 5;

  @override
  ActivityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityModel(
      id: fields[0] as int?,
      user: fields[1] as UserModel?,
      userId: fields[2] as String?,
      content: fields[3] as String?,
      title: fields[4] as String?,
      image: fields[5] as String?,
      universityId: fields[6] as int?,
      university: fields[7] as UniversityModel?,
      createdTime: fields[8] as DateTime?,
      updatedTime: fields[9] as DateTime?,
      activityStartTime: fields[10] as DateTime?,
      activityEndTime: fields[11] as DateTime?,
      commentCount: fields[12] as int?,
      likeCount: fields[13] as int?,
      maxUser: fields[14] as int?,
      ticketPrice: fields[15] as int?,
      isActive: fields[16] as bool?,
      isExternal: fields[17] as bool?,
      timeout: fields[18] as bool?,
      activityCategories: (fields[19] as List?)?.cast<int>(),
      isJoined: fields[20] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.universityId)
      ..writeByte(7)
      ..write(obj.university)
      ..writeByte(8)
      ..write(obj.createdTime)
      ..writeByte(9)
      ..write(obj.updatedTime)
      ..writeByte(10)
      ..write(obj.activityStartTime)
      ..writeByte(11)
      ..write(obj.activityEndTime)
      ..writeByte(12)
      ..write(obj.commentCount)
      ..writeByte(13)
      ..write(obj.likeCount)
      ..writeByte(14)
      ..write(obj.maxUser)
      ..writeByte(15)
      ..write(obj.ticketPrice)
      ..writeByte(16)
      ..write(obj.isActive)
      ..writeByte(17)
      ..write(obj.isExternal)
      ..writeByte(18)
      ..write(obj.timeout)
      ..writeByte(19)
      ..write(obj.activityCategories)
      ..writeByte(20)
      ..write(obj.isJoined);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
