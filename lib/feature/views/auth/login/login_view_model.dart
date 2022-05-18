import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class LoginViewModel extends BaseViewModel {
  AuthService _authService = locator<AuthService>();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController(text: 'bilaltest2');
  final password = TextEditingController(text: 'Bilal123');

  void login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
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
      _authService.saveToken(response.accessToken);
      context.navigationService.pushNamedAndRemoveUntil(Routes.bottomNavView);
    }
    context.loaderOverlay.hide();
  }
}
