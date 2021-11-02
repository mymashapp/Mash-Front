// To parse this JSON data, do
//
//     final leaderboardUsers = leaderboardUsersFromJson(jsonString);

import 'dart:convert';

LeaderboardUsers leaderboardUsersFromJson(String str) =>
    LeaderboardUsers.fromJson(json.decode(str));

String leaderboardUsersToJson(LeaderboardUsers data) =>
    json.encode(data.toJson());

class LeaderboardUsers {
  LeaderboardUsers({
    this.success,
    this.data,
  });

  int? success;
  List<LUser>? data;

  factory LeaderboardUsers.fromJson(Map<String, dynamic> json) =>
      LeaderboardUsers(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<LUser>.from(json["data"].map((x) => LUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class LUser {
  LUser({
    this.fullName,
    this.userId,
    this.userBasicMonthlyPoints,
    this.userBasicTotalPoints,
  });

  String? fullName;
  int? userId;
  int? userBasicMonthlyPoints;
  int? userBasicTotalPoints;

  factory LUser.fromJson(Map<String, dynamic> json) => LUser(
        fullName: json["full_name"] == null ? null : json["full_name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userBasicMonthlyPoints: json["user_basic_monthly_points"] == null
            ? null
            : json["user_basic_monthly_points"],
        userBasicTotalPoints: json["user_basic_total_points"] == null
            ? null
            : json["user_basic_total_points"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName == null ? null : fullName,
        "user_id": userId == null ? null : userId,
        "user_basic_monthly_points":
            userBasicMonthlyPoints == null ? null : userBasicMonthlyPoints,
        "user_basic_total_points":
            userBasicTotalPoints == null ? null : userBasicTotalPoints,
      };
}
