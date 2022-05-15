
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends BaseModel{
  int id;
  String userId;
  DateTime createdTime;
  DateTime? updatedTime;
  String text;
  String? image;
  int commentCount;
  int likeCount;
  int universityId;
  int? departmentId;

  QuestionModel({
    required this.id,
    required this.userId,
    required this.createdTime,
    required this.universityId,
    required this.text,
    this.updatedTime,
    this.image,
    this.commentCount=0,
    this.departmentId,
    this.likeCount = 0,
});

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return JsonSerializable.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return _$QuestionModelToJson(this);
  }

}