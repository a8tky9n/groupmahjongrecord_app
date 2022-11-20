import 'dart:io';
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

  LoginUser? loginUser;
  // ユーザー情報取得
  Future<void> getLoginUser() async {
    loginUser = await _repository.getMe();
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
    _repository.createGroup(json);
    notifyListeners();
  }
}
