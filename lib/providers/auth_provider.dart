import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  void signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
