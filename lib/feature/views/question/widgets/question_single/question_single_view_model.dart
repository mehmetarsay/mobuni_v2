import 'package:mobuni_v2/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionSingleViewModel extends BaseViewModel {


  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// isteği buraya gönder
    // final bool success= await sendRequest();

    /// başarısız olursa, hiçbir şey yapama
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}