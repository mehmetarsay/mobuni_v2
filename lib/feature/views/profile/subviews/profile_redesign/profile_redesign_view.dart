
import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text_form_field/custom_text_form_field.dart';
import 'package:mobuni_v2/core/constants/app/validators.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/profile/subviews/photo_change/photo_change_view.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
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
          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            await context.navigationService.navigateToView(PhotoChangeView(imageUrl:GeneralManager.user.image))!.then((value) {
                              vm.notifyListeners();
                            });
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
                      readOnly: true,
                    ),
                    CustomTextFormField(
                      controller: vm.email,
                      hintText: 'Email Address',
                      validator: Validators.emailValidator,
                      textInputType: TextInputType.emailAddress,
                      readOnly: true,
                    ),
                    Visibility(
                      visible: GeneralManager.user.isUniversityStudent!,
                      child: Column(
                        children: [
                          CustomDropdown(
                            labelText: 'University',
                            items: vm.universityList,
                            isLoading: vm.isLoading,
                            initId: vm.universityId,
                            voidCallback: (value) => vm.universityId = value as int,
                          ),
                          CustomDropdown(
                            labelText: 'Department',
                            items: vm.departmentList,
                            isLoading: vm.isLoading,
                            initId: vm.departmentId,
                            voidCallback: (value) => vm.departmentId = value as int,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
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
      ),
    );
  }
}
