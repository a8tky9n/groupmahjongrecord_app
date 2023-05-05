class Schedule {
  DateTime? scheduleStart;
  DateTime? scheduleEnd;
  String? title;
  String? text;
  String? createUser;
  List<UserSchedule>? userSchedules;

  Schedule({
    this.scheduleStart,
    this.scheduleEnd,
    this.title,
    this.text,
    this.createUser,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    scheduleStart = DateTime.parse(json['schedule_start']);
    scheduleEnd = DateTime.parse(json['schedule_end']);
    title = json['title'];
    text = json['text'];
    createUser = json['create_user'];
    if (json['user_schedules'] != null) {
      userSchedules = <UserSchedule>[];
      json['user_schedules'].forEach((v) {
        userSchedules!.add(new UserSchedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_start'] = this.scheduleStart;
    data['schedule_end'] = this.scheduleEnd;
    data['title'] = this.title;
    data['text'] = this.text;
    data['create_user'] = this.createUser;
    if (this.userSchedules != null) {
      data['user_schedules'] =
          this.userSchedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserSchedule {
  DateTime? scheduleDate;
  String? id;
  int? status;

  UserSchedule({
    this.scheduleDate,
    this.id,
    this.status,
  });

  UserSchedule.fromJson(Map<String, dynamic> json) {
    scheduleDate = DateTime.parse(json['schedule_date']);
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_date'] = this.scheduleDate;
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
