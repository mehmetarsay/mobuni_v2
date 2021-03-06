import 'package:flutter/foundation.dart';
import 'package:mobuni_v2/core/constants/app/private_constants.dart';

class ApiConstants {
  static String baseUrl = kReleaseMode
      ? PrivateConstants.productionUrl
      : PrivateConstants.developmentUrl;
  
  static String user = 'User';
  static String login = 'User/Login';
  static String register = 'User/Register';
  static String uploadProfileImage = 'User/UploadProfileImage';
  static String getByUserId = 'User/GetByUserId';
  static String questionGetByUniversityId = 'Question/GetByUniversityId';
  static String questionGetByQuestionId = 'Question/GetByQuestionId';
  static String questionCountsByUniversityId = 'Question/GetQuestionCountsByUniversityId';
  static String likeQuestion = 'Question/LikeQuestion';
  static String getQuestionsByUserId = 'Question/GetQuestionsByUserId';
  static String like = 'Like';
  static String universityAll = 'University/GetAll';
  static String departmentAll = 'Department/ALL';
  static String question = 'Question';
  static String questionComment = 'QuestionComment';
  static String questionCommentGetByQuestionId = 'QuestionComment/GetByQuestionId';
  static String activityCommentGetByActivityId = 'QuestionComment/GetByActivityId';
  static String userAll = 'User/GetAll';
  static String userById = 'User/GetByUserId';
  static String activityCategory = 'ActivityCategory';
  static String activity = 'Activity';
  static String joinOrLeave = 'Activity/JoinOrLeave';
  static String getActivityCountsByUniversityId = 'Activity/GetActivityCountsByUniversityId';
}
