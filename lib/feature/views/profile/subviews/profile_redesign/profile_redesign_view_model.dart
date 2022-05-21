import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/constants/enum/user_type_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';

class ProfileRedesignViewModel extends BaseViewModel {
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
  int universityId = -1;
  int departmentId = -1;
  List universityList = [];
  List departmentList = [];

  initialize(BuildContext context) async {
    isLoading = true;
    universityList = await _authService.getAllUniversity();
    departmentList = await _authService.getAllDepartment();
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
    if (GeneralManager.user.userType==1) {
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
    var user = UserModel(
      name: name.text,
      surname: surname.text,
      userName: userName.text,
      email: email.text,
      universityId: universityId,
      departmentId: departmentId,
      userType:GeneralManager.user.userType,
    );
    // var response = await _authService.register(user);
    // if (response is LoginModel) {
    //   _authService.saveToken(response.accessToken, response.user!);
    //   context.navigationService.pushNamedAndRemoveUntil(Routes.bottomNavView);
    // }
    context.loaderOverlay.hide();
  }
}