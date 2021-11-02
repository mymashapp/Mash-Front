// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.user,
  });

  APIUser? user;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        user: json["user"] == null ? null : APIUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
      };
}

class APIUser {
  APIUser({
    this.userId,
    this.fullName,
    this.dob,
    this.dobTimestamp,
    this.email,
    this.phone,
    this.gender,
    this.pronoun,
    this.height,
    this.school,
    this.editedOn,
    this.showLocation,
    this.userBasicId,
    this.userBasicUserId,
    this.userBasicPremiumStauts,
    this.userBasicReview,
    this.userBasicMonthlyPoints,
    this.userBasicTotalPoints,
    this.userBasicExtra,
    this.vaccinationStatus,
    this.userPrefId,
    this.userPrefUserId,
    this.distance,
    this.minAge,
    this.maxAge,
    this.genederPre,
    this.userPrefEditedOn,
    this.iat,
  });

  int? userId;
  String? fullName;
  DateTime? dob;
  int? dobTimestamp;
  String? email;
  int? phone;
  String? gender;
  String? pronoun;
  double? height;
  String? school;
  int? editedOn;
  int? showLocation;
  int? userBasicId;
  int? userBasicUserId;
  int? userBasicPremiumStauts;
  int? userBasicReview;
  int? userBasicMonthlyPoints;
  int? userBasicTotalPoints;
  UserBasicExtra? userBasicExtra;
  int? vaccinationStatus;
  int? userPrefId;
  int? userPrefUserId;
  int? distance;
  int? minAge;
  int? maxAge;
  String? genederPre;
  int? userPrefEditedOn;
  int? iat;

  factory APIUser.fromJson(Map<String, dynamic> json) => APIUser(
        userId: json["user_id"] == null ? null : json["user_id"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        dobTimestamp:
            json["dob_timestamp"] == null ? null : json["dob_timestamp"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        gender: json["gender"] == null ? null : json["gender"],
        pronoun: json["pronoun"],
        height: json["height"],
        showLocation: json["show_location"],
        school: json["school"],
        editedOn: json["edited_on"] == null ? null : json["edited_on"],
        userBasicId:
            json["user_basic_id"] == null ? null : json["user_basic_id"],
        userBasicUserId: json["user_basic_user_id"] == null
            ? null
            : json["user_basic_user_id"],
        userBasicPremiumStauts: json["user_basic_premium_stauts"] == null
            ? null
            : json["user_basic_premium_stauts"],
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
        userPrefId: json["user_pref_id"] == null ? null : json["user_pref_id"],
        userPrefUserId: json["user_pref_user_id"] == null
            ? null
            : json["user_pref_user_id"],
        distance: json["distance"] == null ? null : json["distance"],
        minAge: json["min_age"] == null ? null : json["min_age"],
        maxAge: json["max_age"] == null ? null : json["max_age"],
        genederPre: json["geneder_pre"] == null ? null : json["geneder_pre"],
        userPrefEditedOn: json["user_pref_edited_on"] == null
            ? null
            : json["user_pref_edited_on"],
        iat: json["iat"] == null ? null : json["iat"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "full_name": fullName == null ? null : fullName,
        "dob": dob == null ? null : dob!.toIso8601String(),
        "dob_timestamp": dobTimestamp == null ? null : dobTimestamp,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "gender": gender == null ? null : gender,
        "pronoun": pronoun,
        "height": height,
        "show_location": showLocation,
        "school": school,
        "edited_on": editedOn == null ? null : editedOn,
        "user_basic_id": userBasicId == null ? null : userBasicId,
        "user_basic_user_id": userBasicUserId == null ? null : userBasicUserId,
        "user_basic_premium_stauts":
            userBasicPremiumStauts == null ? null : userBasicPremiumStauts,
        "user_basic_review": userBasicReview == null ? null : userBasicReview,
        "user_basic_monthly_points":
            userBasicMonthlyPoints == null ? null : userBasicMonthlyPoints,
        "user_basic_total_points":
            userBasicTotalPoints == null ? null : userBasicTotalPoints,
        "user_basic_extra":
            userBasicExtra == null ? null : userBasicExtra!.toJson(),
        "vaccination_status":
            vaccinationStatus == null ? null : vaccinationStatus,
        "user_pref_id": userPrefId == null ? null : userPrefId,
        "user_pref_user_id": userPrefUserId == null ? null : userPrefUserId,
        "distance": distance == null ? null : distance,
        "min_age": minAge == null ? null : minAge,
        "max_age": maxAge == null ? null : maxAge,
        "geneder_pre": genederPre == null ? null : genederPre,
        "user_pref_edited_on":
            userPrefEditedOn == null ? null : userPrefEditedOn,
        "iat": iat == null ? null : iat,
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
