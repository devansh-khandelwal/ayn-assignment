// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  final int? fileSizeBytes;
  final String? url;

  VideoModel({
    this.fileSizeBytes,
    this.url,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        fileSizeBytes: json["fileSizeBytes"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "fileSizeBytes": fileSizeBytes,
        "url": url,
      };
}
