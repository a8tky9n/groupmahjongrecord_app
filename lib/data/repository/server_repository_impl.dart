import 'dart:io';
import 'package:groupmahjongrecord/data/models/LoginUser.dart';
import 'package:groupmahjongrecord/data/repository/server_repository.dart';
import 'package:groupmahjongrecord/data/remote/server_data_source.dart';

class ServerRepositoryImpl implements ServerRepository {
  ServerRepositoryImpl(this._serverStoreDataSource);
  final Server _serverStoreDataSource;

  // ユーザーID登録
  @override
  Future<bool> resisterUserId(bool isActive) {
    return _serverStoreDataSource.resisterUserId(isActive);
  }

  // ログインユーザー情報取得
  @override
  Future<LoginUser?> getMe() {
    return _serverStoreDataSource.getMyInfo();
  }

  // ログインユーザー情報取得
  @override
  Future<bool> updateMe(String nickname, String intro, File? image) {
    return _serverStoreDataSource.updateMyInfo(nickname, intro, image);
  }

  // グループ作成
  @override
  Future<void> createGroup(Map<String, dynamic> json, File? image) {
    return _serverStoreDataSource.createGroup(json, image);
  }

  // グループ作成
  @override
  Future<String> joinGroup(Map<String, dynamic> json) {
    return _serverStoreDataSource.joinGroup(json);
  }

  // グループ取得
  @override
  Future<List<dynamic>?> getGroup(String groupId) {
    return _serverStoreDataSource.getGroup(groupId);
  }

  // 対局作成
  @override
  Future<void> createGame(Map<String, dynamic> json) {
    return _serverStoreDataSource.createGame(json);
  }

  // 対局更新
  @override
  Future<void> updateGame(Map<String, dynamic> json) {
    return _serverStoreDataSource.updateGame(json);
  }
}
