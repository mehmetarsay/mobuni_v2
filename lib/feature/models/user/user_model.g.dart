// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      password: json['password'] as String?,
      userType: json['userType'] as int?,
      image: json['image'] as String?,
      universityId: json['universityId'] as int?,
      departmentId: json['departmentId'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userName', instance.userName);
  writeNotNull('email', instance.email);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('password', instance.password);
  writeNotNull('userType', instance.userType);
  writeNotNull('image', instance.image);
  writeNotNull('universityId', instance.universityId);
  writeNotNull('departmentId', instance.departmentId);
  return val;
}
