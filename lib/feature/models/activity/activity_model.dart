import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/core/base/models/base_model/base_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';

part 'activity_model.g.dart';

@HiveType(typeId: 5)
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

  @HiveField(0)
  int? id;
  @HiveField(1)
  UserModel? user;
  @HiveField(2)
  String? userId;
  @HiveField(3)
  String? content;
  @HiveField(4)
  String? title;
  @HiveField(5)
  String? image;
  @HiveField(6)
  int? universityId;
  @HiveField(7)
  UniversityModel? university;
  @HiveField(8)
  DateTime? createdTime;
  @HiveField(9)
  DateTime? updatedTime;
  @HiveField(10)
  DateTime? activityStartTime;
  @HiveField(11)
  DateTime? activityEndTime;
  @HiveField(12)
  int? commentCount;
  @HiveField(13)
  int? likeCount;
  @HiveField(14)
  int? maxUser;
  @HiveField(15)
  int? ticketPrice;
  @HiveField(16)
  bool? isActive;
  @HiveField(17)
  bool? isExternal;
  @HiveField(18)
  bool? timeout;
  @HiveField(19)
  List<int>? activityCategories;
  @HiveField(20)
  bool? isJoined;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
