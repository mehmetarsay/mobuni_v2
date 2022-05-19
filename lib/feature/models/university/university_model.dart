import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'university_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(includeIfNull: false)
class UniversityModel extends BaseModel {
  UniversityModel({
    this.id,
    this.name,
    this.province,
    this.district,
    this.logo,
    this.foundationYear,
    this.description,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? province;
  @HiveField(3)
  String? district;
  @HiveField(4)
  dynamic logo;
  @HiveField(5)
  String? foundationYear;
  @HiveField(6)
  String? description;

  String get dropdownText => name ?? '';
  int? get dropdownValue => id;

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$UniversityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UniversityModelToJson(this);
}
