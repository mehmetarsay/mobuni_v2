import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/widgets/text/custom_title.dart';

class RegisterView extends StatefulWidget {
const RegisterView({ Key? key }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
var isHighSchool = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
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
          CustomTextFormField(controller: TextEditingController(), hintText: 'Name',),
          CustomTextFormField(controller: TextEditingController(), hintText: 'Surname',),
          CustomTextFormField(controller: TextEditingController(), hintText: 'Username',),
          CustomTextFormField(controller: TextEditingController(), hintText: 'Email Address',),
          CustomTextFormField(controller: TextEditingController(), hintText: 'Password',),
          CustomTextFormField(controller: TextEditingController(), hintText: 'Password again',),
          Visibility(
            visible: !isHighSchool,
            child: Column(
              children: [
                CustomDropdown(labelText: 'University', items: ['Imü', 'Ytü']),
                CustomDropdown(labelText: 'Department', items: ['Imü', 'Ytü']),
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
            value: isHighSchool,
            onChanged: (value){
              setState(() {
                isHighSchool = value!;
              });
            }, 
          contentPadding: EdgeInsets.symmetric(horizontal: 35),),
          SizedBox(height: 20),
          CustomButton(text: 'Register'),
        ],
      ),
    );
  }
}