// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.comments,
    this.likeCount,
    this.id,
    this.desc,
    this.userId,
    this.imgUrl,
    this.likes,
    this.timestamp,
    this.reports,
    this.userName,
  });

  Map<String, Comment>? comments;
  int? likeCount;
  String? id;
  String? desc;
  int? userId;
  String? imgUrl;
  Map<dynamic, dynamic>? likes;
  Map<String, Report>? reports;
  int? timestamp;
  String? userName;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        comments: json["comments"] == null
            ? null
            : Map.from(json["comments"]).map(
                (k, v) => MapEntry<String, Comment>(k, Comment.fromJson(v))),
        likeCount: json["like_count"] == null ? null : json["like_count"],
        id: json["id"] == null ? null : json["id"],
        desc: json["desc"] == null ? null : json["desc"],
        userId: json["user_id"] == null ? null : json["user_id"],
        imgUrl: json["img_url"] == null ? null : json["img_url"],
        likes: json["likes"] == null
            ? null
            : Map.from(json["likes"])
                .map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
        reports: json["reports"] == null
            ? null
            : Map.from(json["reports"])
                .map((k, v) => MapEntry<String, Report>(k, Report.fromJson(v))),
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        userName: json["user_name"] == null ? null : json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "comments": comments == null
            ? null
            : Map.from(comments!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "like_count": likeCount == null ? null : likeCount,
        "id": id == null ? null : id,
        "desc": desc == null ? null : desc,
        "user_id": userId == null ? null : userId,
        "img_url": imgUrl == null ? null : imgUrl,
        "likes": likes == null ? null : likes,
        "timestamp": timestamp == null ? null : timestamp,
        "user_name": userName == null ? null : userName,
      };
}

class Comment {
  Comment({
    this.userId,
    this.userName,
    this.text,
    this.timestamp,
  });

  String? userId;
  String? userName;
  String? text;
  int? timestamp;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        text: json["text"] == null ? null : json["text"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "text": text == null ? null : text,
        "timestamp": timestamp == null ? null : timestamp,
      };
}

class Report {
  Report({
    this.reason,
    this.timestamp,
  });

  String? reason;
  int? timestamp;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        reason: json["reason"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "timestamp": timestamp,
      };
}
