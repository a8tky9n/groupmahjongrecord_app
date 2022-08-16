import 'package:flutter/material.dart';

@immutable
class UserDetail {
  final int userId;
  final String name;
  final String imagePath;
  final String introduction;
  final int rate;

  const UserDetail(
      {required this.userId,
      required this.name,
      required this.imagePath,
      required this.introduction,
      required this.rate});
}
