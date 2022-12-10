import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required FirebaseAuth auth}) : _auth = auth;

  static final Logger _logger = Logger();
  final FirebaseAuth _auth;

  @override
  Future<void> signIn(String eMail, String pass, BuildContext context,
      Function(String) eCallback) async {
    log("サインイン");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: eMail,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      eCallback(exceptionMessage(e));
      _logger.e(e.toString());
    } catch (e) {
      eCallback("予期せぬエラーが発生しました。");
      _logger.e(e.toString());
    }
  }

  @override
  Future<void> signOn(String eMail, String pass, BuildContext context,
      Function(String) eCallback) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: eMail, password: pass);
    } on FirebaseAuthException catch (e) {
      eCallback(exceptionMessage(e));
      _logger.e(e.toString());
    } catch (e) {
      eCallback("予期せぬエラーが発生しました。");
      _logger.e(e.toString());
    }
  }

  @override
  Future<void> forgetPass(
      String eMail, BuildContext context, Function(String) eCallback) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: eMail);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  @override
  User? getUser() {
    return _auth.currentUser;
  }

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  static String exceptionMessage(FirebaseAuthException e) {
    String message = '';
    switch (e.code) {
      case 'invalid-email':
        message = 'メールアドレスが間違っています。';
        break;
      case 'wrong-password':
        message = 'パスワードが間違っています。';
        break;
      case 'user-not-found':
        message = 'このアカウントは存在しません。';
        break;
      case 'user-disabled':
        message = 'このメールアドレスは無効になっています。';
        break;
      case 'too-many-requests':
        message = '回線が混雑しています。もう一度試してみてください。';
        break;
      case 'operation-not-allowed':
        message = 'メールアドレスとパスワードでのログインは有効になっていません。';
        break;
      case 'email-already-in-use':
        message = 'このメールアドレスはすでに登録されています。';
        break;
      default:
        message = '予期せぬエラーが発生しました。';
        break;
    }
    return message;
  }
}
