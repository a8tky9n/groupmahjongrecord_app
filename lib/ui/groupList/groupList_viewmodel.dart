import 'dart:developer';
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

  File? groupImage;
  String? groupName;
  String? password;
  String? description;

  String? joinGroupID;
  String? joinPassword;

  File? newProfileImage;
  String? newUserName;
  String? newIntorduction;

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

  // プロフィール画像設定
  void setNewProfileImage(File? value) {
    newProfileImage = value;
    notifyListeners();
  }

  // プロフィール画像設定
  void setNewUserName(String value) {
    newUserName = value;
    notifyListeners();
  }

  // プロフィール画像設定
  void setNewIntro(String value) {
    newIntorduction = value;
    notifyListeners();
  }

  void setJoinGroupId(String value) {
    joinGroupID = value;
    notifyListeners();
  }

  void setJoinPassword(String value) {
    joinPassword = value;
    notifyListeners();
  }

  // グループ作成
  Future<void> createGroup() async {
    var json = {
      'title': groupName,
      'password': password,
      'text': description,
    };
    await _repository.createGroup(json, groupImage);
    await getLoginUser(() {});
    notifyListeners();
  }

  Future<void> joinGroup(Function(String) onFailed) async {
    final json = {
      "group_id": joinGroupID,
      "password": joinPassword,
    };
    var errorMsg = await _repository.joinGroup(json);
    log("エラーメッセージ " + errorMsg);
    if (errorMsg == "") {
      await getLoginUser(() {});
    } else {
      onFailed(errorMsg);
      log("グループ参加に失敗");
    }
    notifyListeners();
  }

  Future<void> updateUserInfo(VoidCallback onFailed) async {
    var isSuccess = await _repository.updateMe(
        newUserName ?? "", newIntorduction ?? "", newProfileImage);
    log(isSuccess.toString());
    notifyListeners();
  }
}
