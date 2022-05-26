import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class ActivityService {
  final NetworkManager? _networkManager = GeneralManager.networkM;

  Future activityGetAll({Map queryParameters = const {}}) async =>
      await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.activity,
        model: ActivityModel(),
      );

  Future activityPost(dynamic data) async => await _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.activity,
        model: ActivityModel(),
        data: data,
        isFile: true,
      );
}
