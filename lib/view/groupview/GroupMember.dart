import 'dart:ffi';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:groupmahjongrecord/models/Group.dart';
import 'package:groupmahjongrecord/models/User.dart';
import 'package:groupmahjongrecord/models/Score.dart';

// 対戦記録画面
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
    // _getScoreList();
  }

  Widget _main() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "グループメンバー",
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }
}
