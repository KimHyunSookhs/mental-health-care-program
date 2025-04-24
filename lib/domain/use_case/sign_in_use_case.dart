import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_care/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<User?> execute(String email, String password) async {
    return authRepository.signIn(email, password);
  }
}
