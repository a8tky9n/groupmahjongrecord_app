import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthDataSource {
  Stream<User?> get authStateChanges;

  User? getUser();
  Future<void> signIn(
      String eMail, String pass, BuildContext ctx, Function(String) eCallback);
  Future<void> signOn(
      String eMail, String pass, BuildContext ctx, Function(String) eCallback);
  Future<void> forgetPass(
      String eMail, BuildContext ctx, Function(String) eCallback);
  Future<void> signOut();
}