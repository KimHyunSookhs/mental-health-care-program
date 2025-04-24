import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/domain/use_case/signup_use_case.dart';

class SignUpViewModel with ChangeNotifier {
  final SignupUseCase _signupUseCase;

  SignUpViewModel({required SignupUseCase signupUseCase})
      : _signupUseCase = signupUseCase;

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> signUp(String email, String password, String nickname) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _signupUseCase.execute(email, password, nickname);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
