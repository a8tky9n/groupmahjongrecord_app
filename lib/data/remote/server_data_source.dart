import 'dart:io';
import 'package:groupmahjongrecord/data/models/LoginUser.dart';

abstract class Server {
  Future<bool> resisterUserId(bool isActive);
  Future<bool> updateMyInfo(String nickname, String intro, File? image);
  Future<LoginUser?> getMyInfo();
  // Future<List<User?>> getAllUserInfo();
  // Future<User> getUserInfo(String userId);
  Future<void> createGroup(Map<String, dynamic> json, File? image);
  Future<List<dynamic>?> getGroup(String gId);
  Future<String> joinGroup(Map<String, dynamic> json);
  Future<void> createGame(Map<String, dynamic> json);
  Future<void> updateGame(Map<String, dynamic> json);
}
