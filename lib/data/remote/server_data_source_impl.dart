import 'dart:developer';
import 'package:groupmahjongrecord/data/models/Group.dart';
import 'package:groupmahjongrecord/data/remote/server_data_source.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupmahjongrecord/data/models/LoginUser.dart';
import 'dart:convert';

class ServerImpl implements Server {
  ServerImpl({required auth}) : _auth = auth;
  final FirebaseAuth _auth;
  final Logger _logger = Logger();

  @override
  Future<bool> resisterUserId(bool isActive) async {
    try {
      var url = Uri(
        scheme: ServerInfo.protocol,
        host: ServerInfo.host,
        port: 8000,
        path: '/api/register',
      );
      String body = json.encode(
          {'firebase_uid': _auth.currentUser!.uid, 'is_active': isActive});
      print('RequestBody : ${body}');
      var response = await http
          .post(url, body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return true;
      } else {
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
    return false;
  }

  @override
  Future<LoginUser?> getMyInfo() async {
    try {
      var url = Uri(
          scheme: ServerInfo.protocol,
          host: ServerInfo.host,
          port: 8000,
          path: '/api/users/me');
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        // 'content-type': 'application/json',
        'Authorization': 'Bearer ' + JWT
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        final user = LoginUser.fromJson(res);
        return user;
      } else {
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
    return null;
  }

  @override
  Future<void> createGroup(Map<String, dynamic> json) async {
    try {
      var url = Uri(
          scheme: ServerInfo.protocol,
          host: ServerInfo.host,
          port: ServerInfo.port,
          path: '/api/groups/create_groups');
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + JWT,
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(json));
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
      } else {
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
  }

  // グループ取得
  @override
  Future<List<dynamic>?> getGroup(String gId) async {
    try {
      var url = Uri(
          scheme: ServerInfo.protocol,
          host: ServerInfo.host,
          port: ServerInfo.port,
          path: '/api/groups/get_selected_group',
          queryParameters: {"group_id": gId});
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Authorization': 'Bearer ' + JWT,
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
        var res = jsonDecode(response.body) as List<dynamic>;
        return res;
      } else {
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
    return null;
  }

  @override
  Future<void> createGame(Map<String, dynamic> json) async {
    try {
      var url = Uri(
          scheme: ServerInfo.protocol,
          host: ServerInfo.host,
          port: ServerInfo.port,
          path: '/api/games/create_game/');
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + JWT,
      };
      log("ポスト内容：" + jsonEncode(json));
      var response =
          await http.post(url, headers: headers, body: jsonEncode(json));
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
      } else {
        log("レスポンス：" + response.statusCode.toString());
        log("レスポンス：" + response.headers.toString());
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
  }
}

class ServerInfo {
  static String host = "192.168.0.160";
  static String protocol = "http";
  static int port = 8000;
}
