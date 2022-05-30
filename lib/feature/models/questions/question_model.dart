import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/feature/models/department/department_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';

part 'question_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(includeIfNull: false)
class QuestionModel extends BaseModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  DateTime? createdTime;
  @HiveField(3)
  DateTime? updatedTime;
  @HiveField(4)
  String? text;
  @HiveField(5)
  String? image;
  @HiveField(6)
  int commentCount;
  @HiveField(7)
  int likeCount;
  @HiveField(8)
  int? universityId;
  @HiveField(9)
  UserModel? user;
  @HiveField(10)
  UniversityModel? university;
  @HiveField(11)
  bool isLiked;
  @HiveField(12)
  int? departmentId;
  @HiveField(13)
  DeaprtmentModel? department;
  @HiveField(14)
  bool? isUniversityStudent;


  QuestionModel({
    this.id,
    this.userId,
    this.createdTime,
    this.universityId,
    this.text,
    this.updatedTime,
    this.image,
    this.commentCount = 0,
    this.likeCount = 0,
    this.user,
    this.university,
    this.isLiked = false,
    this.departmentId,
    this.department,
    this.isUniversityStudent,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
