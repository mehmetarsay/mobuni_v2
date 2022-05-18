import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/network/network_manager.dart';
import 'package:mobuni_v2/feature/models/department/department_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class AuthService {
  final NetworkManager? _networkManager = locator<NetworkManager>();
  final HiveService? _hiveService = locator<HiveService>();

  void saveToken(String? token) {
    _hiveService!.hive.put(Constants.authToken, token);
    _networkManager!.setHeaderToken(token!);
    // BURAYA USER BİLGİSİ DE GELEREK GEREKLİ YERE KAYIT EDİLECEK
  }

  void get deleteToken => _hiveService!.hive.delete(Constants.authToken);
    // BURAYA USER BİLGİSİNİ SİLME EKLENECEK


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
}
