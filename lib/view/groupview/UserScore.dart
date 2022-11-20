import 'package:flutter/material.dart';
import 'package:groupmahjongrecord/data/models/User.dart';
import 'package:fl_chart/fl_chart.dart';

const gridColor = Color(0xff68739f);
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

class UserScore extends StatefulWidget {
  final User user;
  const UserScore({
    Key? key,
    required this.user,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => userScorePage();
}

class userScorePage extends State<UserScore> {
  @override
  void initState() {
    super.initState();
    // _getScoreList();
  }

  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  // ユーザーの画像と調子を表示
  Widget _userImage() {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Ink.image(
              image: NetworkImage(
                widget.user.imagePath!,
              ),
              fit: BoxFit.contain,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "流れが悪い",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                width: 100,
                child: Ink.image(
                  image: const NetworkImage(
                    "https://groupmahjongrecord.com/static/media/bad_neko.40b8e1a3.jpg",
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
              case 2:
                return const RadarChartTitle(
                  text: '平均順位',
                );
              case 1:
                return const RadarChartTitle(
                  text: '平均順位',
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
        swapAnimationDuration: const Duration(milliseconds: 400),
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
    return [
      RawDataSet(
        title: 'Fashion',
        color: fashionColor,
        values: [
          2,
          2,
          1,
          4,
          1,
        ],
      ),
    ];
  }

  Widget _main() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.user.name!,
          style: const TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _userImage(),
        const SizedBox(
          height: 20,
        ),
        _rederChart(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        // タイトルテキスト
        // title: Text('Hello'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              // crossAxisAlignment: CrossAxisAlignment.start,
              _main(),
            ]),
          ),
        ),
      ),
    );
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
