import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/button/custom_text_button.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/constants/app/validators.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/auth/login/login_view_model.dart';
import 'package:mobuni_v2/feature/views/auth/register/register_view.dart';
import 'package:mobuni_v2/feature/widgets/text/custom_title.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(), builder: builder);
  }

  Widget builder(BuildContext context, LoginViewModel vm, Widget? child) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SizedBox(
        width: context.width,
        child: Form(
          key: vm.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitle(title: 'MobUni', size: 36),
                      CustomTitle(title: 'Welcome'),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  CustomTextFormField(
                    controller: vm.email,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validator: Validators.notEmpty,
                  ),
                  CustomTextFormField(
                    controller: vm.password,
                    hintText: 'Password',
                    isPassword: true,
                    validator: Validators.notEmpty,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Sign In',
                    onPressed: () => vm.login(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(text: 'Forgot Your Password?'),
                        CustomTextButton(
                          text: 'Sign Up',
                          onPressed: () => context.navigationService
                              .navigateToView(RegisterView()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
