import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/base/models/base_response/empty_response.dart';
import 'package:mobuni_v2/core/base/models/pagination_model/pagination_model.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class QuestionService {
  List<QuestionModel>? questions = [];

  final NetworkManager? _networkManager = locator<NetworkManager>();

  Future questionGetByUniversityId(
          {required int universityId, required int pageIndex}) async =>
      await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.questionGetByUniversityId,
        model: PaginationModel<QuestionModel>(),
        queryParameters: {
          'universityId': universityId,
          'PageIndex': pageIndex,
          'PageSize': Constants.pageSize
        },
      );
  //  Fluttertoast.showToast(msg: 'Sorular güncel');

  Future questionPost(dynamic data) => _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.question,
        model: QuestionModel(),
        data: data,
        isFile: true,
      );

  getQuestionSize({required int universityId,required DateTime dateTime}) async {
    return await _networkManager!.request(
      method: ReqTypes.get,
      path: ApiConstants.questionCountsByUniversityId,
      model: EmptyModel(),
      queryParameters: {'universityId': universityId,'dateTime':dateTime},
    );
  }

  setQuestionLike({required int questionId}) async {
    return await _networkManager!.request(
      method: ReqTypes.put,
      path: ApiConstants.likeQuestion,
      model: EmptyModel(),
      queryParameters: {'questionId': questionId},
    );
  }
}
