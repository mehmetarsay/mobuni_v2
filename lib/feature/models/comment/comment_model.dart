import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';

part 'comment_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CommentModel extends BaseModel {
  int? id;
  String? userId;
  UserModel? user;
  int? activityId;
  int? questionId;
  String? content;
  DateTime? createdTime;
  DateTime? updateTime;
  int? likeCount;
  bool? isLiked;

  CommentModel(
  {
     this.id,
     this.userId,
     this.activityId,
     this.questionId,
     this.content,
    this.createdTime,
    this.updateTime,
    this.likeCount,
    this.user,
    this.isLiked,
}
  );

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);


  @override
  fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  

  @override
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
  
}
