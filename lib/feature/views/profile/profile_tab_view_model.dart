import 'package:flutter/cupertino.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:stacked/stacked.dart';


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