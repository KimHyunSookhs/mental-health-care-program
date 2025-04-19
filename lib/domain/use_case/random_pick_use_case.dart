import 'dart:math';

import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';

// 각 timeOfDay 에서 랜덤으로 content 하나씩만 뽑기
class RandomPickUseCase {
  final HaruRepository haruRepository;

  RandomPickUseCase({required this.haruRepository});

  Future<Result<List<Haru>>> execute() async {
    //모든 리스트 가져오기
    final haruResult = await haruRepository.getHaru();

    if (haruResult case Error(:final e)) {
      return Result.error(e);
    }

    final haruList = (haruResult as Success).data;
    final random = Random();

    // timeOfDay별로 그룹화
    final Map<String, List<Haru>> grouped = {};

    for (final haru in haruList) {
      grouped.putIfAbsent(haru.timeOfDay, () => []).add(haru);
    }

    //각 그룹에서 하나씩 랜덤 추출
    final List<Haru> picked = [];
    for (final entry in grouped.entries) {
      if (entry.value.isNotEmpty) {
        final pick = entry.value[random.nextInt(entry.value.length)];
        picked.add(pick);
      }
    }
    return Result.success(picked);
  }
}
