import 'dart:ffi';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

import 'package:groupmahjongrecord/Group.dart';
import 'package:groupmahjongrecord/User.dart';
import 'package:groupmahjongrecord/Score.dart';

// 対局開始用のユーザークラス
class Player {
  final User user;
  int position;

  Player({required this.user, this.position = 0});
}

// 対戦記録画面
class RecordScore extends StatefulWidget {
  final Group group;
  final User user;
  const RecordScore({
    Key? key,
    required this.group,
    required this.user,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => recordScorePage();
}

class recordScorePage extends State<RecordScore> {
  @override
  void initState() {
    super.initState();
    _getMemberList();
  }

  var _players = <Player>{};
  var positions = [1, 2, 3, 4];
  Future<void> _getMemberList() async {
    print('get users info');
    var url = Uri(
        scheme: 'https',
        host: 'reqres.in',
        path: '/api/users',
        queryParameters: {'page': '2'});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = res['totalItems'];
      var data = res['data'];
      print('Number of books about http: $itemCount.');
      setState(() {
        for (var user in data) {
          print(user);
          _players.add(Player(
              user: User(
                  userId: user['id'],
                  name: user['first_name'],
                  imagePath: user['avatar'],
                  introduction: '',
                  rate: 1500),
              position: 0));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget _memberList() {
    return GridView.count(
      // primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 0.9,
      // return Column(
      children: <Widget>[
        if (_players.isNotEmpty)
          for (var player in _players)
            (player.position == 0)
                ? buildRateCard(
                    player.user.imagePath,
                    player.user.name,
                    player.user.userId,
                    player.user.rate,
                  )
                : buildRageCardWidhBadge(
                    player.user.imagePath,
                    player.user.name,
                    player.user.userId,
                    player.user.rate,
                    player.position),
      ],
    );
  }

  Widget buildRageCardWidhBadge(
      String imageUrl, String title, int id, int rate, int position) {
    return Badge(
      badgeContent: (position == 1)
          ? const Text('東',
              style: TextStyle(color: Colors.white, fontFamily: 'PottaOne'))
          : (position == 2)
              ? const Text('南',
                  style: TextStyle(color: Colors.white, fontFamily: 'PottaOne'))
              : (position == 3)
                  ? const Text('西',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'PottaOne'))
                  : const Text('北',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'PottaOne')),
      position: BadgePosition.topEnd(top: 1, end: 1),
      child: buildRateCard(imageUrl, title, id, rate),
    );
  }

  // ユーザーカード
  Widget buildRateCard(String imageUrl, String title, int id, int rate) {
    return SizedBox(
      height: 500,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => {
            setState(() {
              var pushedPlayer =
                  _players.firstWhere((player) => player.user.userId == id);
              pushedPlayer.position != 0
                  ? {
                      positions.add(pushedPlayer.position),
                      pushedPlayer.position = 0,
                      positions.sort((num1, num2) => num1 - num2)
                    } // バッジ削除
                  : positions.isNotEmpty
                      ? {
                          pushedPlayer.position = positions.first,
                          positions.removeAt(0),
                          positions.sort((num1, num2) => num1 - num2)
                        } //バッジ追加
                      : pushedPlayer.position = 0; // 席がないため追加しない
            })
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      rate.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }

  Widget _main() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("対局者を選択",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
        const Text(
          "東→南→西→北の席順で選択してください。",
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        const SizedBox(
          height: 10,
        ),
        _memberList(),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          child: const Text('対局開始'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
          ),
          onPressed: positions.isNotEmpty ? null : () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }
}
