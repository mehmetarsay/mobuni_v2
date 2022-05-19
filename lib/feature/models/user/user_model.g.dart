// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      userName: fields[1] as String?,
      email: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      name: fields[4] as String?,
      surname: fields[5] as String?,
      password: fields[6] as String?,
      userType: fields[7] as int?,
      image: fields[8] as String?,
      universityId: fields[9] as int?,
      departmentId: fields[10] as int?,
    )
      ..university = fields[11] as UniversityModel?
      ..department = fields[12] as DeaprtmentModel?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.surname)
      ..writeByte(6)
      ..write(obj.password)
      ..writeByte(7)
      ..write(obj.userType)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.universityId)
      ..writeByte(10)
      ..write(obj.departmentId)
      ..writeByte(11)
      ..write(obj.university)
      ..writeByte(12)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
    )
      ..university = json['university'] == null
          ? null
          : UniversityModel.fromJson(json['university'] as Map<String, dynamic>)
      ..department = json['department'] == null
          ? null
          : DeaprtmentModel.fromJson(
              json['department'] as Map<String, dynamic>);

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
  writeNotNull('university', instance.university);
  writeNotNull('department', instance.department);
  return val;
}
