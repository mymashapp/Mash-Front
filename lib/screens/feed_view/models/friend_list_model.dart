// To parse this JSON data, do
//
//     final friendListModel = friendListModelFromJson(jsonString);

import 'dart:convert';

FriendListModel friendListModelFromJson(String str) =>
    FriendListModel.fromJson(json.decode(str));

String friendListModelToJson(FriendListModel data) =>
    json.encode(data.toJson());

class FriendListModel {
  FriendListModel({
    this.success,
    this.data,
  });

  int? success;
  List<Friend>? data;

  factory FriendListModel.fromJson(Map<String, dynamic> json) =>
      FriendListModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Friend>.from(json["data"].map((x) => Friend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Friend {
  Friend({
    this.fullName,
    this.usersFriendsListId,
    this.usersFriendsListUserId,
    this.usersFriendsListFriendId,
    this.usersFriendsListStatus,
    this.usersFriendsListUpdatedAt,
    this.usersFriendsListChatId,
    this.usersFriendsListChatOpenedAt,
    this.usersFriendsListLastMessagedAt,
  });

  String? fullName;
  int? usersFriendsListId;
  int? usersFriendsListUserId;
  int? usersFriendsListFriendId;
  int? usersFriendsListStatus;
  int? usersFriendsListUpdatedAt;
  String? usersFriendsListChatId;
  int? usersFriendsListChatOpenedAt;
  int? usersFriendsListLastMessagedAt;

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        fullName: json["full_name"] == null ? null : json["full_name"],
        usersFriendsListId: json["users_friends_list_id"] == null
            ? null
            : json["users_friends_list_id"],
        usersFriendsListUserId: json["users_friends_list_user_id"] == null
            ? null
            : json["users_friends_list_user_id"],
        usersFriendsListFriendId: json["users_friends_list_friend_id"] == null
            ? null
            : json["users_friends_list_friend_id"],
        usersFriendsListStatus: json["users_friends_list_status"] == null
            ? null
            : json["users_friends_list_status"],
        usersFriendsListUpdatedAt: json["users_friends_list_updated_at"] == null
            ? null
            : json["users_friends_list_updated_at"],
        usersFriendsListChatId: json["users_friends_list_chat_id"] == null
            ? null
            : json["users_friends_list_chat_id"],
        usersFriendsListChatOpenedAt:
            json["users_friends_list_chat_opened_at"] == null
                ? null
                : json["users_friends_list_chat_opened_at"],
        usersFriendsListLastMessagedAt:
            json["users_friends_list_last_messaged_at"] == null
                ? null
                : json["users_friends_list_last_messaged_at"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName == null ? null : fullName,
        "users_friends_list_id":
            usersFriendsListId == null ? null : usersFriendsListId,
        "users_friends_list_user_id":
            usersFriendsListUserId == null ? null : usersFriendsListUserId,
        "users_friends_list_friend_id":
            usersFriendsListFriendId == null ? null : usersFriendsListFriendId,
        "users_friends_list_status":
            usersFriendsListStatus == null ? null : usersFriendsListStatus,
        "users_friends_list_updated_at": usersFriendsListUpdatedAt == null
            ? null
            : usersFriendsListUpdatedAt,
        "users_friends_list_chat_id":
            usersFriendsListChatId == null ? null : usersFriendsListChatId,
        "users_friends_list_chat_opened_at":
            usersFriendsListChatOpenedAt == null
                ? null
                : usersFriendsListChatOpenedAt,
        "users_friends_list_last_messaged_at":
            usersFriendsListLastMessagedAt == null
                ? null
                : usersFriendsListLastMessagedAt,
      };
}
