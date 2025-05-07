import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_care/core/result/result.dart';
import 'package:mental_health_care/data/dto/haru_dto.dart';
import 'package:mental_health_care/data/mapper/haru_mapper.dart';
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

  Future<void> loadOrCreateHaruList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _state = state.copyWith(
          isLoading: false,
          haru: Result.error(Exception("로그인이 필요합니다") as String),
          errorMessage: "로그인이 필요합니다");
      notifyListeners();
      return;
    }

    final userEmail = user.email ?? 'unknown';
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('haruList')
        .doc(today);

    final doc = await docRef.get();

    if (doc.exists) {
      // 이미 저장된 리스트가 있다면 불러오기
      final items = List<Map<String, dynamic>>.from(doc['items']);
      final haruList = items.map((e) => HaruDto.fromJson(e).toHaru()).toList();
      _state = state.copyWith(isLoading: false, haru: Result.success(haruList));
    } else {
      // 없으면 랜덤 Pick 후 저장
      final result = await _randomPickUseCase.execute();
      switch (result) {
        case Success(data: final haruList):
          _state =
              state.copyWith(isLoading: false, haru: Result.success(haruList));
          await saveHaruListToFirestore(haruList);
          break;
        case Error(e: final e):
          _state = state.copyWith(
              isLoading: false,
              haru: Result.error(e),
              errorMessage: e.toString());
      }
    }
    notifyListeners();
  }
}
