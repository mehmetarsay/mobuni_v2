import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/constants/app/validators.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/auth/register/register_view_model.dart';
import 'package:mobuni_v2/feature/widgets/text/custom_title.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: builder,
      onModelReady: (vm) => vm.initialize(context),
    );
  }

  Widget builder(BuildContext context, RegisterViewModel vm, Widget? child) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: vm.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitle(title: 'MobUni', size: 36),
                      CustomTitle(title: 'Kayıt Ol'),
                    ],
                  ),
                ),
              ),
              CustomTextFormField(
                controller: vm.name,
                hintText: 'İsim',
                validator: Validators.notEmpty,
              ),
              CustomTextFormField(
                controller: vm.surname,
                hintText: 'Soyisim',
                validator: Validators.notEmpty,
              ),
              CustomTextFormField(
                controller: vm.userName,
                hintText: 'Kullanıcı Adı',
                validator: Validators.notEmpty,
              ),
              CustomTextFormField(
                controller: vm.email,
                hintText: 'Email Adresi',
                validator: Validators.emailValidator,
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                controller: vm.password,
                hintText: 'Şifre',
                validator: Validators.notEmpty,
                isPassword: true,
              ),
              CustomTextFormField(
                controller: vm.passwordAgain,
                hintText: 'Şifre tekrar',
                validator: Validators.notEmpty,
                isPassword: true,
              ),
              CheckboxListTile(
                title: CustomText(
                  'Üniversite öğrencisiyim',
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                activeColor: Color(0xff204F83),
                value: vm.isUniversityStudent,
                onChanged: (value) => vm.isUniversityStudent = value!,
                contentPadding: EdgeInsets.symmetric(horizontal: 35),
              ),
              Visibility(
                visible: vm.isUniversityStudent,
                child: Column(
                  children: [
                    CustomDropdown(
                      labelText: 'Üniversite',
                      items: vm.universityList,
                      isLoading: vm.isLoading,
                      voidCallback: (value) => vm.universityId = value as int,
                    ),
                    CustomDropdown(
                      labelText: 'Bölüm',
                      items: vm.departmentList,
                      isLoading: vm.isLoading,
                      voidCallback: (value) => vm.departmentId = value as int,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Kayıt Ol',
                onPressed: () => vm.register(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
