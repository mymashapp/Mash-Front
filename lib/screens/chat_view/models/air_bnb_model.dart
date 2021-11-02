// To parse this JSON data, do
//
//     final singleAirBnb = singleAirBnbFromJson(jsonString);

import 'dart:convert';

SingleAirBnb singleAirBnbFromJson(String str) => SingleAirBnb.fromJson(json.decode(str));

String singleAirBnbToJson(SingleAirBnb data) => json.encode(data.toJson());

class SingleAirBnb {
  SingleAirBnb({
    this.success,
    this.data,
  });

  int? success;
  List<SingleAirBnbData>? data;

  factory SingleAirBnb.fromJson(Map<String, dynamic> json) => SingleAirBnb(
    success: json["success"],
    data: List<SingleAirBnbData>.from(json["data"].map((x) => SingleAirBnbData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleAirBnbData {
  SingleAirBnbData({
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

  factory SingleAirBnbData.fromJson(Map<String, dynamic> json) => SingleAirBnbData(
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
  };
}
