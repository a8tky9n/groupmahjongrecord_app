import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/data/models/UserScore.dart';
import 'package:groupmahjongrecord/ui/groupTop/group_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

const gridColor = Color(0xff68739f);
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

class MemberDetail extends ConsumerStatefulWidget {
  const MemberDetail({Key? key}) : super(key: key);

  @override
  MemberDetailState createState() => MemberDetailState();
}

class MemberDetailState extends ConsumerState<MemberDetail> {
  @override
  void initState() {
    super.initState();
  }

  List<String> catMsg = ["最高！！！", "調子はヨシ！", "普通...", "流れが悪い"];
  List<String> catImg = [
    "https://groupmahjongrecord.com/static/media/good_neko.b50127f7.jpg",
    "https://groupmahjongrecord.com/static/media/yosi_neko.9e482296.jpg",
    "https://groupmahjongrecord.com/static/media/nomal_neko.644f98c3.jpg",
    "https://groupmahjongrecord.com/static/media/bad_neko.40b8e1a3.jpg"
  ];
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  // ユーザーの画像と調子を表示
  Widget _userImage(Player? player) {
    var games = ref.watch(groupViewModelProvider).games;
    int index = 0;
    double average = 0;
    for (var game in games!) {
      var result = game.gameResults!.firstWhere(
          (res) => res.profile == ref.watch(groupViewModelProvider).detailId);
      if (result != null) {
        average += result.rank!;
        index++;
      }
      if (index == 4) {
        break;
      }
    }
    average /= index;
    int itemIndex = average < 2.1
        ? 1
        : average <= 2.3
            ? 2
            : average <= 2.5
                ? 3
                : 4;
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Container(
              child: player == null ||
                      player.user.image == null ||
                      player.user.image!.isEmpty
                  ? Image.asset(
                      'assets/no_image_square.jpeg',
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      player.user.image!,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                catMsg[itemIndex],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                width: 100,
                child: Ink.image(
                  image: NetworkImage(
                    catImg[itemIndex],
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      var index = entry.key;
      var rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        // Optional
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    UserScore score = ref
        .watch(groupViewModelProvider)
        .playerDetailScores
        .firstWhere((s) => s.id == ref.watch(groupViewModelProvider).detailId);
    return [
      RawDataSet(
        title: 'Fashion',
        color: fashionColor,
        values: [
          // 平均スコア
          score.averageScore! >= 10
              ? 4
              : score.averageScore! > 0
                  ? 3
                  : score.averageScore! > -10
                      ? 2
                      : 1,
          // 平均着順
          score.averageRank! <= 2.3
              ? 4
              : score.averageRank! < 2.5
                  ? 3
                  : score.averageRank! < 2.7
                      ? 2
                      : 1,
          //　トップ率
          score.topAverage! >= 30
              ? 4
              : score.topAverage! > 25
                  ? 3
                  : score.topAverage! > 20
                      ? 2
                      : 1,
          // ラス回避率
          score.avoidButtomAverage! >= 80
              ? 4
              : score.avoidButtomAverage! > 75
                  ? 3
                  : score.avoidButtomAverage! > 70
                      ? 2
                      : 1,
          // 連対率
          score.plusAverage! >= 60
              ? 4
              : score.plusAverage! > 55
                  ? 3
                  : score.plusAverage! > 50
                      ? 2
                      : 1,
        ],
      ),
    ];
  }

  Widget _rederChart() {
    return SizedBox(
      width: 300,
      height: 300,
      child: RadarChart(
        RadarChartData(
          radarTouchData:
              RadarTouchData(touchCallback: (FlTouchEvent event, response) {
            if (!event.isInterestedForInteractions) {
              setState(() {
                selectedDataSetIndex = -1;
              });
              return;
            }
            setState(() {
              selectedDataSetIndex =
                  response?.touchedSpot?.touchedDataSetIndex ?? -1;
            });
          }),
          dataSets: showingDataSets(),
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          radarShape: RadarShape.polygon,
          radarBorderData: const BorderSide(color: gridColor),
          titlePositionPercentageOffset: 0.2,
          titleTextStyle: const TextStyle(color: titleColor, fontSize: 14),
          getTitle: (index, angle) {
            final usedAngle =
                relativeAngleMode ? angle + angleValue : angleValue;
            switch (index) {
              case 0:
                return const RadarChartTitle(
                  text: '平均スコア',
                );
              case 1:
                return const RadarChartTitle(
                  text: '平均順位',
                );
              case 2:
                return const RadarChartTitle(
                  text: 'トップ率',
                );
              case 3:
                return const RadarChartTitle(
                  text: 'ラス回避率',
                );
              case 4:
                return const RadarChartTitle(
                  text: '連帯率',
                );
              default:
                return const RadarChartTitle(text: '');
            }
          },
          tickCount: 3,
          ticksTextStyle:
              const TextStyle(color: Colors.transparent, fontSize: 10),
          tickBorderData: const BorderSide(color: gridColor),
          gridBorderData: const BorderSide(color: gridColor, width: 2),
        ),
        swapAnimationCurve: Curves.linear, // Optional
        swapAnimationDuration: const Duration(milliseconds: 150),
      ),
    );
  }

  Widget _lineChart() {
    var provider = ref.watch(groupViewModelProvider);
    var games = provider.games!;
    int index = 0;
    List<int> RankArray = <int>[];
    for (var game in games) {
      var result = game.gameResults!.firstWhere(
          (res) => res.profile == ref.watch(groupViewModelProvider).detailId);
      if (result != null) {
        RankArray.add(result.rank!);
        index++;
      }
      if (index == 7) {
        break;
      }
    }
    return SizedBox(
        width: 300,
        height: 150,
        child: LineChart(LineChartData(
          backgroundColor: Colors.grey[200],
          minY: 1,
          maxY: 4,
          lineBarsData: [
            LineChartBarData(
              color: Colors.red[400],
              barWidth: 3,
              dotData: FlDotData(show: true),
              spots: [
                for (int i = 0; i < RankArray.length; i++)
                  FlSpot(i + 1, ((RankArray[i] - 4).abs() + 1).toDouble()),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: _bottomTitles),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        )));
  }

  // タイトル
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 4:
              text = '1位';
              break;
            case 3:
              text = '2位';
              break;
            case 2:
              text = '3位';
              break;
            case 1:
              text = '4位';
              break;
          }

          return Text(
            text,
            style: const TextStyle(fontSize: 12),
          );
        },
      );

  Widget _info() {
    var detailScore =
        ref.watch(groupViewModelProvider).playerDetailScores.firstWhere(
              (s) => s.id == ref.watch(groupViewModelProvider).detailId,
            );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            SizedBox(width: 80, child: Center(child: Text("対局数"))),
            SizedBox(width: 80, child: Center(child: Text("合計スコア"))),
            SizedBox(width: 80, child: Center(child: Text("平均スコア"))),
            // Text("合計スコア"),
            // Text("平均スコア"),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    detailScore.totalGameCount!.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    detailScore.totalScore!.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  detailScore.averageScore!.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(width: 300, child: Divider()),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
          SizedBox(width: 80, child: Center(child: Text("平均順位"))),
          SizedBox(width: 30, child: Center(child: Text("1位"))),
          SizedBox(width: 30, child: Center(child: Text("2位"))),
          SizedBox(width: 30, child: Center(child: Text("3位"))),
          SizedBox(width: 30, child: Center(child: Text("4位"))),
        ]),
        const SizedBox(
          height: 15,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                detailScore.averageRank!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                detailScore.first!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                detailScore.second!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                detailScore.third!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                detailScore.forth!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(width: 300, child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            SizedBox(
              width: 80,
              child: Center(
                child: Text("トップ率"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("ラス回避率"),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text("連対率"),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  detailScore.topAverage!.toString() + '%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  detailScore.avoidButtomAverage!.toString() + '%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  detailScore.plusAverage!.toString() + '%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _main() {
    var provider = ref.watch(groupViewModelProvider);
    Player? targetPlayer;
    if (provider.players != null && provider.players!.isNotEmpty) {
      targetPlayer = provider.players!
          .firstWhere((player) => player.user.id == provider.detailId);
    }
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          targetPlayer != null &&
                  targetPlayer.user.nickName != null &&
                  targetPlayer.user.nickName!.isNotEmpty
              ? targetPlayer.user.nickName!
              : "プレイヤー",
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _userImage(targetPlayer),
        const SizedBox(
          height: 20,
        ),
        // 一言 モデルにないためプレイヤー名を表示
        Text(
          targetPlayer != null &&
                  targetPlayer.user.nickName != null &&
                  targetPlayer.user.nickName!.isNotEmpty
              ? targetPlayer.user.nickName!
              : "プレイヤー",
        ),
        const SizedBox(
          height: 20,
        ),
        _rederChart(),
        const SizedBox(
          height: 20,
        ),
        _lineChart(),
        const SizedBox(
          height: 20,
        ),
        _info(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _main();
  }
}

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}
