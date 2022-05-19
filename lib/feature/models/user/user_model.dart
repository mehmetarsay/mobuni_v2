import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
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

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? userName;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? surname;
  @HiveField(6)
  String? password;
  @HiveField(7)
  int? userType;
  @HiveField(8)
  String? image;
  @HiveField(9)
  int? universityId;
  @HiveField(10)
  int? departmentId;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
