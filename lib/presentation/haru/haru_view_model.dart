import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/domain/use_case/random_pick_use_case.dart';
import 'package:mental_health_care/presentation/haru/haru_state.dart';

class HaruViewModel with ChangeNotifier {
  final RandomPickUseCase _randomPickUseCase;

  HaruViewModel({
    required RandomPickUseCase randomPickUseCase,
  }) : _randomPickUseCase = randomPickUseCase;

  HaruState _state = HaruState();

  HaruState get state => _state;

  Future<void> pickHaru() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final result = await _randomPickUseCase.execute();
      switch (result) {
        case Success(data: final haru):
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
