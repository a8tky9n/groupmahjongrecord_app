class Group {
  String? id;
  String? password;
  String? text;
  String? createdAt;
  String? title;
  String? image;
  String? updateAt;

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
    createdAt = json['created_at'];
    title = json['title'];
    image = json['image'];
    updateAt = json['update_at'];
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
