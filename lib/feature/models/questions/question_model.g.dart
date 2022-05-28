// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionModelAdapter extends TypeAdapter<QuestionModel> {
  @override
  final int typeId = 4;

  @override
  QuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModel(
      id: fields[0] as int?,
      userId: fields[1] as String?,
      createdTime: fields[2] as DateTime?,
      universityId: fields[8] as int?,
      text: fields[4] as String?,
      updatedTime: fields[3] as DateTime?,
      image: fields[5] as String?,
      commentCount: fields[6] as int,
      likeCount: fields[7] as int,
      user: fields[9] as UserModel?,
      university: fields[10] as UniversityModel?,
      isLiked: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.createdTime)
      ..writeByte(3)
      ..write(obj.updatedTime)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.commentCount)
      ..writeByte(7)
      ..write(obj.likeCount)
      ..writeByte(8)
      ..write(obj.universityId)
      ..writeByte(9)
      ..write(obj.user)
      ..writeByte(10)
      ..write(obj.university)
      ..writeByte(11)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
