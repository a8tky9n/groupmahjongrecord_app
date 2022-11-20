import 'dart:developer';
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
  Future<bool> resisterUserId(String userId, bool isActive) async {
    try {
      var url = Uri(
        scheme: ServerInfo.protocol,
        host: ServerInfo.host,
        port: 8000,
        path: '/api/register',
      );
      String body =
          json.encode({'firebase_uid': userId, 'is_active': isActive});
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
        log("グループ" + utf8.decode(res['group']).toString());
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
      var response = await http.post(url,
          headers: headers, body: utf8.encode(jsonEncode(json)));
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
      } else {
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
  }

  // @override
  // Future<List<UserInfo.User>> getAllUserInfo() async {
  //   try {
  //     var url = Uri(
  //         scheme: ServerInfo.protocol,
  //         host: ServerInfo.host,
  //         port: 8000,
  //         path: '/api/users/all_users');
  //     var JWT = await _auth.currentUser!.getIdToken(true);
  //     Map<String, String> headers = {
  //       // 'content-type': 'application/json',
  //       'Authorization': 'Bearer ' + JWT
  //     };
  //     var response = await http.get(url, headers: headers);
  //     var users = <UserInfo.User>{};
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body) as Map<String, dynamic>;
  //       for (var datum in data) {
  //         users.add(UserInfo.User.fromJson(datum));
  //       }
  //       return users;
  //     } else {
  //       _logger.d(response.body);
  //     }
  //   } catch (e) {
  //     _logger.d(e);
  //   }
  //   return null;
  // }
  // @override
  // Future<User> getUserInfo(String userId);
  // @override
  // Future<Group> createGroup(Map<String, dynamic> data);
}

class ServerInfo {
  static String host = "192.168.0.160";
  static String protocol = "http";
  static int port = 8000;
}
