import 'dart:convert';
import 'package:groupmahjongrecord/view/groupview/UserScore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:groupmahjongrecord/models/Group.dart';
import 'package:groupmahjongrecord/models/User.dart';
import 'package:groupmahjongrecord/components/UserCard.dart';

// メンバー一覧画面
class GroupMember extends StatefulWidget {
  final Group group;
  final User user;
  const GroupMember({
    Key? key,
    required this.group,
    required this.user,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => groupMemberPage();
}

class groupMemberPage extends State<GroupMember> {
  @override
  void initState() {
    super.initState();
    _getMemberList();
  }

  var _user = <User>{};

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
          _user.add(
            User(
                userId: user['id'],
                name: user['first_name'],
                imagePath: user['avatar'],
                introduction: '',
                rate: 1500),
          );
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
      childAspectRatio: 0.85,
      // return Column(
      children: <Widget>[
        if (_user.isNotEmpty)
          for (var user in _user)
            buildRateCard(user.imagePath, user.name, user.userId, user.rate),
      ],
    );
  }

  // ユーザーカード
  Widget buildRateCard(String imageUrl, String title, int id, int rate) {
    return SizedBox(
      height: 500,
      child: UserCard(
        imgPath: imageUrl,
        userName: title,
        userRate: rate,
        OnTapCallback: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserScore(
                user: _user.where((user) => user.userId == id).first,
              ),
            ),
          ),
        },
      ),
    );
  }

  Widget _main() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "グループメンバー",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _memberList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }
}
