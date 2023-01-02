import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/data/models/Game.dart';
import 'package:groupmahjongrecord/data/models/Group.dart';
import 'package:groupmahjongrecord/data/models/LoginUser.dart';
import 'package:groupmahjongrecord/data/models/UserScore.dart';
import 'package:groupmahjongrecord/data/provider/server_repository_provider.dart';
import 'package:groupmahjongrecord/data/repository/server_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:groupmahjongrecord/data/repository/auth_repository.dart';
import 'package:groupmahjongrecord/data/provider/auth_repository_provider.dart';
import 'package:uuid/uuid.dart';

final groupViewModelProvider =
    ChangeNotifierProvider.autoDispose<GroupViewModel>((ref) => GroupViewModel(
        repository: ref.read(serverRepositoryProvider),
        auth: ref.read(authRepositoryProvider)));

class GroupViewModel extends ChangeNotifier {
  GroupViewModel({required repository, required auth})
      : _repository = repository,
        _authRepository = auth;

  final AuthRepository _authRepository;
  final ServerRepository _repository;
  GroupDetail? groupDetail;
  List<Game>? games;
  List<Player>? players;
  // ユーザー情報
  LoginUser? loginUser;
  File? newProfileImage;
  String detailId = '';
  int selectedIndex = 0;
  var playerDetailScores = <UserScore>[];

  DateTime? startDate;
  DateTime? endDate;
  DateTime? recordDateTime;

  var positions = [1, 2, 3, 4];
  List<double> scores = [0, 0, 0, 0];
  bool scoreIsValid = false;
  int aggregatedRate = 50;
  int horseRate = 5;
  // ユーザー情報取得
  Future<void> getLoginUser(VoidCallback onFailed) async {
    loginUser = await _repository.getMe();
    if (loginUser == null) {
      onFailed();
    }
    notifyListeners();
  }

  //グループ情報取得
  Future<void> getGroup(String groupId) async {
    var res = await _repository.getGroup(groupId);
    if (res != null) {
      groupDetail = GroupDetail.fromJson(res[0] as Map<String, dynamic>);
      players = <Player>[];
      for (var v in groupDetail!.profiles!) {
        players!.add(Player(user: v));
      }
      games = <Game>[];
      res[1]['Games'].forEach((v) {
        games!.add(Game.fromJson(v));
      });

      games!.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      createDetailUserScore();
      notifyListeners();
    }
  }

  // サインアウト
  Future<void> signOut() {
    return _authRepository.signOut();
  }

  // プレイヤーを選択
  void selectPlayer(String id) {
    var editPlayer = players!.firstWhere((player) => player.user.id == id);
    editPlayer.position != 0
        ? {
            positions.add(editPlayer.position),
            editPlayer.position = 0,
            positions.sort((num1, num2) => num1 - num2)
          } // バッジ削除
        : positions.isNotEmpty
            ? {
                editPlayer.position = positions.first,
                positions.removeAt(0),
                positions.sort((num1, num2) => num1 - num2)
              } //バッジ追加
            : editPlayer.position = 0; // 席がないため追加しない
    notifyListeners();
  }

  void createDetailUserScore() {
    playerDetailScores.clear();
    log("ユーザーの成績作成");
    for (Game game in games!) {
      if (startDate != null && endDate != null) {
        if (game.createdAt!.compareTo(endDate!) > 0 ||
            game.createdAt!.compareTo(startDate!) < 0) {
          //範囲外の時は何もしない

          log("範囲外のためスキップ");
          continue;
        }
      }
      for (GameResults result in game.gameResults!) {
        var index = playerDetailScores
            .indexWhere((score) => score.id == result.profile);
        if (index == -1) {
          UserScore score = UserScore(
              id: result.profile,
              rate: 1500,
              totalScore: 0,
              averageScore: 0,
              averageRank: 0,
              first: 0,
              second: 0,
              third: 0,
              forth: 0,
              totalGameCount: 0,
              topAverage: 0,
              avoidButtomAverage: 0,
              plusAverage: 0);
          index = playerDetailScores.length;
          playerDetailScores.add(score);
        }
        UserScore score = playerDetailScores[index];
        score.totalGameCount = score.totalGameCount! + 1;
        score.totalScore = score.totalScore! + result.score!;
        switch (result.rank!) {
          case 1:
            score.first = score.first! + 1;
            break;
          case 2:
            score.second = score.second! + 1;
            break;
          case 3:
            score.third = score.third! + 1;
            break;
          case 4:
            score.forth = score.forth! + 1;
            break;
        }
      }
    }
    for (UserScore score in playerDetailScores) {
      score.averageRank = (score.first! +
              (score.second! * 2) +
              (score.third! * 3) +
              (score.forth! * 4)) /
          score.totalGameCount!;
      score.averageScore = score.totalScore! / score.totalGameCount!;
      score.topAverage = score.first! / score.totalGameCount! * 100.0;
      score.plusAverage =
          (score.first! + score.second!) / score.totalGameCount! * 100.0;
      score.avoidButtomAverage = (score.first! + score.second! + score.third!) /
          score.totalGameCount! *
          100.0;
    }

    log("作成完了:" + playerDetailScores.length.toString());
    notifyListeners();
  }

  // 範囲の始まり設定
  void setStartDate(DateTime time) {
    log("範囲設定先頭");
    startDate = time;
    log(startDate.toString());
    createDetailUserScore();
  }

  // 範囲の終わり設定
  void setEndDate(DateTime time) {
    log("範囲設定末尾");
    endDate = time;
    endDate = endDate?.add(const Duration(
        hours: 23,
        minutes: 59,
        seconds: 59,
        milliseconds: 999,
        microseconds: 999));

    log(endDate.toString());
    createDetailUserScore();
  }

  void setRecordDateTime(DateTime time) {
    recordDateTime = time;
    createDetailUserScore();
  }

  // 詳細ユーザー設定
  void setDetailUserId(String userId) {
    detailId = userId;

    notifyListeners();
  }

  // タブ切り替え
  void changeTab(int tab) {
    selectedIndex = tab;
    detailId = '';
    notifyListeners();
  }

  // 成績を設定する
  void setScore(int position, double value) {
    scores[position] = value;
    double sum = 0;
    for (double score in scores) {
      sum += score;
    }
    if (sum != 0) {
      scoreIsValid = true;
    } else {
      scoreIsValid = false;
    }
    notifyListeners();
  }

  // ゲーム登録
  Future<void> registerGame() async {
    var uuid = Uuid();
    var gameId = uuid.v4();
    var json = {
      'is_sanma': false,
      'group_id': groupDetail!.id,
      'game_results': [
        {
          "rank": 1,
          "score": scores[0] + horseRate * 2,
          "game": gameId,
          "profile": players!.firstWhere((p) => p.position == 1).user.id
        },
        {
          "rank": 2,
          "score": scores[1] + horseRate,
          "game": gameId,
          "profile": players!.firstWhere((p) => p.position == 2).user.id
        },
        {
          "rank": 3,
          "score": scores[2] - horseRate,
          "game": gameId,
          "profile": players!.firstWhere((p) => p.position == 3).user.id
        },
        {
          "rank": 4,
          "score": scores[3] - horseRate * 2,
          "game": gameId,
          "profile": players!.firstWhere((p) => p.position == 4).user.id
        }
      ],
    };
    log("記録Post");
    await _repository.createGame(json);
    log("記録Post完了");
    scores = [0, 0, 0, 0];
    positions = [1, 2, 3, 4];
    for (var player in players!) {
      player.position = 0;
    }
    getGroup(groupDetail!.id!);
    notifyListeners();
  }

  // 黒川レートの設定
  void setAggregatedRate(int value) {
    aggregatedRate = value;
    notifyListeners();
  }

  // プロフィール画像設定
  void setNewProfileImage(File? value) {
    newProfileImage = value;
    notifyListeners();
  }
}

// 対局開始用のユーザークラス
class Player {
  final Profiles user;
  int position;
  Player({required this.user, this.position = 0});
}
