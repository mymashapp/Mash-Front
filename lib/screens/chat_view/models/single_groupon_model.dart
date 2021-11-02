// To parse this JSON data, do
//
//     final singleGroupon = singleGrouponFromJson(jsonString);

import 'dart:convert';

SingleGrouponModel singleGrouponFromJson(String str) =>
    SingleGrouponModel.fromJson(json.decode(str));

String singleGrouponToJson(SingleGrouponModel data) =>
    json.encode(data.toJson());

class SingleGrouponModel {
  SingleGrouponModel({
    this.success,
    this.data,
  });

  int? success;
  List<GrouponSingle>? data;

  factory SingleGrouponModel.fromJson(Map<String, dynamic> json) =>
      SingleGrouponModel(
        success: json["success"],
        data: List<GrouponSingle>.from(
            json["data"].map((x) => GrouponSingle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GrouponSingle {
  GrouponSingle({
    this.gOlocationId,
    this.goid,
    this.lat,
    this.lon,
    this.id,
    this.name,
    this.img,
    this.link,
    this.loc,
    this.rating,
    this.noofrating,
    this.op,
    this.dp,
    this.db,
    this.up,
    this.ut,
    this.st,
  });

  int? gOlocationId;
  String? goid;
  double? lat;
  double? lon;
  String? id;
  String? name;
  String? img;
  String? link;
  String? loc;
  double? rating;
  int? noofrating;
  String? op;
  String? dp;
  String? db;
  String? up;
  String? ut;
  String? st;

  factory GrouponSingle.fromJson(Map<String, dynamic> json) => GrouponSingle(
        gOlocationId: json["GOlocation_id"],
        goid: json["goid"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        id: json["id"],
        name: json["name"],
        img: json["img"],
        link: json["link"],
        loc: json["loc"],
        rating: json["rating"].toDouble(),
        noofrating: json["noofrating"],
        op: json["op"],
        dp: json["dp"],
        db: json["db"],
        up: json["up"],
        ut: json["ut"],
        st: json["st"],
      );

  Map<String, dynamic> toJson() => {
        "GOlocation_id": gOlocationId,
        "goid": goid,
        "lat": lat,
        "lon": lon,
        "id": id,
        "name": name,
        "img": img,
        "link": link,
        "loc": loc,
        "rating": rating,
        "noofrating": noofrating,
        "op": op,
        "dp": dp,
        "db": db,
        "up": up,
        "ut": ut,
        "st": st,
      };
}
