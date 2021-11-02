// To parse this JSON data, do
//
//     final airBnBModel = airBnBModelFromJson(jsonString);

import 'dart:convert';

AirBnBModel airBnBModelFromJson(String str) => AirBnBModel.fromJson(json.decode(str));

String airBnBModelToJson(AirBnBModel data) => json.encode(data.toJson());

class AirBnBModel {
  AirBnBModel({
    this.success,
    this.data,
  });

  int? success;
  List<AirBnb>? data;

  factory AirBnBModel.fromJson(Map<String, dynamic> json) => AirBnBModel(
    success: json["success"],
    data: List<AirBnb>.from(json["data"].map((x) => AirBnb.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AirBnb {
  AirBnb({
    this.id,
    this.name,
    this.link,
    this.act,
    this.loc,
    this.lat,
    this.lon,
    this.image,
    this.time,
    this.people,
    this.rating,
    this.noofrating,
    this.price,
    this.latpoint,
    this.longpoint,
    this.distanceInMiles,
  });

  int? id;
  String? name;
  String? link;
  String? act;
  String? loc;
  double? lat;
  double? lon;
  String? image;
  String? time;
  String? people;
  double? rating;
  int? noofrating;
  String? price;
  double? latpoint;
  double? longpoint;
  double? distanceInMiles;

  factory AirBnb.fromJson(Map<String, dynamic> json) => AirBnb(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    act: json["act"],
    loc: json["loc"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    image: json["image"],
    time: json["time"],
    people: json["people"],
    rating: json["rating"].toDouble(),
    noofrating: json["noofrating"],
    price: json["price"],
    latpoint: json["latpoint"].toDouble(),
    longpoint: json["longpoint"].toDouble(),
    distanceInMiles: json["distance_in_miles"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "act": act,
    "loc": loc,
    "lat": lat,
    "lon": lon,
    "image": image,
    "time": time,
    "people": people,
    "rating": rating,
    "noofrating": noofrating,
    "price": price,
    "latpoint": latpoint,
    "longpoint": longpoint,
    "distance_in_miles": distanceInMiles,
  };
}


