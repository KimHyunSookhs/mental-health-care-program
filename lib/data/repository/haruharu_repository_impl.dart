import 'dart:convert';
import 'dart:io';

import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haruharu_model.dart';
import 'package:mental_health_care/domain/repository/haruharu_repository.dart';

class HaruHaruRepositoryImpl implements HaruHaruRepository {
  final String path = 'lib/data/json/haruharu.json';

  @override
  Future<Result<List<HaruHaruModel>>> getHaruList() async {
    final file = File(path);
    final fileContent = await file.readAsString();
    final json = jsonDecode(fileContent);
    return throw Exception();
  }
}
