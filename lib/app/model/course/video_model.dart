import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  Videos? videos;

  VideoModel({
    this.videos,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
  );

  Map<String, dynamic> toJson() => {
    "videos": videos?.toJson(),
  };
}

class Videos {
  List<Day>? day0;
  List<Day>? day1;
  List<Day>? day2;

  Videos({
    this.day0,
    this.day1,
    this.day2,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    day0: json["day0"] == null ? [] : List<Day>.from(json["day0"]!.map((x) => Day.fromJson(x))),
    day1: json["day1"] == null ? [] : List<Day>.from(json["day1"]!.map((x) => Day.fromJson(x))),
    day2: json["day2"] == null ? [] : List<Day>.from(json["day2"]!.map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day0": day0 == null ? [] : List<dynamic>.from(day0!.map((x) => x.toJson())),
    "day1": day1 == null ? [] : List<dynamic>.from(day1!.map((x) => x.toJson())),
    "day2": day2 == null ? [] : List<dynamic>.from(day2!.map((x) => x.toJson())),
  };
}

class Day {
  int? id;
  String? title;
  String? description;
  int? courseId;
  String? link;

  Day({
    this.id,
    this.title,
    this.description,
    this.courseId,
    this.link,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    courseId: json["course_id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "course_id": courseId,
    "link": link,
  };
}
