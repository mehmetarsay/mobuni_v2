// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityCategoryModelAdapter extends TypeAdapter<ActivityCategoryModel> {
  @override
  final int typeId = 3;

  @override
  ActivityCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityCategoryModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      isSelected: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCategoryModel _$ActivityCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ActivityCategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ActivityCategoryModelToJson(
        ActivityCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };
