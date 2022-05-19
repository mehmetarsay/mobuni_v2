import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';

part 'question_model.g.dart';

@JsonSerializable(includeIfNull: false)
class QuestionModel extends BaseModel {
  int? id;
  String? userId;
  DateTime? createdTime;
  DateTime? updatedTime;
  String? text;
  String? image;
  int commentCount;
  int likeCount;
  int? universityId;
  //int? departmentId;
  UserModel? user;
  UniversityModel? university;
  bool isLiked;

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
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
