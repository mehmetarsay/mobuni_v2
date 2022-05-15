import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stacked/stacked.dart';

class QuestionAddViewModel extends BaseViewModel {

  TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late List<AssetEntity>  images;

  File? _image;

  File? get selectImage => _image;

  set selectImage(File? value) {
    _image = value;
    notifyListeners();
  }


  bool _imagesInit = false;

  bool get imagesInit => _imagesInit;

  set imagesInit(bool value) {
    _imagesInit = value;
    notifyListeners();
  }

  init()async{
    await imagesLoad();
  }

 Future imagesLoad()async{
   final PermissionState _ps = await PhotoManager.requestPermissionExtend();
   if (_ps.isAuth) {
     imagesInit = false;
     final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
     try{
        images =  await paths.first.getAssetListPaged(page: 0, size: 80);
       imagesInit =true;
     }
     catch(e){
       print(e);
       imagesInit = false;
     }
     // Granted.
   } else {
     // Limited(iOS) or Rejected, use `==` for more precise judgements.
     // You can call `PhotoManager.openSetting()` to open settings for further steps.
     PhotoManager.openSetting();
   }

  }

  Future imageCamera()async{
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if(photo!=null)
    selectImage = File(photo.path);
  }
}