import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/models/activity_category/activity_category_model.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:stacked/stacked.dart';

class ActivityAddViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  final title = TextEditingController();
  final content = TextEditingController();
  final maxUser = TextEditingController();
  final ticketPrice = TextEditingController();

  DateTime startTime = DateTime.now();

  DateTime endTime = DateTime.now();

  bool _isExternal = false;

  bool get isExternal => _isExternal;

  set isExternal(bool value) {
    _isExternal = value;
    notifyListeners();
  }

  List<ActivityCategoryModel> categories = [];

  init() async {
    try{
      categories = GeneralManager.hiveM.hive.get(HiveBoxKey.categories.name)??[];
    }
    catch(e){
      categories = [];
    }
    if(categories.isEmpty){
      getCategory();
    }

  }

  getImage(BuildContext context) async {
    var imageSource;
    await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: context.dynamicValue(0.12),
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                imageSource = ImageSource.camera;
                context.navigationService.back();
              },
              child: Container(
                height: context.dynamicValue(0.05),
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 10),
                    CustomText('Kamera')
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                imageSource = ImageSource.gallery;
                context.navigationService.back();
              },
              child: Container(
                height: context.dynamicValue(0.05),
                child: Row(
                  children: [
                    Icon(Icons.collections),
                    SizedBox(width: 10),
                    CustomText('Galeri')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    try {
      imageFile = await _picker.pickImage(
          source: imageSource, imageQuality: Constants.imageQuality);
      print('debug');
      if (imageFile == null) {
        setInitialised(false);
      } else {
        setInitialised(true);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  save(BuildContext context) async {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Etkinlik paylaşılacak emin misiniz?',
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ),
      btnOkOnPress: () {
        shareActivity(context);
      },
      btnOkColor: context.theme.primaryColor,
      btnCancelOnPress: () {
        context.navigationService.back();
      },
      btnOkText: 'Evet',
      btnCancelText: 'Geri',
    )..show();
  }

  shareActivity(BuildContext context) async {
    try {
      if (title.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Başlık boş olamaz');
        return;
      }

      context.loaderOverlay.show();
      var data = FormData.fromMap({
        if (imageFile != null)
          'Image': await MultipartFile.fromFile(imageFile!.path),
        'Title': '\"${title.text}\"',
        'Content': '\"${content.text}\"',
        'ActivityStartTime': '\"${startTime.toString()}\"',
        'ActivityEndTime': '\"${endTime.toString()}\"',
        if (maxUser.text.isNotEmpty) 'MaxUser': int.tryParse(maxUser.text),
        if (ticketPrice.text.isNotEmpty)
          'TicketPrice': double.tryParse(ticketPrice.text),
        'IsExternal': isExternal,
        'UniversityId': GeneralManager.user.universityId,
      });
      var response = await locator<ActivityService>().activityPost(data);
      if (response is ActivityModel) {
        context.navigationService.back(result: response);
      }
    } finally {
      context.loaderOverlay.hide();
    }
  }

  getCategory()async{
    List<ActivityCategoryModel> categoryList =  await locator<ActivityService>().getAllCategory();
    categories = categoryList;
    saveCategory(categoryList);
    notifyListeners();
  }
  void saveCategory(List<ActivityCategoryModel> categories){
    locator<HiveManager>().hive.delete(HiveBoxKey.categories.name);
    locator<HiveManager>().hive.put(HiveBoxKey.categories.name, categories);
  }
}
