import 'package:groupmahjongrecord/data/models/Group.dart';
import 'dart:convert';

class LoginUser {
  LoginUser(
      {this.nickName,
      this.image,
      this.rank1,
      this.rank2,
      this.rank3,
      this.rank4,
      this.score,
      this.gameCnt,
      this.group});

  String? nickName;
  String? image;
  int? rank1;
  int? rank2;
  int? rank3;
  int? rank4;
  int? score;
  int? gameCnt;
  List<Group>? group;

  LoginUser.fromJson(Map<String, dynamic> json) {
    nickName = json['nick_name'];
    image = json['image'];
    rank1 = json['rank1'];
    rank2 = json['rank2'];
    rank3 = json['rank3'];
    rank4 = json['rank4'];
    score = json['score'];
    gameCnt = json['game_cnt'];
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(new Group.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nick_name'] = this.nickName;
    data['image'] = this.image;
    data['rank1'] = this.rank1;
    data['rank2'] = this.rank2;
    data['rank3'] = this.rank3;
    data['rank4'] = this.rank4;
    data['score'] = this.score;
    data['game_cnt'] = this.gameCnt;
    if (this.group != null) {
      data['group'] = this.group!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
