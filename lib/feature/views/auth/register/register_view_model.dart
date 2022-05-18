import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  AuthService _authService = locator<AuthService>();
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

  initialize(BuildContext context) async {
    isLoading = true;
    universityList = await _authService.getAllUniversity();
    departmentList = await _authService.getAllDepartment();
    isLoading = false;
  }

  void register(BuildContext context) async {
    if (password.text != passwordAgain.text) {
      Fluttertoast.showToast(msg: 'Şifreler eşleşmiyor');
      return;
    }
    // if(email.text.isEmpty || password.text.isEmpty){
    //   Fluttertoast.showToast(msg: 'Tüm alanları doldurunuz');
    //   return;
    // }
    context.loaderOverlay.show();
    var user = UserModel(
      name: name.text,
      surname: surname.text,
      userName: userName.text,
      email: email.text,
      password: password.text,
      universityId: universityId,
      departmentId: departmentId,
      userType: 1,
    );
    print(user.toJson());
    var response = await _authService.register(user);
    if (response is LoginModel) {
      locator<HiveService>()
          .hive
          .put(Constants.authToken, response.accessToken);
      context.navigationService.navigateTo(Routes.bottomNavView);
    }
    context.loaderOverlay.hide();
  }
}
