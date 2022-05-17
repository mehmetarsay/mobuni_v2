import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends BaseModel {
  int? id;
  int? userId;
  int? tableId;
  int? tableType;
  String? content;
  DateTime? createdTime;
  DateTime? updateTime;
  int? likeCount;

  CommentModel(
  {
     this.id,
     this.userId,
     this.tableId,
     this.tableType,
     this.content,
    this.createdTime,
    this.updateTime,
    this.likeCount
}
  );

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
   return _$CommentModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return _$CommentModelToJson(this);
  }
}
