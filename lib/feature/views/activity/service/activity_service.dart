import 'package:mobuni_v2/core/base/models/pagination_model/pagination_model.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class ActivityService {
  final NetworkManager? _networkManager = GeneralManager.networkM;

  Future activityGetAll({required int pageIndex,Map queryParameters = const {}}) async =>
      await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.activity,
        model: PaginationModel<ActivityModel>(),
        queryParameters: {
          'PageIndex' : pageIndex,
          'PageSize' : Constants.pageSize,
        }
      );

  Future activityPost(dynamic data) async => await _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.activity,
        model: ActivityModel(),
        data: data,
        isFile: true,
      );
}
