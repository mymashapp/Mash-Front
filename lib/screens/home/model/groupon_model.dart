// To parse this JSON data, do
//
//     final grouponModel = grouponModelFromJson(jsonString);

import 'dart:convert';

GrouponModel grouponModelFromJson(String str) =>
    GrouponModel.fromJson(json.decode(str));

String grouponModelToJson(GrouponModel data) => json.encode(data.toJson());

class GrouponModel {
  GrouponModel({
    this.success,
    this.data,
  });

  int? success;
  List<Groupon>? data;

  factory GrouponModel.fromJson(Map<String, dynamic> json) => GrouponModel(
        success: json["success"],
        data: List<Groupon>.from(json["data"].map((x) => Groupon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Groupon {
  Groupon({
    this.gOlocationId,
    this.goid,
    this.lat,
    this.lon,
    this.latpoint,
    this.longpoint,
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
    this.distanceInMiles,
  });

  int? gOlocationId;
  String? goid;
  double? lat;
  double? lon;
  double? latpoint;
  double? longpoint;
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
  double? distanceInMiles;

  factory Groupon.fromJson(Map<String, dynamic> json) => Groupon(
        gOlocationId: json["GOlocation_id"],
        goid: json["goid"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        latpoint: json["latpoint"].toDouble(),
        longpoint: json["longpoint"].toDouble(),
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
        distanceInMiles: json["distance_in_miles"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "GOlocation_id": gOlocationId,
        "goid": goid,
        "lat": lat,
        "lon": lon,
        "latpoint": latpoint,
        "longpoint": longpoint,
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
        "distance_in_miles": distanceInMiles,
      };
}
