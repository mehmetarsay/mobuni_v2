// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_model.dart';

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
