import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/button/custom_text_button.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText('LOGIN'),
              CustomTextFormField(controller: TextEditingController()),
              CustomTextFormField(controller: TextEditingController()),
              Align(alignment: Alignment.centerRight,child: CustomTextButton(child: CustomText('Şifremi Unuttum'))),
              CustomButton(text: 'Giriş Yap'),
              CustomTextButton(child: CustomText('Kayıt Ol'))
            ],
          ),
        ),
      ),
    );
  }
}
