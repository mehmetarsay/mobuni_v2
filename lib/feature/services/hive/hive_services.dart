
import 'dart:typed_data';

import 'package:stacked/stacked_annotations.dart';
import 'package:hive/hive.dart';

@LazySingleton()
class HiveService{
  late Box _hive;

  Box get hive => _hive;

  set hive(Box value) {
    _hive = value;
  }

  Future<void> init(Uint8List encryptionKey) async {
    _hive = await Hive.openBox('hive', encryptionCipher: HiveAesCipher(encryptionKey));
  }
}