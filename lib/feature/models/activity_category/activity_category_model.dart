import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'activity_category_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class ActivityCategoryModel extends BaseModel {

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  bool isSelected;

  ActivityCategoryModel({
    this.id,
    this.name,
    this.isSelected = false
  });

  factory ActivityCategoryModel.fromJson(Map<String, dynamic> json) => _$ActivityCategoryModelFromJson(json);


  @override
  fromJson(Map<String, dynamic> json) => _$ActivityCategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActivityCategoryModelToJson(this);
}
