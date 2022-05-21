import '/core/base/models/base_model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse extends BaseModel {
  BaseResponse({
    this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  @JsonKey(defaultValue: false)
  bool? success;
  Object? data;
  String? message;
  int? statusCode;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  @override
  BaseResponse fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
