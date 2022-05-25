import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/constants/enum/user_type_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
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
  final password = TextEditingController();
  final passwordAgain = TextEditingController();
  int universityId = -1;
  int departmentId = -1;
  List universityList = [];
  List departmentList = [];
  var _isHighSchool = false;
  get isHighSchool => _isHighSchool;

  set isHighSchool(var value) {
    _isHighSchool = value;
    notifyListeners();
  }

  initialize(BuildContext context) async {
    isLoading = true;
    universityList = await _authService.getAllUniversity();
    departmentList = await _authService.getAllDepartment();
    isLoading = false;
  }

  void register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Lütfen gerekli alanları doldurunuz');
      return;
    }
    if (!isHighSchool) {
      if (universityId == -1) {
        Fluttertoast.showToast(msg: 'Lütfen üniversite seçiniz');
        return;
      }
      if (departmentId == -1) {
        Fluttertoast.showToast(msg: 'Lütfen bölüm seçiniz');
        return;
      }
    }
    if (password.text != passwordAgain.text) {
      Fluttertoast.showToast(msg: 'Şifreler eşleşmiyor');
      return;
    }

    context.loaderOverlay.show();
    var user = UserModel(
      name: name.text,
      surname: surname.text,
      userName: userName.text,
      email: email.text,
      password: password.text,
      universityId: universityId,
      departmentId: departmentId,
      userType:isHighSchool ? UserTyoe.highscool.index : UserTyoe.university.index,
    );
    print(user.toJson());
    var response = await _authService.register(user);
    if (response is LoginModel) {
      _authService.saveToken(response.accessToken, response.user!);
      context.navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    }
    context.loaderOverlay.hide();
  }
}
