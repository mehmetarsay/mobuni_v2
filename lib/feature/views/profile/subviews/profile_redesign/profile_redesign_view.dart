
import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/constants/app/validators.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/profile/subviews/photo_change/photo_change_view.dart';
import 'package:mobuni_v2/feature/widgets/text/custom_title.dart';
import 'package:mobuni_v2/feature/widgets/user/user_photo.dart';
import 'package:stacked/stacked.dart';

import 'profile_redesign_view_model.dart';

class ProfileRedesignView extends StatelessWidget {
  const ProfileRedesignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileRedesignViewModel>.reactive(
      viewModelBuilder: () => ProfileRedesignViewModel(),
      builder: builder,
      onModelReady: (vm) => vm.initialize(context),
    );
  }

  Widget builder(BuildContext context, ProfileRedesignViewModel vm, Widget? child) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profil Düzenle',),
      body: Form(
        key: vm.formKey,
        child: Container(
          height: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.navigationService.navigateToView(PhotoChangeView(imageUrl:GeneralManager.user.image!));
                        },
                        child: Stack(
                          children: [
                            UserPhoto(size: context.height/6,),
                            Positioned(
                              right: 0,
                              left: 100,
                              bottom: 0,
                              child: Material(
                                color: context.theme.primaryColorDark,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: context.theme.primaryColorLight,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
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
                  Visibility(
                    visible: GeneralManager.user.userType==1,
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

                ],
              ),

              Column(
                children: [
                  CustomButton(
                    text: 'Kaydet',
                    onPressed: () => vm.save(context),
                  ),
                  SizedBox(height: 20,)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
