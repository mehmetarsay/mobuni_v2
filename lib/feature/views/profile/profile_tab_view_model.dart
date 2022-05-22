import 'package:flutter/cupertino.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/profile/service/profile_service.dart';
import 'package:stacked/stacked.dart';

enum ProfileListType { QuestionType, ActivityType }

class ProfileTabViewModel extends BaseViewModel {
  ScrollController controller = ScrollController();

  ProfileService profileService = locator<ProfileService>();

  ProfileListType _selectListType = ProfileListType.QuestionType;

  ProfileListType get selectListType => _selectListType;

  set selectListType(ProfileListType value) {
    _selectListType = value;
    notifyListeners();
  }

  List<QuestionModel>? questions = [];

  late UserModel viewUser;


  bool _qALoading = false;
  bool get qALoading => _qALoading;
  SetQALoading(bool value) {
    _qALoading = value;
    notifyListeners();
  }


  init() async {
    setInitialised(false);
    ///User initialize
    viewUser = GeneralManager.user;
    setInitialised(true);
    notifyListeners();
    await getQuestionAndActivity();
  }

  Future getQuestionAndActivity() async {
    SetQALoading(false);
    ///TODO buraya user activity gelecek
    questions = await profileService.questionGetByUserId(userId: viewUser.id!);
    SetQALoading(true);
  }
}
