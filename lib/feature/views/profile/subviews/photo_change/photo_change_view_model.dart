import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/profile/service/profile_service.dart';
import 'package:stacked/stacked.dart';

class PhotoChangeViewModel extends BaseViewModel {
  ProfileService profileService = locator<ProfileService>();

  final ImagePicker _picker = ImagePicker();
   XFile? imageFile;
   late String? imageUrlVal;



  initialize(String? imageURl){
    setInitialised(false);
    this.imageUrlVal = imageURl;
     if(imageURl==null||imageURl==''){
       getImage();
     }
     setInitialised(true);
     notifyListeners();
   }
  getImage() async{
     imageFile = await _picker.pickImage(source: ImageSource.gallery);
     if((imageUrlVal==null||imageUrlVal=='')&&imageFile==null){
       setInitialised(false);
     }
     else{
       setInitialised(true);
     }
     notifyListeners();
  }
  save(BuildContext context)async{
    context.loaderOverlay.show();
    var data = FormData.fromMap({
      if (imageFile != null)
        'image':await MultipartFile.fromFile(imageFile!.path)
    });
  var a = await profileService.profilePhotoChange(data);
  if(a){
   print('fotoğrraf değişti');
   Fluttertoast.showToast(msg: 'Fotoğraf güncellendi');
   context.loaderOverlay.hide();
   context.navigationService.back();
  }
  Fluttertoast.showToast(msg: 'Hata');
  context.loaderOverlay.hide();


  }

}