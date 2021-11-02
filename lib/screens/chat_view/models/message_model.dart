// To parse this JSON data, do
//
//     final messageItem = messageItemFromJson(jsonString);

import 'dart:convert';

MessageItem messageItemFromJson(String str) =>
    MessageItem.fromJson(json.decode(str));

String messageItemToJson(MessageItem data) => json.encode(data.toJson());

class MessageItem {
  MessageItem({this.msg, this.userId, this.timestamp, this.type, this.eventId});

  String? msg;
  String? type;
  int? userId;
  dynamic eventId;
  int? timestamp;

  factory MessageItem.fromJson(Map<String, dynamic> json) => MessageItem(
        msg: json["text"] == null ? null : json["text"],
        type: json["type"] == null ? null : json["type"],
        userId: json["user_id"] == null ? null : json["user_id"],
        eventId: json["event_id"] == null ? null : json["event_id"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "text": msg == null ? null : msg,
        "type": type == null ? null : type,
        "user_id": userId == null ? null : userId,
        "timestamp": timestamp == null ? null : timestamp,
        "event_id": eventId == null ? null : eventId,
      };
}
