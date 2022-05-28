import 'package:json_annotation/json_annotation.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';

import '/core/base/models/base_model/base_model.dart';


part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationModel<T extends BaseModel> extends BaseModel {
  PaginationModel({
    this.pageIndex,
    this.totalPages,
    this.items,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  int? pageIndex;
  int? totalPages;
  List<T>? items;
  bool? hasPreviousPage;
  bool? hasNextPage;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson<T>(json, (json) => fromJsonT<T>(json));

  @override
  fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson<T>(json, (json) => fromJsonT<T>(json));

  @override
  Map<String, dynamic> toJson() =>
      _$PaginationModelToJson(this, (value) => (value as T).toJson());

  // NOTE: Pagination Model ile kullanılacak model tipi kullanılmadan önce buraya eklenmelidir
  static dynamic fromJsonT<T>(Object? json) {
    if (T == QuestionModel) {
      return QuestionModel.fromJson(json as Map<String, dynamic>);
    }
    if (T == ActivityModel) {
      return ActivityModel.fromJson(json as Map<String, dynamic>);
    }

    return (T.runtimeType as BaseModel).fromJson(json as Map<String, dynamic>);
  }
}
