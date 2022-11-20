class User {
  User(
      {this.userId,
      this.name,
      this.imagePath,
      this.introduction,
      this.created_at,
      this.userProfile});
  String? userId;
  String? name;
  String? imagePath;
  String? introduction;
  String? created_at;
  String? userProfile;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['id'],
        name: json['nickName'],
        imagePath: json['img'],
        introduction: json['text'],
        created_at: json['created_at'],
        userProfile: json['userProfile'],
      );

  Map<String, dynamic> toJson() => {
        'id': userId,
        'nickName': name,
        'img': imagePath,
        'text': introduction,
        'created_at': created_at,
        'userProfile': userProfile
      };
}
