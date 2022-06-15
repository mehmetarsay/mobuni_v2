import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/models/activity_category/activity_category_model.dart';
import 'package:mobuni_v2/feature/models/department/department_model.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/models/user/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class HiveManager {
  late Box _hive;

  Box get hive => _hive;

  set hive(Box value) {
    _hive = value;
  }

  Future<void> init({Uint8List? encryptionKey}) async {
    // WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory =
        kIsWeb ? null : await getApplicationDocumentsDirectory();
    if (appDocumentDirectory != null) {
      Hive.init(appDocumentDirectory.path);
    } else {
      Hive.initFlutter();
    }

    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UniversityModelAdapter());
    Hive.registerAdapter(DeaprtmentModelAdapter());
    Hive.registerAdapter(ActivityCategoryModelAdapter());
    Hive.registerAdapter(ActivityModelAdapter());
    Hive.registerAdapter(QuestionModelAdapter());
    Hive.registerAdapter(DateTimeAdapter());
    if (encryptionKey != null) {
      _hive = await Hive.openBox('hive',
          encryptionCipher: HiveAesCipher(encryptionKey));
    } else {
      _hive = await Hive.openBox('hive');
    }
  }
}

class DateTimeAdapter extends TypeAdapter<DateTime> {
  @override
  final typeId = 16;

  @override
  DateTime read(BinaryReader reader) {
    final micros = reader.readInt();
    return DateTime.fromMicrosecondsSinceEpoch(micros);
  }

  @override
  void write(BinaryWriter writer, DateTime obj) {
    writer.writeInt(obj.microsecondsSinceEpoch);
  }
}

