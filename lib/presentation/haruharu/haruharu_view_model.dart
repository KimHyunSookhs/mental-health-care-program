import 'package:flutter/foundation.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/model/haru_haru_model.dart';
import 'package:mental_health_care/domain/usecase/get_haruharu_use_case.dart';
import 'package:mental_health_care/presentation/haruharu/haruharu_state.dart';

class HaruHaruViewModel with ChangeNotifier {
  final GetHaruHaruUseCase _getHaruHaruUseCase;

  HaruHaruViewModel({required GetHaruHaruUseCase getHaruHaruUseCase})
    : _getHaruHaruUseCase = getHaruHaruUseCase;

  HaruHaruState _state = HaruHaruState();

  HaruHaruState get state => _state;

  Future<void> getHaruHaruUseCase() async {
    _state = state.copyWith(isHaruLoading: true);
    notifyListeners();

    final result = await _getHaruHaruUseCase.execute();
    if (result is Success<List<HaruHaruModel>>) {
      _state = state.copyWith(isHaruLoading: false, haruModel: result.data);
      print("getHaruHaruUseCase result: $result");
    } else if (result is Error<List<HaruHaruModel>>) {
      _state = state.copyWith(isHaruLoading: false);
      print("getHaruHaruUseCase result: $result");
    }
    notifyListeners();
  }
}
