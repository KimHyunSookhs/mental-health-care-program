import 'package:mental_health_care/core/platform/json_storage_impl.dart';
import 'package:mental_health_care/core/platform/json_storage_key.dart';

abstract class JsonStorage {
  static Future<Map<String, dynamic>?> load(JsonStorageKey key) =>
      JsonStorageImpl.load(key);
}
