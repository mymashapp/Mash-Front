// To parse this JSON data, do
//
//     final otherUserModel = otherUserModelFromJson(jsonString);

import 'dart:convert';

OtherUserModel otherUserModelFromJson(String str) =>
    OtherUserModel.fromJson(json.decode(str));

String otherUserModelToJson(OtherUserModel data) => json.encode(data.toJson());

class OtherUserModel {
  OtherUserModel({
    this.success,
    this.data,
  });

  int? success;
  OtherUser? data;

  factory OtherUserModel.fromJson(Map<String, dynamic> json) => OtherUserModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : OtherUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data!.toJson(),
      };
}

class OtherUser {
  OtherUser({
    this.userId,
    this.fullName,
    this.dob,
    this.dobTimestamp,
    this.gender,
    this.pronoun,
    this.height,
    this.school,
    this.userBasicReview,
    this.userBasicMonthlyPoints,
    this.userBasicTotalPoints,
    this.userBasicExtra,
    this.vaccinationStatus,
  });

  int? userId;
  String? fullName;
  DateTime? dob;
  int? dobTimestamp;
  String? gender;
  String? pronoun;
  dynamic height;
  String? school;
  int? userBasicReview;
  int? userBasicMonthlyPoints;
  int? userBasicTotalPoints;
  UserBasicExtra? userBasicExtra;
  int? vaccinationStatus;

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        dobTimestamp:
            json["dob_timestamp"] == null ? null : json["dob_timestamp"],
        gender: json["gender"] == null ? null : json["gender"],
        pronoun: json["pronoun"],
        height: json["height"],
        school: json["school"],
        userBasicReview: json["user_basic_review"] == null
            ? null
            : json["user_basic_review"],
        userBasicMonthlyPoints: json["user_basic_monthly_points"] == null
            ? null
            : json["user_basic_monthly_points"],
        userBasicTotalPoints: json["user_basic_total_points"] == null
            ? null
            : json["user_basic_total_points"],
        userBasicExtra: json["user_basic_extra"] == null
            ? null
            : UserBasicExtra.fromJson(json["user_basic_extra"]),
        vaccinationStatus: json["vaccination_status"] == null
            ? null
            : json["vaccination_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "dob": dob == null ? null : dob!.toIso8601String(),
        "dob_timestamp": dobTimestamp == null ? null : dobTimestamp,
        "gender": gender == null ? null : gender,
        "pronoun": pronoun,
        "height": height,
        "school": school,
        "user_basic_review": userBasicReview == null ? null : userBasicReview,
        "user_basic_monthly_points":
            userBasicMonthlyPoints == null ? null : userBasicMonthlyPoints,
        "user_basic_total_points":
            userBasicTotalPoints == null ? null : userBasicTotalPoints,
        "user_basic_extra":
            userBasicExtra == null ? null : userBasicExtra!.toJson(),
        "vaccination_status":
            vaccinationStatus == null ? null : vaccinationStatus,
      };
}

class UserBasicExtra {
  UserBasicExtra({
    this.location,
    this.interests,
  });

  String? location;
  List<String>? interests;

  factory UserBasicExtra.fromJson(Map<String, dynamic> json) => UserBasicExtra(
        location: json["location"] == null ? null : json["location"],
        interests: json["interests"] == null
            ? null
            : List<String>.from(json["interests"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location,
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests!.map((x) => x)),
      };
}
