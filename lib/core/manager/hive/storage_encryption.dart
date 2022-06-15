import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class StorageEncryption {
  Future<Uint8List?> getEncryptionKey() async {
    try {
      final secureStorage = const FlutterSecureStorage();
      var containsEncryptionKey = await secureStorage.containsKey(key: 'key1');
      if (!containsEncryptionKey) {
        var key = Hive.generateSecureKey();
        await secureStorage.write(key: 'key1', value: base64UrlEncode(key));
      }
      var a = await secureStorage.read(key: 'key1');
      return base64Url.decode(a!);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
