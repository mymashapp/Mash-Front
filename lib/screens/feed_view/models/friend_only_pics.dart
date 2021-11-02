// To parse this JSON data, do
//
//     final friendOnlyPics = friendOnlyPicsFromJson(jsonString);

import 'dart:convert';

FriendOnlyPics friendOnlyPicsFromJson(String str) =>
    FriendOnlyPics.fromJson(json.decode(str));

String friendOnlyPicsToJson(FriendOnlyPics data) => json.encode(data.toJson());

class FriendOnlyPics {
  FriendOnlyPics({
    this.success,
    this.data,
  });

  int? success;
  List<FriendPhoto>? data;

  factory FriendOnlyPics.fromJson(Map<String, dynamic> json) => FriendOnlyPics(
        success: json["success"],
        data: List<FriendPhoto>.from(
            json["data"].map((x) => FriendPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FriendPhoto {
  FriendPhoto({
    this.fullName,
    this.friendsOnlyImgsId,
    this.friendsOnlyImgsUserId,
    this.friendsOnlyImgsUrl,
    this.friendsOnlyImgsUploadedAt,
    this.imageLikes,
  });

  String? fullName;
  String? friendsOnlyImgsId;
  int? friendsOnlyImgsUserId;
  String? friendsOnlyImgsUrl;
  int? friendsOnlyImgsUploadedAt;
  int? imageLikes;

  factory FriendPhoto.fromJson(Map<String, dynamic> json) => FriendPhoto(
        fullName: json["full_name"],
        friendsOnlyImgsId: json["friends_only_imgs_id"],
        friendsOnlyImgsUserId: json["friends_only_imgs_user_id"],
        friendsOnlyImgsUrl: json["friends_only_imgs_url"],
        friendsOnlyImgsUploadedAt: json["friends_only_imgs_uploaded_at"],
        imageLikes: json["image_likes"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "friends_only_imgs_id": friendsOnlyImgsId,
        "friends_only_imgs_user_id": friendsOnlyImgsUserId,
        "friends_only_imgs_url": friendsOnlyImgsUrl,
        "friends_only_imgs_uploaded_at": friendsOnlyImgsUploadedAt,
        "image_likes": imageLikes,
      };
}
