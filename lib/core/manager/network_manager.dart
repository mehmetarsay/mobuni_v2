import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/base/models/base_response/empty_response.dart';
import 'package:mobuni_v2/core/constants/app/api_constants.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';
import 'package:mobuni_v2/core/constants/app/private_constants.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:stacked/stacked_annotations.dart';

import '/core/base/models/base_model/base_model.dart';
import '/core/base/models/base_response/base_response.dart';
import '/core/constants/enum/req_types.dart';
import 'package:dio/dio.dart';

@LazySingleton()
class NetworkManager {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      contentType: 'application/json',
      headers: {
        'Authorization':
            'Bearer ${locator<HiveManager>().hive.get(Constants.authToken)}',
        "Accept": "application/json",
        "Access-Control-Allow-Origin" : "*",
        "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
  "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
      },
    ),
  );

  final Dio dioOneSignal = Dio(
    BaseOptions(
      baseUrl: PrivateConstants.onesignalUrl,
      headers: {
        'Authorization': 'Basic ${PrivateConstants.onesignalRestApiKey}'
      },
    ),
  );

  void setHeaderToken(String authToken) {
    dio.options.headers = {
      'Authorization': 'Bearer $authToken',
      "Accept": "application/json",
    };
  }

  Future<bool> pushNotification(Map<String, dynamic> data) async {
    // print(jsonEncode(data));
    var response = await dioOneSignal.post('', data: data);
    try {
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e);
      return false;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future request<T extends BaseModel>(
      {required ReqTypes method,
      required String path,
      dynamic data,
      required T model,
      Map<String, dynamic>? queryParameters,
      bool isBaseResponse = true,
      isFile = false}) async {
    var time = DateTime.now();
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

      if (kDebugMode) {
        print(
            '$path -> ${(DateTime.now().difference(time)).inMilliseconds} ms');
      }
      if (response.statusCode == 200) {
        if (isBaseResponse) {
          return _baseResponseConverter(response.data, model: model);
        } else {
          return model.fromJson(response.data);
        }
      } else {
        return _showError(
          '$path ${method.name}',
          'Status Code: ${response.statusCode} | Status Message: ${response.statusMessage}',
          response.data,
          time,
        );
      }
    } on DioError catch (dioError) {
      print('asd');
      return _showError(
        '$path ${method.name}',
        'Error: ${dioError.error} | Status Message: ${dioError.message}',
        dioError.response!.data,
        time,
      );
    } catch (error) {
      return _showError(
        '$path ${method.name}',
        error,
        null,
        time,
      );
    }
  }

  void _showError(
    String errorPoint,
    dynamic error,
    dynamic responseData,
    DateTime time,
  ) {
    String? message;
    if (responseData != null) {
      if (responseData == '') {
        message =
            'Sunucu ile ilgili bir hata oluştu. Lütfen daha sonra tekrar deneyiniz';
      } else {
        message = responseData!['message'];
      }
    }
    log('$errorPoint FAILED | Status Code: $error');
    print(
        '$errorPoint -> ${(DateTime.now().difference(time)).inMilliseconds} ms');
    if (message != null) Fluttertoast.showToast(msg: message);
    return null;
  }

  dynamic _baseResponseConverter<T extends BaseModel>(dynamic data,
      {T? model}) {
    final baseResponse = BaseResponse.fromJson(data);
    if (baseResponse.success!) {
      if (baseResponse.data != null) {
        if (model is EmptyModel) {
          return baseResponse.data;
        }
        if (baseResponse.data is List) {
          var list = <T>[];
          (baseResponse.data as List)
              .forEach((element) => list.add(model!.fromJson(element)));
          return list;
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
}
