// To parse this JSON data, do
//
//     final videoModel2 = videoModel2FromJson(jsonString);

import 'dart:convert';

VideoModel2 videoModel2FromJson(String str) => VideoModel2.fromJson(json.decode(str));

String videoModel2ToJson(VideoModel2 data) => json.encode(data.toJson());

class VideoModel2 {
  List<Video>? videos;

  VideoModel2({
    this.videos,
  });

  factory VideoModel2.fromJson(Map<String, dynamic> json) => VideoModel2(
    videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}

class Video {
  int? dayNo;
  int? id;
  String? title;
  String? description;
  int? courseId;
  String? link;

  Video({
    this.dayNo,
    this.id,
    this.title,
    this.description,
    this.courseId,
    this.link,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    dayNo: json["day_no"],
    id: json["id"],
    title: json["title"],
    description: json["description"],
    courseId: json["course_id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "day_no": dayNo,
    "id": id,
    "title": title,
    "description": description,
    "course_id": courseId,
    "link": link,
  };
}
