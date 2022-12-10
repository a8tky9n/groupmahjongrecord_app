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

  // グループ作成
  @override
  Future<void> createGroup(Map<String, dynamic> json) {
    return _serverStoreDataSource.createGroup(json);
  }

  // グループ取得
  @override
  Future<List<dynamic>?> getGroup(String groupId) {
    return _serverStoreDataSource.getGroup(groupId);
  }

  // グループ取得
  @override
  Future<void> createGame(Map<String, dynamic> json) {
    return _serverStoreDataSource.createGame(json);
  }
}
