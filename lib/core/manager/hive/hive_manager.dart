
import 'dart:typed_data';

import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:hive/hive.dart';

@LazySingleton()
class HiveManager{
  late Box _hive;

  Box get hive => _hive;

  set hive(Box value) {
    _hive = value;
  }

  Future<void> init(Uint8List encryptionKey) async {
    // WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserModelAdapter()); 
    _hive = await Hive.openBox('hive', encryptionCipher: HiveAesCipher(encryptionKey));
  }
}