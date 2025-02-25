import 'package:alxify/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();

  bool isLogginUserIn = false;
  bool isCreatingAccount = false;
  String? logInError;
  String? createUserError;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      isLogginUserIn = true;
      logInError = null;
      notifyListeners();
      await authService.signInWithEmailAndPassword(
          email: email, password: password);
      isLogginUserIn = false;

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          logInError =
              "The email you provided is invalid , please check it and try again";
          isLogginUserIn = false;
          notifyListeners();
          break;
        case 'wrong-password':
          logInError = "Incorrect login details, please try again";
          isLogginUserIn = false;
          notifyListeners();
          break;
        case 'user-not-found':
          logInError =
              "No user exist with the provided email, please create an account";
          isLogginUserIn = false;
          notifyListeners();
          break;
        default:
          logInError = e.code;
          isLogginUserIn = false;
          notifyListeners();
          break;
      }
    }
  }

  void logOut() async {
    await authService.logOut();
  }

  void createUser({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      isCreatingAccount = true;
      createUserError = null;
      notifyListeners();
      await authService.createAccount(
        email: email,
        password: password,
        fullName: fullName,
      );
      isCreatingAccount = false;

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          createUserError =
              "The email you provided is invalid , please check it and try again";
          isCreatingAccount = false;
          notifyListeners();
          break;
        case 'weak-password':
          createUserError = "weak password. please put in a stronger password";
          isCreatingAccount = false;
          notifyListeners();
          break;
        case 'email-already-in-use':
          createUserError = "Email already in use";
          isCreatingAccount = false;
          notifyListeners();
          break;
        default:
          createUserError = e.code;
          isCreatingAccount = false;
          notifyListeners();
          break;
      }
    }
  }

  bool isUserLoggedIn() {
    return authService.isUserLoggedIn();
  }
}
