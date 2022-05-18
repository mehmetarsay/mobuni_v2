import 'package:flutter/cupertino.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/network/network_manager.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class QuestionService {

  List<QuestionModel>? questions = [];
  ScrollController scrollController = ScrollController();

  final NetworkManager? _networkManager = locator<NetworkManager>();

  Future questionGetByUniversityId({required int universityId}) async {
   questions =  await _networkManager!.request(
      method: ReqTypes.get,
      path: ApiConstants.questionGetByUniversityId,
      queryParameters:{
        'universityId':universityId
      } ,
      model: QuestionModel(),
    );
  }

}