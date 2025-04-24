import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_care/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> signUp(String email, String password, String nickname) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // 닉네임 업데이트
      if (user != null) {
        await user.updateDisplayName(nickname);
        await user.reload();
        user = _auth.currentUser;
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print('회원가입 실패: ${e.message}');
      return null;
    }
  }

  @override
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
    }
  }

  @override
  Future<void> signOut() async {
    _auth.signOut();
  }
}
