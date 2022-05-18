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
                      CustomTitle(title: 'Register'),
                    ],
                  ),
                ),
              ),
              CustomTextFormField(
                controller: vm.name,
                hintText: 'Name',
                validator: Validators.notEmpty,
              ),
              CustomTextFormField(
                controller: vm.surname,
                hintText: 'Surname',
                validator: Validators.notEmpty,
              ),
              CustomTextFormField(
                controller: vm.userName,
                hintText: 'Username',
                validator: Validators.notEmpty,
              ),
              CustomTextFormField(
                controller: vm.email,
                hintText: 'Email Address',
                validator: Validators.emailValidator,
                textInputType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                controller: vm.password,
                hintText: 'Password',
                validator: Validators.notEmpty,
                isPassword: true,
              ),
              CustomTextFormField(
                controller: vm.passwordAgain,
                hintText: 'Password again',
                validator: Validators.notEmpty,
                isPassword: true,
              ),
              Visibility(
                visible: !vm.isHighSchool,
                child: Column(
                  children: [
                    CustomDropdown(
                      labelText: 'University',
                      items: vm.universityList,
                      isLoading: vm.isLoading,
                      voidCallback: (value) => vm.universityId = value as int,
                    ),
                    CustomDropdown(
                      labelText: 'Department',
                      items: vm.departmentList,
                      isLoading: vm.isLoading,
                      voidCallback: (value) => vm.departmentId = value as int,
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                title: CustomText(
                  'I am high school student',
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                activeColor: Color(0xff204F83),
                value: vm.isHighSchool,
                onChanged: (value) => vm.isHighSchool = value!,
                contentPadding: EdgeInsets.symmetric(horizontal: 35),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Register',
                onPressed: () => vm.register(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
