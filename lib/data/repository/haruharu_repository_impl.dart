import 'dart:convert';
import 'dart:io';

import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru_haru_model.dart';
import 'package:mental_health_care/domain/repository/haruharu_repository.dart';

class HaruHaruRepositoryImpl implements HaruHaruRepository {
  final String path = 'lib/data/json/haruharu.json';

  @override
  Future<Result<List<HaruHaruModel>>> getHaruList() async {
    try {
      final file = File(path);
      final fileContent = await file.readAsString();
      final json = jsonDecode(fileContent);
      return Result.success(json.map((e) => HaruHaruModel.fromJson(e)));
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
