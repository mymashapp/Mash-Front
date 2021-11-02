// To parse this JSON data, do
//
//     final friendsLocationModel = friendsLocationModelFromJson(jsonString);

import 'dart:convert';

FriendsLocationModel friendsLocationModelFromJson(String str) =>
    FriendsLocationModel.fromJson(json.decode(str));

String friendsLocationModelToJson(FriendsLocationModel data) =>
    json.encode(data.toJson());

class FriendsLocationModel {
  FriendsLocationModel({
    this.success,
    this.data,
  });

  int? success;
  List<FriendLocation>? data;

  factory FriendsLocationModel.fromJson(Map<String, dynamic> json) =>
      FriendsLocationModel(
        success: json["success"],
        data: List<FriendLocation>.from(
            json["data"].map((x) => FriendLocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FriendLocation {
  FriendLocation({
    this.distanceInMiles,
    this.userId,
    this.fullName,
    this.gender,
    this.userLat,
    this.userLong,
  });

  double? distanceInMiles;
  int? userId;
  String? fullName;
  String? gender;
  double? userLat;
  double? userLong;

  factory FriendLocation.fromJson(Map<String, dynamic> json) => FriendLocation(
        distanceInMiles: json["distance_in_miles"].toDouble(),
        userId: json["user_id"],
        fullName: json["full_name"],
        gender: json["gender"],
        userLat: json["user_lat"].toDouble(),
        userLong: json["user_long"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "distance_in_miles": distanceInMiles,
        "user_id": userId,
        "full_name": fullName,
        "gender": gender,
        "user_lat": userLat,
        "user_long": userLong,
      };
}
