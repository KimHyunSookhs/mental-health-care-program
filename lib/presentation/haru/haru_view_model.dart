import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/domain/repository/haru_repository.dart';
import 'package:mental_health_care/presentation/haru/haru_state.dart';

class HaruViewModel with ChangeNotifier {
  final HaruRepository _haruRepository;

  HaruViewModel({
    required HaruRepository haruRepository,
  }) : _haruRepository = haruRepository;

  HaruState _state = HaruState();

  HaruState get state => _state;

  Future<void> fetchHaru() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final result = await _haruRepository.getHaru();
      switch (result) {
        case Success(data: final haru):
          print('데이터 가져오기 성공: $haru');
          _state = state.copyWith(
              isLoading: false, haru: Result.success(haru), errorMessage: '');
          break;
        case Error(e: final e):
          print('에러 발생: $e');
          _state = state.copyWith(
              isLoading: false,
              haru: Result.error(e),
              errorMessage: e.toString());
          break;
      }
    } catch (e) {
      print('예외 발생: $e');
      throw Exception(e);
    }
    notifyListeners();
  }
}
