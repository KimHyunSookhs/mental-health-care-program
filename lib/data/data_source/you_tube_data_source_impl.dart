import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mental_health_care/data/model/you_tube.dart';

import '../../core/platform/json_storage.dart';
import '../../core/platform/json_storage_key.dart';
import 'you_tube_data_source.dart';

class YouTubeDataSourceImpl implements YouTubeDataSource {
  static const String path = 'assets/json/youtube.json';

  @override
  Future<List<YouTube>> getYouTube() async {
    try {
      final loaded = await JsonStorage.load(JsonStorageKey.youtube);
      final json = loaded ?? await _loadFromAssets();
      if (json == null || json['youtube'] is! List) {
        throw Exception('youtube.json 형식 오류 또는 데이터 없음');
      }
      final list = json['youtube'] as List;
      List<YouTube> youtubeList = list.map((e) => YouTube.fromJson(e)).toList();
      return youtubeList;
    } catch (e) {
      throw Exception('youtube.json 로드 실패 $e');
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
