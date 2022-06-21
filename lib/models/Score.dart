import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/models/User.dart';

@immutable
class Score {
  final int scoreId;
  final DateTime createDate;
  final List<int> points;
  final List<User> users;

  const Score({
    required this.scoreId,
    required this.createDate,
    required this.points,
    required this.users,
  });
}
