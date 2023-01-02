import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:groupmahjongrecord/data/models/LoginUser.dart';
import 'package:groupmahjongrecord/data/provider/auth_repository_provider.dart';
import 'package:groupmahjongrecord/data/provider/server_repository_provider.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository.dart';
import 'package:groupmahjongrecord/data/repository/server_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

final groupListViewModelProvider =
    ChangeNotifierProvider.autoDispose<GroupListViewModel>((ref) =>
        GroupListViewModel(
            repository: ref.read(serverRepositoryProvider),
            auth: ref.read(authRepositoryProvider)));

class GroupListViewModel extends ChangeNotifier {
  GroupListViewModel({required repository, required auth})
      : _repository = repository,
        _authRepository = auth;

  final AuthRepository _authRepository;
  final ServerRepository _repository;

  String? groupName;
  String? password;
  String? description;
  File? groupImage;
  // ユーザー情報
  LoginUser? loginUser;
  bool isloading = false;
  // ユーザー情報取得
  Future<void> getLoginUser(VoidCallback onFailed) async {
    loginUser = await _repository.getMe();
    if (loginUser == null) {
      log("ユーザー情報がNull");
      onFailed();
    } else {
      log("ユーザー情報がNullでない");
    }
    notifyListeners();
  }

  // サインアウト
  Future<void> signOut() {
    return _authRepository.signOut();
  }

  // グループ名設定
  void setGroupName(String value) {
    groupName = value;
    notifyListeners();
  }

  // グループパスワード設定
  void setPass(String value) {
    password = value;
    notifyListeners();
  }

  // グループ説明設定
  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  // グループ画像設定
  void setGroupImage(File? value) {
    groupImage = value;
  }

  // グループ作成
  Future<void> createGroup() async {
    var json = {
      'title': groupName,
      'password': password,
      'text': description,
      'image': "",
    };
    await _repository.createGroup(json);
    await getLoginUser(() {});
    notifyListeners();
  }
}
