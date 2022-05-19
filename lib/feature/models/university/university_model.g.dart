// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UniversityModelAdapter extends TypeAdapter<UniversityModel> {
  @override
  final int typeId = 1;

  @override
  UniversityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UniversityModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      province: fields[2] as String?,
      district: fields[3] as String?,
      logo: fields[4] as dynamic,
      foundationYear: fields[5] as String?,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UniversityModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.province)
      ..writeByte(3)
      ..write(obj.district)
      ..writeByte(4)
      ..write(obj.logo)
      ..writeByte(5)
      ..write(obj.foundationYear)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniversityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityModel _$UniversityModelFromJson(Map<String, dynamic> json) =>
    UniversityModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      province: json['province'] as String?,
      district: json['district'] as String?,
      logo: json['logo'],
      foundationYear: json['foundationYear'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UniversityModelToJson(UniversityModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('province', instance.province);
  writeNotNull('district', instance.district);
  writeNotNull('logo', instance.logo);
  writeNotNull('foundationYear', instance.foundationYear);
  writeNotNull('description', instance.description);
  return val;
}
