import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/core/manager/network_manager.dart';
import 'package:mobuni_v2/feature/models/department/department_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class AuthService {
  final NetworkManager? _networkManager = locator<NetworkManager>();
  final HiveManager? _hiveService = locator<HiveManager>();

  void saveToken(String? token, UserModel user) {
    _hiveService!.hive.put(Constants.authToken, token);
    _networkManager!.setHeaderToken(token!);
    _hiveService!.hive.put(Constants.user, user);
    UserModel userq = _hiveService!.hive.get(Constants.user);
    print(userq);
  }

  void get deleteToken {
    _hiveService!.hive.delete(Constants.authToken);
    _networkManager!.setHeaderToken('');
    _hiveService!.hive.delete(Constants.user);
  }

  bool get isLogin => _hiveService!.hive.containsKey(Constants.authToken);

  Future login(Map data) async => await _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.login,
        model: LoginModel(),
        data: data,
      );

  Future register(dynamic data) async => await _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.register,
        model: LoginModel(),
        data: data,
      );

  Future getAllUniversity() async => await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.universityAll,
        model: UniversityModel(),
      );
  Future getAllDepartment() async => await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.departmentAll,
        model: DeaprtmentModel(),
      );
  Future getAllUser() async => await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.userAll,
        model: UserModel(),
      );
  Future getUserById(String id) async => await _networkManager!.request(
        method: ReqTypes.get,
        path: ApiConstants.userById,
        model: UserModel(),
        queryParameters: {'UserId' : id}
      );
}
