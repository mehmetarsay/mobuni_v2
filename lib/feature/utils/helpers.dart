import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static Codec<String, String> stringToBase64 = utf8.fuse(base64);
}
String timeagoFormat(DateTime dateTime) =>
    timeago.format(dateTime.add(DateTime.now().timeZoneOffset));

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet Connection Available');
      return true;
    } else {
      print('No Internet Connection');
      await Fluttertoast.showToast(
          msg:
              'Akış yenilenemiyor. Lütfen İnternet Bağlantınızı Kontrol Ediniz!');
      return false;
    }
  } on SocketException catch (_) {
    print('No Internet Connection');
    await Fluttertoast.showToast(
        msg:
            'Akış yenilenemiyor. Lütfen İnternet Bağlantınızı Kontrol Ediniz!');
    return false;
  }
}

DateTime? dateTimeFromTimestamp(Timestamp? timestamp) {
  return timestamp != null ? timestamp.toDate() : null;
}

Timestamp? dateTimeToTimestamp(DateTime? dateTime) {
  return Timestamp.fromDate(dateTime!);
}

String? stringtoBase64Encode(String? comment) {
  return Helper.stringToBase64.encode(comment!);
}

String? stringtoBase64Decode(String? encodeComment) {
  try {
    return Helper.stringToBase64.decode(encodeComment!);
  } catch (e) {}
  return encodeComment;
}

dynamic isNumeric(String value) {
  try {
    if (value == '') return null;
    return double.parse(value);
  } on FormatException {
    return value;
  }
}

dynamic intParse(String value) {
  try {
    if (value == '') return null;
    return int.parse(value);
  } on FormatException {
    return value;
  }
}
