import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<User?> signIn(String email, String password);

  Future<User?> signUp(String email, String password, String nickname);

  Future<void> signOut();

  Future<Map<String, String?>> getStoredCredentials();
}
