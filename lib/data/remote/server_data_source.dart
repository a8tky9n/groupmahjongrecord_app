import 'package:groupmahjongrecord/data/models/LoginUser.dart';
import 'package:groupmahjongrecord/data/models/User.dart';
import 'package:groupmahjongrecord/data/models/group.dart';

abstract class Server {
  Future<bool> resisterUserId(String userId, bool isActive);
  Future<LoginUser?> getMyInfo();
  // Future<List<User?>> getAllUserInfo();
  // Future<User> getUserInfo(String userId);
  Future<void> createGroup(Map<String, dynamic> json);
}
