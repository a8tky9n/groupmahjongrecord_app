class UserScore {
  String? id;
  int? rate;
  double? totalScore;
  double? averageScore;
  double? averageRank;
  int? first;
  int? second;
  int? third;
  int? forth;
  int? totalGameCount;
  double? topAverage;
  double? avoidButtomAverage;
  double? plusAverage;

  UserScore(
      {this.id,
      this.rate,
      this.totalScore,
      this.averageScore,
      this.averageRank,
      this.first,
      this.second,
      this.third,
      this.forth,
      this.totalGameCount,
      this.topAverage,
      this.avoidButtomAverage,
      this.plusAverage});

  UserScore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    totalScore = json['totalScore'];
    averageScore = json['averageScore'];
    averageRank = json['averageRank'];
    first = json['first'];
    second = json['second'];
    third = json['third'];
    forth = json['forth'];
    totalGameCount = json['totalGameCount'];
    topAverage = json['topAverage'];
    avoidButtomAverage = json['avoidButtomAverage'];
    plusAverage = json['plusAverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['totalScore'] = this.totalScore;
    data['averageScore'] = this.averageScore;
    data['averageRank'] = this.averageRank;
    data['first'] = this.first;
    data['second'] = this.second;
    data['third'] = this.third;
    data['forth'] = this.forth;
    data['totalGameCount'] = this.totalGameCount;
    data['topAverage'] = this.topAverage;
    data['avoidButtomAverage'] = this.avoidButtomAverage;
    data['plusAverage'] = this.plusAverage;
    return data;
  }
}
