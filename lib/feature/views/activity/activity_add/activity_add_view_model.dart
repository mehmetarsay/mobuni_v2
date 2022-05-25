import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/activity_category/activity_category_model.dart';
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


  init()async{
    categories = GeneralManager.hiveM.hive.get('category');
  }

  getImage() async{
    imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if(imageFile==null){
      setInitialised(false);
    }
    else{
      setInitialised(true);
    }
    notifyListeners();
  }

  save(BuildContext context)async{
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
        ),),
      btnOkOnPress: () {


      },
      btnOkColor: context.theme.primaryColor,
      btnCancelOnPress: (){
      },
      btnOkText: 'Evet',
      btnCancelText: 'Geri',

    )..show();
  }

}