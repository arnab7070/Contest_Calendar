// To parse this JSON data, do
//
//     final Contest = ContestFromJson(jsonString);

import 'dart:convert';

List<Contest> contestFromJson(String str) =>
    List<Contest>.from(json.decode(str).map((x) => Contest.fromJson(x)));

String contestToJson(List<Contest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contest {
  Contest({
    required this.name,
    required this.url,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.site,
  });

  String name;
  String url;
  String startTime;
  String endTime;
  String duration;
  String site;

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
        name: json["name"],
        url: json["url"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        duration: json["duration"],
        site: json["site"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "start_time": startTime,
        "end_time": endTime,
        "duration": duration,
        "site": site,
      };
}
