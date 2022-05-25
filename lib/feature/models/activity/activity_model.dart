import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';

part 'activity_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ActivityModel extends BaseModel {
  ActivityModel({
    this.id,
    this.user,
    this.userId,
    this.content,
    this.title,
    this.image,
    this.universityId,
    this.university,
    this.createdTime,
    this.updatedTime,
    this.activityStartTime,
    this.activityEndTime,
    this.commentCount,
    this.likeCount,
    this.maxUser,
    this.ticketPrice,
    this.isActive,
    this.isExternal,
    this.timeout,
    this.activityCategories,
    this.isJoined,
  });

  int? id;
  UserModel? user;
  String? userId;
  String? content;
  String? title;
  String? image;
  int? universityId;
  UniversityModel? university;
  DateTime? createdTime;
  DateTime? updatedTime;
  DateTime? activityStartTime;
  DateTime? activityEndTime;
  int? commentCount;
  int? likeCount;
  int? maxUser;
  int? ticketPrice;
  bool? isActive;
  bool? isExternal;
  bool? timeout;
  List<int>? activityCategories;
  bool? isJoined;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
