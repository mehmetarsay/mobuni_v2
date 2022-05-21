import '/core/base/models/base_model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'empty_response.g.dart';

@JsonSerializable()
class EmptyModel extends BaseModel {
  EmptyModel();


  factory EmptyModel.fromJson(Map<String, dynamic> json) => _$EmptyModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$EmptyModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmptyModelToJson(this);
}
