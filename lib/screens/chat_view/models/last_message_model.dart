class LastMessage {
  LastMessage({
    this.msg,
    this.userId,
    this.timestamp,
  });

  String? msg;
  int? userId;
  int? timestamp;

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        msg: json["msg"],
        userId: json["user_id"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "user_id": userId,
        "timestamp": timestamp,
      };
}
