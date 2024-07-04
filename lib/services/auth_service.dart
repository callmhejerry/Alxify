import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(fullName);
    return userCredential;
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  bool isUserLoggedIn() {
    final user = firebaseAuth.currentUser;
    return user != null;
  }
}
