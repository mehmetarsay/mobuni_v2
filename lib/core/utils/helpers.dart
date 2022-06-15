import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> checkInternet() async {
  if(kIsWeb){return true;}
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