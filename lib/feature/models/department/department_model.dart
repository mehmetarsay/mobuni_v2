import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'department_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class DeaprtmentModel extends BaseModel {
  DeaprtmentModel({
    this.id,
    this.name,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  String get dropdownText => name ?? '';
  int? get dropdownValue => id;

  factory DeaprtmentModel.fromJson(Map<String, dynamic> json) =>
      _$DeaprtmentModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$DeaprtmentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeaprtmentModelToJson(this);
}
