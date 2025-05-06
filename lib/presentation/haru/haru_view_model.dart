import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/domain/use_case/random_pick_use_case.dart';
import 'package:mental_health_care/presentation/haru/haru_state.dart';

import '../../data/model/haru.dart';

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
          _state = state.copyWith(
              isLoading: false,
              haru: Result.error(e),
              errorMessage: e.toString());
          break;
      }
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }

  Future<void> saveHaruListToFirestore(List<Haru> haruList) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('로그인된 사용자가 없습니다.');
    }
    final userEmail = user.email ?? 'unknown';
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final haruMapList = haruList
        .map((h) => {
              'id': h.id,
              'content': h.content,
              'isChecked': h.isChecked,
              'timeOfDay': h.timeOfDay,
            })
        .toList();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('haruList')
        .doc(today)
        .set({'items': haruMapList});
  }
}
