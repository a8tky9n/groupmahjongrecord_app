import 'package:flutter/material.dart';

@immutable
class Group {
  final int groupId;
  final String name;
  final String imagePath;
  final String introduction;
  final String passWord;

  const Group({
    required this.groupId,
    required this.name,
    required this.imagePath,
    required this.introduction,
    required this.passWord,
  });
}
