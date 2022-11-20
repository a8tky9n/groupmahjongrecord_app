import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository.dart';
import 'package:groupmahjongrecord/data/provider/auth_repository_provider.dart';

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>(
        (ref) => LoginViewModel(repository: ref.read(authRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required repository}) : _repository = repository;

  final AuthRepository _repository;

  //mutable
  String? status;
  String? email;
  String? password;
  String? confPassword;
  int? loginStatus;

  void updateStatus(String message) {
    status = message;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context, Function(String) errorCallback) {
    var res = _repository.signIn(email!, password!, context, errorCallback);
    log("サインイン");
    notifyListeners();
    return res;
  }

  Future<void> signOn(BuildContext context) {
    return _repository.signOn(email!, password!, context);
  }

  Future<void> forgetPassword(BuildContext context) {
    return _repository.forgetPass(password!, context);
  }

  Future<void> signOut() {
    return _repository.signOut();
  }

  void setEmail(String value) {
    log("email:" + value);
    email = value;
  }

  void setPass(String value) {
    password = value;
    log("pass:" + value);
  }

  void setConfPass(String value) {
    confPassword = value;
  }

  void setLoginStatus(int value) {
    loginStatus = value;
    notifyListeners();
  }

  bool signInComplete() {
    return _repository.fetchUser() != null;
  }

  User getUser() {
    return _repository.fetchUser()!;
  }
}
