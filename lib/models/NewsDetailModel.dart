// ignore_for_file: file_names

import 'dart:convert';

NewsDetailModel newsDetailModelFromJson(String str) => NewsDetailModel.fromJson(json.decode(str));

String newsDetailModelToJson(NewsDetailModel data) => json.encode(data.toJson());

class NewsDetailModel {
    NewsDetailModel({
        required this.id,
        required this.topic,
        required this.detail,
        required this.imageurl,
        required this.linkurl,
        required this.createdAt,
        required this.status,
    });

    String id;
    String topic;
    String detail;
    String imageurl;
    String linkurl;
    DateTime createdAt;
    String status;

    factory NewsDetailModel.fromJson(Map<String, dynamic> json) => NewsDetailModel(
        id: json["id"],
        topic: json["topic"],
        detail: json["detail"],
        imageurl: json["imageurl"],
        linkurl: json["linkurl"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "detail": detail,
        "imageurl": imageurl,
        "linkurl": linkurl,
        "created_at": createdAt.toIso8601String(),
        "status": status,
    };
}