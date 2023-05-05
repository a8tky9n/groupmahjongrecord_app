import 'dart:developer';
import 'dart:io';
import 'package:groupmahjongrecord/data/remote/server_data_source.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupmahjongrecord/data/models/LoginUser.dart';

class ServerImpl implements Server {
  ServerImpl({required auth}) : _auth = auth;
  final FirebaseAuth _auth;
  final Logger _logger = Logger();

  @override
  Future<bool> resisterUserId(bool isActive) async {
    try {
      var url = Uri(
        scheme: environment['protocol'] as String,
        host: environment['host'] as String,
        port: environment['port'] as int,
        path: '/api/register',
      );
      String body = json.encode(
          {'firebase_uid': _auth.currentUser!.uid, 'is_active': isActive});
      print('RequestBody : ${body}');
      var response = await http
          .post(url, body: body, headers: {"Content-Type": "application/json"});
      print("アカウント作成結果: " + response.statusCode.toString());
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
          scheme: environment['protocol'] as String,
          host: environment['host'] as String,
          port: environment['port'] as int,
          path: '/api/users/me');
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        // 'content-type': 'application/json',
        'Authorization': 'Bearer ' + JWT
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        // log("レスポンス " + response.body);
        // log("レスポンス(UTF8) " + utf8.decode(response.body.codeUnits));
        var res = jsonDecode(utf8.decode(response.body.codeUnits))
            as Map<String, dynamic>;
        log("レスポンス " + res.toString());
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
  Future<bool> updateMyInfo(String nickname, String intro, File? image) async {
    try {
      var url = Uri(
        scheme: environment['protocol'] as String,
        host: environment['host'] as String,
        port: environment['port'] as int,
        path: '/api/users/update_user_info',
        // queryParameters: {
        //   'nick_name': Uri.encodeFull(nickname),
        //   'introduction': Uri.encodeFull(intro)
        // },
      );

      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'content-type': 'multipart/form-data',
        'Authorization': 'Bearer ' + JWT
      };
      var request = new http.MultipartRequest(
        'PUT',
        url,
      );
      Map<String, String> data = {'nick_name': nickname, 'introduction': intro};
      request.fields.addAll(data);
      request.headers.addAll(headers);
      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        var s = image.path.split('/');
        String filename = s.last;
        log('path : ' + image.path.toString());
        log('filename : ' + filename);
        final httpImage = http.MultipartFile.fromBytes(
            "upload_file", imageBytes,
            filename: filename);
        request.files.add(httpImage);
      }
      log(url.toString());
      final response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        _logger.d(response.reasonPhrase);
      }
    } catch (e) {
      _logger.d(e);
    }
    return false;
  }

  @override
  Future<void> createGroup(Map<String, dynamic> json, File? image) async {
    try {
      var url = Uri(
        scheme: VariablesDev['protocol'] as String,
        host: VariablesDev['host'] as String,
        port: VariablesDev['port'] as int,
        // scheme: environment['protocol'] as String,
        // host: environment['host'] as String,
        // port: environment['port'] as int,
        path: '/api/groups/create_groups',
        // queryParameters: {
        //   'title': Uri.encodeFull(json['title']),
        //   'password': Uri.encodeFull(json['password']),
        //   'text': Uri.encodeFull(json['text']),
        // }
      );
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Content-type': 'multipart/form-data',
        'Authorization': 'Bearer ' + JWT,
      };

      Map<String, String> data = {
        'title': json['title'],
        'password': json['password'],
        'text': json['text']
      };
      // log("JSON " + jsonEncode(json));
      // log("JSON(UTF8) " + utf8.encode(jsonEncode(json)).toString());
      log(url.toString());
      var request = new http.MultipartRequest(
        'POST',
        url,
      );
      request.fields.addAll(data);
      request.headers.addAll(headers);

      if (image != null) {
        List<int> imageBytes = image.readAsBytesSync();
        var s = image.path.split('/');
        String filename = s.last;
        log('path : ' + image.path.toString());
        log('filename : ' + filename);
        final httpImage = http.MultipartFile.fromBytes(
            "upload_file", imageBytes,
            filename: filename, contentType: new MediaType('image', 'jpeg'));
        request.files.add(httpImage);
      }

      log(request.files.first.field.toString());
      log(request.files.first.length.toString());
      final response = await request.send();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log("レスポンス" + response.reasonPhrase.toString());
      } else {
        _logger.d(response.reasonPhrase);
      }
    } catch (e) {
      _logger.d(e);
    }
    return;
  }

  // グループ取得
  @override
  Future<List<dynamic>?> getGroup(String gId) async {
    try {
      var url = Uri(
          scheme: environment['protocol'] as String,
          host: environment['host'] as String,
          port: environment['port'] as int,
          path: '/api/groups/get_selected_group',
          queryParameters: {"group_id": gId});
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Authorization': 'Bearer ' + JWT,
      };
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
        var res =
            jsonDecode(utf8.decode(response.body.codeUnits)) as List<dynamic>;
        return res;
      } else {
        _logger.d(response.body);
      }
    } catch (e) {
      _logger.d(e);
    }
    return null;
  }

  // グループに参加
  @override
  Future<String> joinGroup(Map<String, dynamic> json) async {
    var msg = "";
    try {
      var url = Uri(
          scheme: environment['protocol'] as String,
          host: environment['host'] as String,
          port: environment['port'] as int,
          path: '/api/groups/join_group',
          queryParameters: {
            json.keys.elementAt(0): json.values.elementAt(0),
            json.keys.elementAt(1): json.values.elementAt(1),
          });
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + JWT,
      };

      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        log("レスポンス" + response.body);
        return "";
      } else {
        log("レスポンス：" + response.statusCode.toString());
        log("レスポンス：" + response.headers.toString());
        var json = jsonDecode(response.body) as Map<String, dynamic>;
        msg = json.entries.firstWhere((pair) => pair.key == 'detail').value
            as String;
        _logger.d(response.body);
        _logger.d(msg);
      }
    } catch (e) {
      _logger.d(e);
    }
    return msg;
  }

  @override
  Future<void> createGame(Map<String, dynamic> json) async {
    try {
      var url = Uri(
          scheme: environment['protocol'] as String,
          host: environment['host'] as String,
          port: environment['port'] as int,
          path: '/api/games/create_game');
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

  @override
  Future<void> updateGame(Map<String, dynamic> json) async {
    try {
      var url = Uri(
          scheme: environment['protocol'] as String,
          host: environment['host'] as String,
          port: environment['port'] as int,
          path: '/api/games/update_game');
      var JWT = await _auth.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + JWT,
      };
      log("ポスト内容：" + jsonEncode(json));
      var response =
          await http.put(url, headers: headers, body: jsonEncode(json));
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

// // 本番環境
// class ServerInfo {
//   static String host = "192.168.0.160";
//   static String protocol = "http";
//   static int port = 8000;
// }

// // 開発環境
// class DevServerInfo extends ServerInfo {
//   static String host = "192.168.0.160";
//   static String protocol = "http";
//   static int port = 8000;
// }

const String isProduction = String.fromEnvironment('FLAVOR');

// 開発環境
const VariablesDev = {
  'host': "192.168.0.160",
  'protocol': 'http',
  'port': 8000
};

// 本番環境
const VariablesProd = {
  'host': "43.207.20.40",
  'protocol': 'https',
  'port': 443
};

final environment = isProduction == 'prod' ? VariablesProd : VariablesDev;
