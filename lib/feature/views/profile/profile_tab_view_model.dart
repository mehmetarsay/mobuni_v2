import 'package:flutter/cupertino.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

enum ProfileListType {
  QuestionType,
  ActivityType
}

class ProfileTabViewModel extends BaseViewModel {

  ScrollController controller = ScrollController();

  ProfileListType _selectListType = ProfileListType.QuestionType;

  ProfileListType get selectListType => _selectListType;

  set selectListType(ProfileListType value) {
    _selectListType = value;
    notifyListeners();
  }

  List<QuestionModel>? questions = [];
}