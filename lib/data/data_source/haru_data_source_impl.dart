import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:mental_health_care/core/platform/json_storage.dart';
import 'package:mental_health_care/core/platform/json_storage_key.dart';
import 'package:mental_health_care/data/data_source/haru_data_source.dart';
import 'package:mental_health_care/data/dto/haru_dto.dart';

class HaruDataSourceImpl implements HaruDataSource {
  static const String path = 'assets/json/haru.json';

  @override
  Future<List<HaruDto>> getHaruList() async {
    try {
      final loaded = await JsonStorage.load(JsonStorageKey.haru);
      final json = loaded ?? await _loadFromAssets();
      if (json == null || json['haru'] is! List) {
        throw Exception('recipes.json 형식 오류 또는 데이터 없음');
      }
      final list = json['haru'] as List;
      return list
          .map((e) => HaruDto.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      throw Exception('recipes.json 로드 실패 $e');
    }
  }

  Future<Map<String, dynamic>?> _loadFromAssets() async {
    final assetStr = await rootBundle.loadString(path);
    final decoded = jsonDecode(assetStr);
    if (decoded is Map<String, dynamic>) {
      return decoded; // 저장하지 않고 바로 반환만 함
    }
    return null;
  }
}
