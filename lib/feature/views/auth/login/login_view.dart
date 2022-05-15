import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/button/custom_text_button.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/auth/register/register_view.dart';
import 'package:mobuni_v2/feature/widgets/text/custom_title.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SizedBox(
        width: context.width,
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
                  controller: TextEditingController(),
                  hintText: 'Email',
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Password',
                ),
                SizedBox(height: 20),
                CustomButton(
                    text: 'Sign In',
                    onPressed: () => context.navigationService
                        .pushNamedAndRemoveUntil(Routes.bottomNavView)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextButton(text: 'Forgot Your Password?'),
                      CustomTextButton(
                        text: 'Sign Up',
                        onPressed: () =>
                            context.navigationService.navigateToView(
                          RegisterView(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
