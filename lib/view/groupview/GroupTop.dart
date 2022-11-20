import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:groupmahjongrecord/data/models/Group.dart';
import 'package:groupmahjongrecord/data/models/User.dart';
import 'package:groupmahjongrecord/data/models/Score.dart';
import 'package:groupmahjongrecord/components/ScoreRow.dart';
import 'package:groupmahjongrecord/components/ScoreHeader.dart';

// グループトップ画面
class GroupTop extends StatefulWidget {
  final Group group;
  final User user;
  const GroupTop({
    Key? key,
    required this.group,
    required this.user,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => groupTopPage();
}

class groupTopPage extends State<GroupTop> {
  @override
  void initState() {
    super.initState();
    _getScoreList();
  }

  var _scores = <Score>{};
  bool _isLoading = true;

  // サーバーから成績を取ってくる
  Future<void> _getScoreList() async {
    User user = widget.user;
    print('get user info');
    var url = Uri(scheme: 'https', host: 'reqres.in', path: '/api/users/2');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = res['totalItems'];
      print('Number of books about http: $itemCount.');
      setState(() {
        _isLoading = false;
        for (var i = 0; i < 7; i++) {
          _scores.add(Score(
              scoreId: 1,
              createDate: DateTime.now(),
              points: [31, 3, -13, -21],
              users: [user, user, user, user, user]));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // グループのトップ画
  Widget _topImage() {
    var group = widget.group;
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          group.title!,
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Ink.image(
          image: NetworkImage(
            group.image!,
          ),
          height: 240,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          group.text!,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 300,
          // 内側の余白（パディング）
          // padding: EdgeInsets.all(8),
          // 外側の余白（マージン）
          // margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/f_logo_RGB-Blue_1024.png',
                  width: 45,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/Twitter social icons - rounded square - blue.png',
                  width: 45,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/icon/LINE_APP_iOS.png',
                  width: 45,
                ),
              ),
              Ink(
                child: IconButton(
                  icon: Icon(Icons.mail_rounded),
                  iconSize: 45,
                  splashRadius: 30,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // 直近の成績
  Widget _recentScore() {
    var user = widget.user;
    return Column(
      children: <Widget>[
        const Text(
          "直近の対戦記録",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const ScoreHeader(),
        const Divider(),
        for (var score in _scores)
          ScoreRow(
            score: score,
            OnTapCallback: () => {},
          ),
      ],
    );
  }

  Widget _main() {
    //グループトップ
    return Column(
      children: <Widget>[
        _topImage(),
        _isLoading
            ? Column(children: const <Widget>[
                SizedBox(
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                )
              ])
            : _recentScore(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }
}
