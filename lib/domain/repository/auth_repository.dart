abstract interface class AuthRepository {
  Future<void> signIn(String email, String password);

  Future<void> signUp(String email, String password, String nickname);

  Future<void> signOut();
}
