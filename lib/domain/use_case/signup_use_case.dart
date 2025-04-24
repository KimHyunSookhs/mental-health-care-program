import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_care/domain/repository/auth_repository.dart';

class SignupUseCase {
  final AuthRepository authRepository;

  SignupUseCase({required this.authRepository});

  Future<User?> execute(String email, String password, String nickname) async {
    return authRepository.signUp(email, password, nickname);
  }
}
