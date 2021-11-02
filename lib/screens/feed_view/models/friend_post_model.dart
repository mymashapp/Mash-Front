// To parse this JSON data, do
//
//     final friendPostModel = friendPostModelFromJson(jsonString);

import 'dart:convert';

import 'package:mash/screens/feed_view/models/post_model.dart';

FriendPostModel friendPostModelFromJson(String str) =>
    FriendPostModel.fromJson(json.decode(str));

String friendPostModelToJson(FriendPostModel data) =>
    json.encode(data.toJson());

class FriendPostModel {
  FriendPostModel(
      {this.comments,
      this.lastComment,
      this.likeCount,
      this.likes,
      this.uploadeAt,
      this.reports});

  Map<String, Comment>? comments;
  String? lastComment;
  int? likeCount;
  Map<dynamic, dynamic>? likes;
  Map<String, Report>? reports;

  int? uploadeAt;

  factory FriendPostModel.fromJson(Map<String, dynamic> json) =>
      FriendPostModel(
        comments: json["comments"] == null
            ? null
            : Map.from(json["comments"]).map(
                (k, v) => MapEntry<String, Comment>(k, Comment.fromJson(v))),
        lastComment: json["last_comment"],
        likeCount: json["like_count"],
        likes: json["likes"] == null
            ? null
            : Map.from(json["likes"])
                .map((k, v) => MapEntry<dynamic, dynamic>(k, v)),
        uploadeAt: json["uploade_at"],
        reports: json["reports"] == null
            ? null
            : Map.from(json["reports"])
                .map((k, v) => MapEntry<String, Report>(k, Report.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "comments": Map.from(comments!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "last_comment": lastComment,
        "like_count": likeCount,
        "likes":
            Map.from(likes!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "uploade_at": uploadeAt,
      };
}
