import '/core/base/models/base_model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BaseResponse extends BaseModel {
  BaseResponse({this.status, this.data, this.message});

  @JsonKey(defaultValue: false)
  bool? status;
  Object? data;
  String? message;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  @override
  BaseResponse fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
