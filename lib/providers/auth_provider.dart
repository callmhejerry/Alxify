import 'package:alxify/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();

  bool isLogginUserIn = false;
  bool isCreatingAccount = false;
  String? logInError;
  String? createUserError;

  void logIn({
    required String email,
    required String password,
  }) async {
    try {
      isLogginUserIn = true;
      notifyListeners();
      await authService.signInWithEmailAndPassword(
          email: email, password: password);
      isLogginUserIn = false;
      logInError = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          logInError =
              "The email you provided is invalid , please check it and try again";
          notifyListeners();
          break;
        case 'wrong-password':
          logInError = "Incorrect login details, please try again";
          notifyListeners();
          break;
        case 'user-not-found':
          logInError =
              "No user exist with the provided email, please create an account";
          notifyListeners();
          break;
        default:
          logInError = e.code;
          notifyListeners();
          break;
      }
    }
  }

  void createUser({
    required String email,
    required String password,
  }) async {
    try {
      isCreatingAccount = true;
      await authService.createAccount(email: email, password: password);
      isCreatingAccount = false;
      createUserError = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          createUserError =
              "The email you provided is invalid , please check it and try again";
          notifyListeners();
          break;
        case 'weak-password':
          createUserError = "weak password. please put in a stronger password";
          notifyListeners();
          break;
        case 'email-already-in-use':
          createUserError =
              "No user exist with the provided email, please create an account";
          notifyListeners();
          break;
        default:
          createUserError = e.code;
          notifyListeners();
          break;
      }
    }
  }
}
