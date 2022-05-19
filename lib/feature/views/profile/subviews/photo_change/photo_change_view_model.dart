import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class PhotoChangeViewModel extends BaseViewModel {
  final ImagePicker _picker = ImagePicker();
   XFile? imageFile;

  getImage()async{
     imageFile = await _picker.pickImage(source: ImageSource.gallery);
     notifyListeners();
  }
}