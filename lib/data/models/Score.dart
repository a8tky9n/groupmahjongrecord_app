import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/data/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class Score {
  int? scoreId;
  DateTime? createDate;
  List<double>? points;
  List<User>? users;

  Score({
    this.scoreId,
    this.createDate,
    this.points,
    this.users,
  });
  factory Score.fromJson(Map<String, dynamic> json, String docId) => Score(
        scoreId: json['scoreId'],
        createDate: (json['createDate'] as Timestamp).toDate(),
        points: json['points'].toDouble(),
        users: json['users'],
      );

  Map<String, dynamic> toJson() => {
        'scoreId': scoreId,
        'createDate': createDate,
        'points': points,
        'users': users,
      };
}
