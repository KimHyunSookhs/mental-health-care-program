import 'dart:convert';
import 'dart:io';

import 'package:mental_health_care/data/data_source/haruharu_data_source.dart';
import 'package:mental_health_care/data/model/haru_haru_model.dart';

class HaruHaruDataSourceImpl implements HaruHaruDataSource {
  final String path = 'lib/data/json/haruharu.json';

  @override
  Future<List<HaruHaruModel>> getHaruList() async {
    final file = File(path);
    final fileString = await file.readAsString();
    final Map<String, dynamic> json = jsonDecode(fileString);
    final List<dynamic> haru = json['haru'];
    return haru.map((e) => HaruHaruModel.fromJson(e)).toList();
  }
}
