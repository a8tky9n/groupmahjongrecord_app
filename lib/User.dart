import 'package:flutter/material.dart';

@immutable
class User {
  final int userId;
  final String name;
  final String imagePath;
  final String introduction;
  final String passWord;

  const User({
    required this.userId,
    required this.name,
    required this.imagePath,
    required this.introduction,
    required this.passWord,
  });
}
