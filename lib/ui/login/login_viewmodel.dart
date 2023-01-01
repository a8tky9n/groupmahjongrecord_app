import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/data/provider/server_repository_provider.dart';
import 'package:groupmahjongrecord/data/repository/server_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository.dart';
import 'package:groupmahjongrecord/data/provider/auth_repository_provider.dart';

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) => LoginViewModel(
        repository: ref.read(authRepositoryProvider),
        server: ref.read(serverRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required repository, required server})
      : _repository = repository,
        _server = server;

  final AuthRepository _repository;
  final ServerRepository _server;

  //mutable
  String? email;
  String? password;
  String? confPassword;
  int? loginStatus;

  Future<void> signIn(BuildContext context, Function(String) errorCallback) {
    var res = _repository.signIn(email!, password!, context, errorCallback);
    log("サインイン");
    notifyListeners();
    return res;
  }

  Future<void> signOn(BuildContext context, Function(String) errorCallback) {
    var res = _repository.signOn(email!, password!, context, errorCallback);
    notifyListeners();
    return res;
  }

  Future<void> forgetPassword(
      BuildContext context, Function(String) errorCallback) {
    return _repository.forgetPass(password!, context, errorCallback);
  }

  Future<void> signOut() {
    return _repository.signOut();
  }

  // アカウント登録
  Future<void> registerId(
      VoidCallback successCallback, VoidCallback errorCallback) async {
    bool isSuccess = await _server.resisterUserId(true);
    log("アカウント登録完了");
    if (isSuccess) {
      log("アカウント登録成功");
      successCallback();
    } else {
      log("アカウント登録失敗");
      errorCallback();
    }
    notifyListeners();
    return;
  }

  // ログインしているかどうか
  Future<bool> isRegistered() async {
    if (await _server.getMe() != null) {
      return true;
    } else {
      return false;
    }
  }

  void setEmail(String value) {
    // log("email:" + value);
    email = value;
  }

  void setPass(String value) {
    password = value;
    // log("pass:" + value);
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
