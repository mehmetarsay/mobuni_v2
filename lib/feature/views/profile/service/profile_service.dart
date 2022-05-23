
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/base/models/base_response/base_response.dart';
import 'package:mobuni_v2/core/base/models/base_response/empty_response.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class ProfileService {
  final NetworkManager? _networkManager = locator<NetworkManager>();
  final HiveManager? _hiveService = locator<HiveManager>();

  Future profilePhotoChange(dynamic data) => _networkManager!.request(
    method: ReqTypes.post,
    path: ApiConstants.uploadProfileImage,
    model: EmptyModel(),
    data: data,
    isFile: true,
  );

  Future profileUpdate(dynamic data) async => await _networkManager!.request(
    method: ReqTypes.put,
    path: ApiConstants.user,
    model: UserModel(),
    data: data,
  );

  Future<UserModel> getUserProfile(String userId) async => await _networkManager!.request(
    method: ReqTypes.get,
    path: ApiConstants.getByUserId,
    model: UserModel(),
    queryParameters: {
      'userId':userId
    }
  );

  Future questionGetByUserId({required String userId}) async {
    return  await _networkManager!.request(
      method: ReqTypes.get,
      path: '${ApiConstants.getQuestionsByUserId}/${userId}',
      model: QuestionModel(),
    );

  }
}