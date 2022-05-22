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
  static String questionGetByUniversityId = 'Question/GetByUniversityId';
  static String questionCountsByUniversityId = 'Question/GetQuestionCountsByUniversityId';
  static String likeQuestion = 'Question/LikeQuestion';
  static String like = 'Like';
  static String universityAll = 'University/GetAll';
  static String departmentAll = 'Department/ALL';
  static String question = 'Question';
  static String questionComment = 'QuestionComment';
  static String questionCommentGetByActivityId = 'QuestionComment/GetByQuestionId';
  static String userAll = 'User/GetAll';
  static String userById = 'User/GetByUserId';
}
