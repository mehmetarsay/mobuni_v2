import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends BaseModel {
  LoginModel({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.user,
  });

  String? accessToken;
  String? tokenType;
  DateTime? expiresIn;
  UserModel? user;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  @override
  LoginModel fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
