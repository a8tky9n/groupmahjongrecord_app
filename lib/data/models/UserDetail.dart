import 'package:flutter/material.dart';

@immutable
class UserDetail {
  String? userId;
  String? group_id;
  String? name;
  String? imagePath;
  String? introduction;
  int? rate;
  bool? isActive;
  String? rate_id;
  String? userProfile;
  String? create_at;

  UserDetail(
      {this.userId,
      this.group_id,
      this.name,
      this.imagePath,
      this.introduction,
      this.rate,
      this.rate_id,
      this.isActive,
      this.userProfile,
      this.create_at});

  factory UserDetail.fromJson(Map<String, dynamic> json, String docId) =>
      UserDetail(
        userId: json['userId'],
        group_id: json['group_id'],
        name: json['name'],
        imagePath: json['imagePath'],
        introduction: json['introduction'],
        rate: json['rate'],
        rate_id: json['rate_id'],
        isActive: json['isActive'],
        userProfile: json['userProfile'],
        create_at: json['create_at'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'group_id': group_id,
        'name': name,
        'imagePath': imagePath,
        'introduction': introduction,
        'rate': rate,
        'rate_id': rate_id,
        'isActive': isActive,
        'userProfile': userProfile,
        'create_at': create_at,
      };
}
