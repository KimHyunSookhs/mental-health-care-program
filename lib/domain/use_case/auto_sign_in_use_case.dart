import '../repository/auth_repository.dart';

class AutoSignInUseCase {
  final AuthRepository authRepository;

  AutoSignInUseCase({required this.authRepository});

  Future<Map<String, String?>> getStoredCredentials() async {
    return await authRepository.getStoredCredentials();
  }
}
