import 'package:flutter/cupertino.dart';
import 'package:mental_health_care/domain/use_case/auto_sign_in_use_case.dart';
import 'package:mental_health_care/domain/use_case/sign_in_use_case.dart';

class SignInViewModel with ChangeNotifier {
  final SignInUseCase useCase;
  final AutoSignInUseCase autoSignInUseCase;

  SignInViewModel({required this.useCase, required this.autoSignInUseCase});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  String? _email;
  String? _password;

  String? get email => _email;

  String? get password => _password;

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

  Future<void> loadStoredCredentials() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await autoSignInUseCase.getStoredCredentials();
      _email = result['email'];
      _password = result['password'];
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
