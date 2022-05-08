import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class StorageEncryption {


   Future<Uint8List> getEncryptionKey() async {
     final secureStorage = const FlutterSecureStorage();
     var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
     if (!containsEncryptionKey) {
       var key = Hive.generateSecureKey();
       await secureStorage.write(key: 'key', value: base64UrlEncode(key));
     }
     var a  = await secureStorage.read(key: 'key');
     return  base64Url.decode(a!);

  }

   String _randomValue() {
    final rand = Random();
    final codeUnits = List.generate(20, (index) {
      return rand.nextInt(26) + 65;
    });

    return String.fromCharCodes(codeUnits);
  }

}