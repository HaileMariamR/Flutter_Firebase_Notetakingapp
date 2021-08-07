import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Usermodel.dart';

class MainAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Usermodel?> SignupwithEmail(
      String emailInput, String passwordInput) async {
    try {
      final User = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: emailInput, password: passwordInput))
          .user;
      return Usermodel(email: User!.email);
    } catch (e) {}
  }

  Future<Usermodel?> SigninwithEmail(
      String emailInput, String passwordInput) async {
    try {
      final User = (await _firebaseAuth.signInWithEmailAndPassword(
              email: emailInput, password: passwordInput))
          .user;
      return Usermodel(email: User!.email);
    } catch (e) {}
  }
}
