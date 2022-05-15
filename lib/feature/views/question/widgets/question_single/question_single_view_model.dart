import 'package:stacked/stacked.dart';

class QuestionSingleViewModel extends BaseViewModel {



  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// isteği buraya gönder
    // final bool success= await sendRequest();

    /// başarısız olursa, hiçbir şey yapama
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}