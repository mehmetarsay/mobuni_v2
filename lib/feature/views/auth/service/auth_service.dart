import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/enum/req_types.dart';
import 'package:mobuni_v2/core/network/network_manager.dart';
import 'package:mobuni_v2/feature/views/auth/model/login_model.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class AuthService {
  final NetworkManager? _networkManager = locator<NetworkManager>();

  Future login(Map data) async => await _networkManager!.request(
        method: ReqTypes.post,
        path: ApiConstants.login,
        model: LoginModel(),
        data: data,
      );
}
