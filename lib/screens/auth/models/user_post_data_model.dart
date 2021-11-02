// To parse this JSON data, do
//
//     final userPostDataModel = userPostDataModelFromJson(jsonString);

import 'dart:convert';

UserPostDataModel userPostDataModelFromJson(String str) =>
    UserPostDataModel.fromJson(json.decode(str));

String userPostDataModelToJson(UserPostDataModel data) =>
    json.encode(data.toJson());

class UserPostDataModel {
  UserPostDataModel({
    this.userData,
    this.firebaseToken,
  });

  UserData? userData;
  String? firebaseToken;

  factory UserPostDataModel.fromJson(Map<String, dynamic> json) =>
      UserPostDataModel(
        userData: json["user_data"] == null
            ? null
            : UserData.fromJson(json["user_data"]),
        firebaseToken:
            json["firebase_token"] == null ? null : json["firebase_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData == null ? null : userData!.toJson(),
        "firebase_token": firebaseToken == null ? null : firebaseToken,
      };
}

class UserData {
  UserData({
    this.fullName,
    this.dobTimestamp,
    this.email,
    this.phone,
    this.gender,
  });

  String? fullName;
  int? dobTimestamp;
  String? email;
  int? phone;
  String? gender;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        fullName: json["full_name"] == null ? null : json["full_name"],
        dobTimestamp:
            json["dob_timestamp"] == null ? null : json["dob_timestamp"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        gender: json["gender"] == null ? null : json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName == null ? null : fullName,
        "dob_timestamp": dobTimestamp == null ? null : dobTimestamp,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "gender": gender == null ? null : gender,
      };
}
