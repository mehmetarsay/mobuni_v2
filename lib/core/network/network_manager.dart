import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/feature/services/hive/hive_services.dart';
import 'package:stacked/stacked_annotations.dart';

import '/core/base/models/base_model/base_model.dart';
import '/core/base/models/base_response/base_response.dart';
import '/core/constants/enum/req_types.dart';
import 'package:dio/dio.dart';

@LazySingleton()
class NetworkManager {
  // NetworkManager() {
  //   NetworkManager.init();
  // }

  final Dio dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    contentType: 'application/json',
    headers: {
      'Authorization':
          'Bearer ${locator<HiveService>().hive.get(Constants.authToken)}',
      "Accept": "application/json",
    },
  ));

  // NetworkManager.init() {
  //   dio = Dio(BaseOptions(
  //     baseUrl: ApiConstants.baseUrl,
  //     contentType: 'application/json',
  //     headers: {
  //       // 'Authorization': 'Bearer ${SharedPreferencesService.getToken()}',
  //       "Accept": "application/json",
  //     },
  //   ));
  // }

  Future request<T extends BaseModel>(
      {required ReqTypes method,
      required String path,
      dynamic data,
      required T model,
      Map<String, dynamic>? queryParameters,
      bool isBaseResponse = true,
      isFile = false}) async {
    data ??= {};
    try {
      var body = data is Map || data is FormData ? data : data.toJson();

      var response = await dio.request(path,
          data: body,
          queryParameters: queryParameters,
          options: Options(
            contentType: isFile ? "multipart/form-data" : "application/json",
            method: method.name,
          ));
      // print(response.realUri.toString());
      if (response.statusCode == 200) {
        if (isBaseResponse) {
          return _baseResponseConverter(response.data, model: model);
        } else {
          return model.fromJson(response.data);
        }
      } else {
        return _showError('$path ${method.name}', 'Status Code: ${response.statusCode} | Status Message: ${response.statusMessage}', response.data['message']);
        // log('$path ${method.name} FAILED | Status Code: ${response.statusCode} | Status Message: ${response.statusMessage}');
        // return null;
      }
    } on DioError catch (dioError) {
      return _showError('$path ${method.name}', 'Error: ${dioError.error} | Status Message: ${dioError.message}', dioError.response!.data['message']);
      // return _showError(dioError);
      // log('$path ${method.name} FAILED | Error: ${dioError.error} | Status Message: ${dioError.message}');
    } catch (error) {
      return _showError('$path ${method.name}', error, null);
      // log('$path ${method.name} ERROR | Error : $error');
      // return null;
    }
  }

  void _showError(String errorPoint, dynamic error, String? responseMessage) {
    log('$errorPoint FAILED | Status Code: $error');
    if (responseMessage != null) Fluttertoast.showToast(msg: responseMessage);
    return null;
  }

  dynamic _baseResponseConverter<T extends BaseModel>(dynamic data,
      {T? model}) {
    final baseResponse = BaseResponse.fromJson(data);
    if (baseResponse.success!) {
      if (baseResponse.data != null) {
        if (baseResponse.data is List) {
          var list = <T>[];
          (baseResponse.data as List)
              .forEach((element) => list.add(model!.fromJson(element)));
          return list.isNotEmpty ? list : model;
        } else {
          return model!.fromJson(baseResponse.data as Map<String, dynamic>);
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // ErrorMessage _showError(DioError dioError) {
  //   Object errorModel;
  //   dynamic data = dioError.response!.data;
  //   switch (dioError.response!.statusCode) {
  //     case 400:
  //       errorModel = BadRequestErrorModel.fromJson(data);
  //       break;
  //     case 401:
  //       errorModel = UnauthorizedErrorModel.fromJson(data);
  //       break;
  //     case 403:
  //       errorModel = UnauthorizedErrorModel.fromJson(data); //Forbidden
  //       break;
  //     case 405:
  //       errorModel = UnauthorizedErrorModel.fromJson(data); //Wrong Method
  //       break;
  //     case 419:
  //       errorModel = CustomErrorModel.fromJson(data);
  //       break;
  //     case 422:
  //       errorModel = ValidationErrorModel.fromJson(data);
  //       break;
  //     case 500:
  //       errorModel = ServerErrorModel.fromJson(data);
  //       break;
  //     default:
  //       errorModel = CustomErrorModel.fromJson(data);
  //   }
  //   return ErrorMessage(
  //     errorModel: errorModel,
  //     statusCode: dioError.response!.statusCode,
  //   );
  // }

}
