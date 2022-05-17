import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: false)
class UserModel extends BaseModel {
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
    this.name,
    this.surname,
    this.password,
    this.userType,
    this.image,
    this.universityId,
    this.departmentId,
  });

  String? id;
  String? userName;
  String? email;
  String? phoneNumber;
  String? name;
  String? surname;
  String? password;
  int? userType;
  String? image;
  int? universityId;
  int? departmentId;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
