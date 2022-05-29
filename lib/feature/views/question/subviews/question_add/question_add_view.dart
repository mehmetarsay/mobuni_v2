import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/question/subviews/question_add/question_add_view_model.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stacked/stacked.dart';


class QuestionAddView extends StatelessWidget {
  const QuestionAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionAddViewModel>.reactive(
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, child) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Container(
                width: context.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(vm.controller.text.isNotEmpty||vm.selectImage!=null){
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              body: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Girmiş olduğunuz bilgiler silinecek. Çıkmak istediğinize emin misiniz?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),),
                              btnOkOnPress: () {
                                context.navigationService.back();
                              },
                              btnOkColor: context.theme.primaryColor,
                              btnCancelOnPress: (){
                              },
                              btnOkText: 'Evet',
                              btnCancelText: 'Geri',

                            )..show();
                          }
                          else{
                            context.navigationService.back();
                          }
                        },
                        child: Text(
                          'İptal Et',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      InkWell(
                        onTap: () => vm.shareQuestion(context),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Theme.of(context).primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              'Soru Sor',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                height: context.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      GeneralManager.user.isUniversityStudent! ?  Center(
                        child: CustomText(
                          '${GeneralManager.user.university!.name} Sor',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ) : CustomDropdown(
                        initId: vm.universityId,
                        labelText: 'University',
                        items: vm.universityList,
                        isLoading: vm.isLoading,
                        voidCallback: (value) {
                          vm.universityId = value as int;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UserPhoto(size: 50,),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: vm.controller,
                                      maxLines: vm.selectImage!=null?5 :10,
                                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Soru Sor'),
                                      autofocus: true,
                                    ),
                                    if(vm.selectImage!=null)selectPhoto(context,vm),
                                    SizedBox(height: 100,)
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (vm.imagesInit)
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: context.height / 10,
                    width: context.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: vm.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(index==0){
                          return Row(
                            children: [
                              Container(
                                  height: context.height / 10,
                                  width: context.width / 3.2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () async{
                                          vm.imageCamera();
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.grey,
                                            child: Icon(
                                                Icons.camera_alt,
                                              color: Theme.of(context).primaryColorLight,
                                            ),
                                          ),
                                        ),
                                      ))),
                          photoView(vm.images.elementAt(index), context, vm),
                            ],
                          );
                        }
                        return photoView(vm.images.elementAt(index), context, vm);
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => QuestionAddViewModel(),
    );
  }

  photoView(AssetEntity entity, BuildContext context, QuestionAddViewModel vm) {
    return Container(
        height: context.height / 10,
        width: context.width / 3.2,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async{
               vm.selectImage = await entity.file;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AssetEntityImage(
                  entity,
                  isOriginal: false,
                  fit: BoxFit.cover,
                ),
              ),
            )));
  }

  selectPhoto(BuildContext context, QuestionAddViewModel vm) {
    return Stack(
      children: [
        Container(
            height: context.height / 3,
            width: context.width ,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                vm.selectImage!,
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
              onTap: (){
                vm.selectImage =null;
              },
              child: Icon(Icons.cancel,color: Colors.white,)),
        )
      ],
    );
  }
}
