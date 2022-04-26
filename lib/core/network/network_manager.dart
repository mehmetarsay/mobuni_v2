import 'dart:developer';

import '/core/base/models/base_model/base_model.dart';
import '/core/base/models/base_response/base_response.dart';
import '/core/constants/enum/req_types.dart';
import 'package:dio/dio.dart';

class NetworkManager {
  static NetworkManager? instance = NetworkManager.init();
  NetworkManager() {
    NetworkManager.init();
  }
  late final Dio dio;

  NetworkManager.init() {
    dio = Dio(BaseOptions(
      // baseUrl: ApiConstants.baseUrl,
      contentType: 'application/json',
      headers: {
        // 'Authorization': 'Bearer ${SharedPreferencesService.getToken()}',
        "Accept": "application/json",
      },
    ));
  }

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
        log('$path ${method.name} FAILED | Status Code: ${response.statusCode} | Status Message: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (dioError) {
      // return _showError(dioError);
      log('$path ${method.name} FAILED | Error: ${dioError.error} | Status Message: ${dioError.message}');
    } catch (error) {
      log('$path ${method.name} ERROR | Error : $error');
      return null;
    }
  }

  dynamic _baseResponseConverter<T extends BaseModel>(dynamic data,
      {T? model}) {
    final baseResponse = BaseResponse.fromJson(data);
    if (baseResponse.status!) {
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
