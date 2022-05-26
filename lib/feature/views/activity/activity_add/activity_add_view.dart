import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/button/custom_button.dart';
import 'package:mobuni_v2/core/components/select_time/select_time_widget.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/app/validators.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/activity/activity_add/activity_add_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/components/text_form_field/custom_text_form_field.dart';

class ActivityAddView extends StatelessWidget {
  const ActivityAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActivityAddViewModel>.reactive(
      viewModelBuilder: () => ActivityAddViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, vm, child) => WillPopScope(
        onWillPop: () async{
           AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Yaptığınız değişiklikler silinecek emin misiniz?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),),
            btnOkOnPress: () {
             context.navigationService.back();

            },
            btnOkColor: context.theme.primaryColor,
            btnCancelOnPress: (){
              return false;
            },
            btnOkText: 'Evet',
            btnCancelText: 'Geri',

          )..show();
           return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Etkinlik ekle'),
          ),
          body: SafeArea(
            child: Form(
              key: vm.formKey,
              child: SingleChildScrollView(
                physics:  BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: vm.title,
                      hintText: 'Başlık',
                      title: 'Başlık*',
                      validator: Validators.notEmpty,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: vm.content,
                      hintText: 'Açıklama',
                      title: 'Açıklama*',
                      maxLines: 5,
                      validator: Validators.notEmpty,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomText('Fotoğraf',style: TextStyle(
                                  color: context.theme.secondaryHeaderColor,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => vm.getImage(context),
                            child: Container(
                              width: double.infinity,
                              height: context.height / 3.5,
                              margin: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                  color: context.theme.primaryColorLight,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: context.theme.primaryColorDark),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: vm.imageFile == null ? Image.asset('assets/empty_photo.png').image : 
                                      Image.file(File(vm.imageFile!.path)).image)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectTime(
                      initialValue: vm.startTime.toString(),
                      onChange: (val) {
                        vm.startTime = DateTime.parse(val);
                      },
                      title: 'Başlangıç Tarihi*',
                    ),
                    SelectTime(
                      initialValue: vm.endTime.toString(),
                      onChange: (val) {
                        vm.endTime = DateTime.parse(val);
                      },
                      title: 'Bitiş Tarihi*',
                      selectableDayPredicate: (DateTime date) {
                        if (date.isBefore(vm.startTime.subtract(Duration(days: 1)))) {
                          return false;
                        }
                        return true;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: vm.maxUser,
                      hintText: '0',
                      title: 'Kişi sayısı',
                      maxLines: 1,
                      validator: Validators.notEmpty,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      controller: vm.ticketPrice,
                      hintText: '0 ₺',
                      title: 'Bilet Fiyatı(₺)',
                      maxLines: 1,
                      validator: Validators.notEmpty,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              CustomText('Kategoriler*',style: TextStyle(
                                  color: context.theme.secondaryHeaderColor,
                                  fontWeight: FontWeight.w700
                              ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        GridView.builder(
                          shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 100,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                            itemCount: vm.categories.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: (){
                                  vm.categories[index].isSelected = !vm.categories[index].isSelected;
                                  vm.notifyListeners();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: CustomText(vm.categories[index].name!,style: TextStyle(
                                    color: vm.categories[index].isSelected?context.theme.primaryColorLight:context.theme.primaryColorDark,
                                  ),),
                                  decoration: BoxDecoration(
                                      color: vm.categories[index].isSelected?context.theme.primaryColorDark:context.theme.primaryColorLight,
                                      border: Border.all(color: vm.categories[index].isSelected?context.theme.primaryColorLight:context.theme.primaryColorDark,),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            }),
                      ],
                    ),
                    CheckboxListTile(
                      title: CustomText(
                        'Dışardan katılımcı alabilir',
                        color: context.colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      activeColor: Color(0xff204F83),
                      value: vm.isExternal,
                      onChanged: (value) => vm.isExternal = value!,
                      contentPadding: EdgeInsets.symmetric(horizontal: 35),
                    ),
                    SizedBox(height: 20,),
                    CustomButton(
                      text: 'Kaydet',
                      onPressed: () => vm.save(context),
                    ),
                    SizedBox(height: 50,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
