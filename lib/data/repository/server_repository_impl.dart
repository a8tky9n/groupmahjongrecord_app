import 'package:groupmahjongrecord/data/models/LoginUser.dart';
import 'package:groupmahjongrecord/data/repository/server_repository.dart';
import 'package:groupmahjongrecord/data/remote/server_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServerRepositoryImpl implements ServerRepository {
  ServerRepositoryImpl(this._serverStoreDataSource);
  final Server _serverStoreDataSource;

  @override
  Future<bool> resisterUserId(String userId, bool isActive) {
    return _serverStoreDataSource.resisterUserId(userId, isActive);
  }

  @override
  Future<LoginUser?> getMe() {
    return _serverStoreDataSource.getMyInfo();
  }

  @override
  Future<void> createGroup(Map<String, dynamic> json) {
    return _serverStoreDataSource.createGroup(json);
  }
}
