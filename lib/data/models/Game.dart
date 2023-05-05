class Game {
  DateTime? createdAt;
  bool? isSanma;
  String? creater;
  DateTime? updateAt;
  String? id;
  String? groupId;
  String? updater;
  List<GameResults>? gameResults;

  Game(
      {this.createdAt,
      this.isSanma,
      this.creater,
      this.updateAt,
      this.id,
      this.groupId,
      this.updater,
      this.gameResults});

  Game.fromJson(Map<String, dynamic> json) {
    createdAt = DateTime.parse(json['created_at']);
    isSanma = json['is_sanma'];
    creater = json['creater'];
    updateAt = DateTime.parse(json['update_at']);
    id = json['id'];
    groupId = json['group_id'];
    updater = json['updater'];
    if (json['game_results'] != null) {
      gameResults = <GameResults>[];
      json['game_results'].forEach((v) {
        gameResults!.add(new GameResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['is_sanma'] = this.isSanma;
    data['creater'] = this.creater;
    data['update_at'] = this.updateAt;
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['updater'] = this.updater;
    if (this.gameResults != null) {
      data['game_results'] = this.gameResults!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GameResults {
  DateTime? createdAt;
  int? rank;
  String? game;
  double? score;
  String? id;
  DateTime? updateAt;
  String? profile;

  GameResults(
      {this.createdAt,
      this.rank,
      this.game,
      this.score,
      this.id,
      this.updateAt,
      this.profile});

  GameResults.fromJson(Map<String, dynamic> json) {
    createdAt = DateTime.parse(json['created_at']);
    rank = json['rank'];
    game = json['game'];
    score = json['score'].toDouble();
    id = json['id'];
    updateAt = DateTime.parse(json['update_at']);
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['rank'] = this.rank;
    data['game'] = this.game;
    data['score'] = this.score;
    data['id'] = this.id;
    data['update_at'] = this.updateAt;
    data['profile'] = this.profile;
    return data;
  }
}
