import 'package:groupmahjongrecord/data/models/LoginUser.dart';

abstract class ServerRepository {
  Future<bool> resisterUserId(String userId, bool isActive);
  // ユーザー関連
  Future<LoginUser?> getMe();
  // Future<Map> getAllUsers();
  // Future<Map> getUser(String userId);
  // // グループ関連
  Future<void> createGroup(Map<String, dynamic> json);
  // Future<Map> joinGroup(String userId);
  // Future<Map> leaveGroup(String userId);
  // Future<Map> getAllGroups(String userId);
  // Future<Map> getGroup(String userId);
  // Future<Map> getGroupMember();
  // // 対局関連
  // Future<Map> createGame(String userId);
  // Future<Map> deleteGame(String userId);
  // Future<Map> getGame(String userId);
  // Future<Map> updateGame(String userId);
}
