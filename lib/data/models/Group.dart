import 'dart:convert';

class GroupDetail {
  String? id;
  String? password;
  String? text;
  DateTime? createdAt;
  String? title;
  String? image;
  DateTime? updateAt;
  List<Profiles>? profiles;

  GroupDetail(
      {this.id,
      this.password,
      this.text,
      this.createdAt,
      this.title,
      this.image,
      this.updateAt,
      this.profiles});

  GroupDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    text = json['text'];
    createdAt = DateTime.parse(json['created_at']);
    title = json['title'];
    image = json['image'];
    updateAt = DateTime.parse(json['update_at']);
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['title'] = this.title;
    data['image'] = this.image;
    data['update_at'] = this.updateAt;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  String? createdAt;
  String? id;
  DateTime? updateAt;
  String? image;
  String? user;
  bool? isActive;
  String? nickName;
  String? group;
  int? rate4;
  int? rate3;

  Profiles(
      {this.createdAt,
      this.id,
      this.updateAt,
      this.image,
      this.user,
      this.isActive,
      this.nickName,
      this.group,
      this.rate4,
      this.rate3});

  Profiles.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    updateAt = DateTime.parse(json['update_at']);
    image = json['image'];
    user = json['user'];
    isActive = json['is_active'];
    nickName = json['nick_name'];
    group = json['group'];
    rate4 = json['rate4'];
    rate3 = json['rate3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['update_at'] = this.updateAt;
    data['image'] = this.image;
    data['user'] = this.user;
    data['is_active'] = this.isActive;
    data['nick_name'] = this.nickName;
    data['group'] = this.group;
    data['rate4'] = this.rate4;
    data['rate3'] = this.rate3;
    return data;
  }
}

class Group {
  String? id;
  String? password;
  String? text;
  DateTime? createdAt;
  String? title;
  String? image;
  DateTime? updateAt;

  Group(
      {this.id,
      this.password,
      this.text,
      this.createdAt,
      this.title,
      this.image,
      this.updateAt});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    text = json['text'];
    createdAt = DateTime.parse(json['created_at']);
    title = json['title'];
    image = json['image'];
    updateAt = DateTime.parse(json['update_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['title'] = this.title;
    data['image'] = this.image;
    data['update_at'] = this.updateAt;
    return data;
  }
}
