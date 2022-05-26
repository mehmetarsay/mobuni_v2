import 'package:flutter/cupertino.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/enum/activity_or_question_enum.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/profile/service/profile_service.dart';
import 'package:stacked/stacked.dart';



class ProfileViewModel extends BaseViewModel {
  ScrollController controller = ScrollController();

  ProfileService profileService = locator<ProfileService>();

  ProfileListType _selectListType = ProfileListType.QuestionType;

  ProfileListType get selectListType => _selectListType;

  set selectListType(ProfileListType value) {
    _selectListType = value;
    notifyListeners();
  }

  List<QuestionModel>? questions = [];
  List<ActivityModel>? activities = [];

  late UserModel viewUser;


  bool _qALoading = false;
  bool get qALoading => _qALoading;
  SetQALoading(bool value) {
    _qALoading = value;
    notifyListeners();
  }


  init(String? userId) async {
    setInitialised(false);
    ///User initialize
    if(userId!=null){
      viewUser = await profileService.getUserProfile(userId)  ;
    }
    else{
      viewUser = GeneralManager.user;
    }

    setInitialised(true);
    notifyListeners();
    await getQuestionAndActivity();
  }

  Future getQuestionAndActivity() async {
    SetQALoading(false);
    ///TODO buraya user activity gelecek
    questions = await profileService.questionGetByUserId(userId: viewUser.id!);
    activities = await profileService.activityGetAllByUserId(userId: viewUser.id!);
    if(questions==null){
      questions =[];
    }
    if(activities==null){
      activities =[];
    }
    SetQALoading(true);
  }
}
