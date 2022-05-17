import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'university_model.g.dart';

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

  int? id;
  String? name;
  String? province;
  String? district;
  dynamic logo;
  String? foundationYear;
  String? description;

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$UniversityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UniversityModelToJson(this);
}
