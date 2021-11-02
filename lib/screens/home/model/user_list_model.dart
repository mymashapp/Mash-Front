// To parse this JSON data, do
//
//     final usersOfMash = usersOfMashFromJson(jsonString);

import 'dart:convert';

UsersOfMash usersOfMashFromJson(String str) =>
    UsersOfMash.fromJson(json.decode(str));

String usersOfMashToJson(UsersOfMash data) => json.encode(data.toJson());

class UsersOfMash {
  UsersOfMash({
    this.success,
    this.list,
  });

  int? success;
  List<UserOfMashList>? list;

  factory UsersOfMash.fromJson(Map<String, dynamic> json) => UsersOfMash(
        success: json["success"] == null ? null : json["success"],
        list: json["list"] == null
            ? null
            : List<UserOfMashList>.from(
                json["list"].map((x) => UserOfMashList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class UserOfMashList {
  UserOfMashList({
    this.chatMainUsersListId,
    this.chatMainUsersChatId,
    this.chatMainUsersId,
    this.lastOpenedAt,
    this.fullName,
    this.usersFriendsListStatus,
  });

  int? chatMainUsersListId;
  String? chatMainUsersChatId;
  int? chatMainUsersId;
  int? lastOpenedAt;
  String? fullName;
  int? usersFriendsListStatus;

  factory UserOfMashList.fromJson(Map<String, dynamic> json) => UserOfMashList(
        chatMainUsersListId: json["chat_main_users_list_id"] == null
            ? null
            : json["chat_main_users_list_id"],
        chatMainUsersChatId: json["chat_main_users_chat_id"] == null
            ? null
            : json["chat_main_users_chat_id"],
        chatMainUsersId: json["chat_main_users_id"] == null
            ? null
            : json["chat_main_users_id"],
        lastOpenedAt:
            json["last_opened_at"] == null ? null : json["last_opened_at"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        usersFriendsListStatus: json["users_friends_list_status"] == null
            ? null
            : json["users_friends_list_status"],
      );

  Map<String, dynamic> toJson() => {
        "chat_main_users_list_id":
            chatMainUsersListId == null ? null : chatMainUsersListId,
        "chat_main_users_chat_id":
            chatMainUsersChatId == null ? null : chatMainUsersChatId,
        "chat_main_users_id": chatMainUsersId == null ? null : chatMainUsersId,
        "last_opened_at": lastOpenedAt == null ? null : lastOpenedAt,
        "full_name": fullName == null ? null : fullName,
        "users_friends_list_status":
            usersFriendsListStatus == null ? null : usersFriendsListStatus,
      };
}
