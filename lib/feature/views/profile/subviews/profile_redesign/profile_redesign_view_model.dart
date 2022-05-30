import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/user_type_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:mobuni_v2/feature/views/profile/service/profile_service.dart';
import 'package:stacked/stacked.dart';

class ProfileRedesignViewModel extends BaseViewModel {
  ProfileService _profileService = locator<ProfileService>();
  AuthService _authService = locator<AuthService>();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final name = TextEditingController();
  final surname = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  int? universityId;
  int? departmentId;
  List universityList = [];
  List departmentList = [];

  initialize(BuildContext context) async {
    name.text = GeneralManager.user.name!;
    surname.text = GeneralManager.user.surname!;
    userName.text = GeneralManager.user.userName!;
    email.text = GeneralManager.user.email!;
    isLoading = true;
   if(GeneralManager.user.isUniversityStudent!){
     universityList = await _authService.getAllUniversity();
     departmentList = await _authService.getAllDepartment();
     universityId = GeneralManager.user.universityId!;
     departmentId = GeneralManager.user.departmentId!;
   }
    isLoading = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void save(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Lütfen gerekli alanları doldurunuz');
      return;
    }
    if (GeneralManager.user.userType == 1) {
      if (universityId == -1) {
        Fluttertoast.showToast(msg: 'Lütfen üniversite seçiniz');
        return;
      }
      if (departmentId == -1) {
        Fluttertoast.showToast(msg: 'Lütfen bölüm seçiniz');
        return;
      }
    }
    context.loaderOverlay.show();
    var user =GeneralManager.user;
    user.name = name.text;
    user.surname =surname.text;
    user.universityId = universityId;
    user.departmentId = departmentId;
    try {
      var response = await _profileService.profileUpdate(user);
      if (response is UserModel) {
        GeneralManager.hiveM.hive.put(Constants.user, response);
        Fluttertoast.showToast(msg: 'Güncellendi');
        context.loaderOverlay.hide();
        context.navigationService.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Hata');
      context.loaderOverlay.hide();
    }
  }
}
