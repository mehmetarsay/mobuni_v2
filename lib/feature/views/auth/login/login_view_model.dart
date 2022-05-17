import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class LoginViewModel extends BaseViewModel {
  final email = TextEditingController();
  final password = TextEditingController();
  AuthService _authService = locator<AuthService>();

  void login(BuildContext context) async {
    if(email.text.isEmpty || password.text.isEmpty){
      Fluttertoast.showToast(msg: 'Tüm alanları doldurunuz');
      return;
    }
    context.loaderOverlay.show();
    var data = {
      'email' : email.text,
      'password' : password.text
    };
    print(data);
    var response = await _authService.login(data);
    if(response is LoginModel){
      locator<HiveService>().hive.put(Constants.authToken, response.accessToken);
      context.navigationService.navigateTo(Routes.bottomNavView);
    }
    context.loaderOverlay.hide();
  }
}
