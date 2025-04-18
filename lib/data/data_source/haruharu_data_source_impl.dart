import 'dart:convert';
import 'dart:io';

import 'package:mental_health_care/data/data_source/haruharu_data_source.dart';
import 'package:mental_health_care/data/model/haruharu_model.dart';

class HaruHaruDataSourceImpl implements HaruHaruDataSource {
  @override
  Future<List<HaruHaruModel>> getHaruList() async {
    final String path = 'lib/data/json/haruharu.json';
    final file = File(path);
    final fileContent = await file.readAsString();
    final List<dynamic> json = jsonDecode(fileContent);
    return json.map((e) => HaruHaruModel.fromJson(e)).toList();
  }
}
