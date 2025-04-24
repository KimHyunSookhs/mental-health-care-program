import 'dart:convert';
import 'dart:io';

import 'package:mental_health_care/core/platform/json_storage.dart';
import 'package:mental_health_care/core/platform/json_storage_key.dart';
import 'package:path_provider/path_provider.dart';

class JsonStorageImpl implements JsonStorage {
  static Future<File> _getFile(JsonStorageKey key) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/${key.fileName}');
  }

  static Future<Map<String, dynamic>?> load(JsonStorageKey key) async {
    final file = await _getFile(key);
    if (!await file.exists()) return null;

    final jsonString = await file.readAsString();
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
}
