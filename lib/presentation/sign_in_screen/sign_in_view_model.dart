import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/domain/use_case/sign_in_use_case.dart';

class SignInViewModel with ChangeNotifier {
  final SignInUseCase useCase;

  SignInViewModel({required this.useCase});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await useCase.execute(email, password);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
