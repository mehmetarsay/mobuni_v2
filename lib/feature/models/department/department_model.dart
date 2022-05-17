import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'department_model.g.dart';

@JsonSerializable()
class DeaprtmentModel extends BaseModel {
  DeaprtmentModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory DeaprtmentModel.fromJson(Map<String, dynamic> json) =>
      _$DeaprtmentModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$DeaprtmentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeaprtmentModelToJson(this);
}
