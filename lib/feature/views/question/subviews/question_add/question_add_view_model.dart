import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:loader_overlay/loader_overlay.dart';

class QuestionAddViewModel extends BaseViewModel {
  TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late List<AssetEntity> images;

  File? _image;

  File? get selectImage => _image;

  set selectImage(File? value) {
    _image = value;
    notifyListeners();
  }

  void asd(File? file) async {}

  bool _imagesInit = false;

  bool get imagesInit => _imagesInit;

  set imagesInit(bool value) {
    _imagesInit = value;
    notifyListeners();
  }

  init() async {
    await imagesLoad();
  }

  Future imagesLoad() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      imagesInit = false;
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
      try {
        images = await paths.first.getAssetListPaged(page: 0, size: 80);
        imagesInit = true;
      } catch (e) {
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

  Future imageCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) selectImage = File(photo.path);
  }

  shareQuestion(BuildContext context) async {
    if(controller.text.isEmpty){
      Fluttertoast.showToast(msg: 'Soru boş olamaz');
      return;
    }
    context.loaderOverlay.show();
    var data = FormData.fromMap({
      if (selectImage != null)
        'Image': await MultipartFile.fromFile(selectImage!.path),
      'Text': '\"${controller.text}\"',
      'UniversityId': 1,
    });
    var response = await locator<QuestionService>().questionPost(data);
    if (response is QuestionModel) {
      context.navigationService.back();
    }
    context.loaderOverlay.hide();
  }
}
