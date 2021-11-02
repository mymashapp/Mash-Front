// To parse this JSON data, do
//
//     final allEventModel = allEventModelFromJson(jsonString);

import 'dart:convert';

AllEventModel allEventModelFromJson(String str) =>
    AllEventModel.fromJson(json.decode(str));

String? allEventModelToJson(AllEventModel data) => json.encode(data.toJson());

class AllEventModel {
  AllEventModel({
    this.success,
    this.data,
  });

  int? success;
  List<Event>? data;

  factory AllEventModel.fromJson(Map<String?, dynamic> json) => AllEventModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    this.distanceInMiles,
    this.eventId,
    this.userId,
    this.thirdPartyUniqueId,
    this.evetType,
    this.eventName,
    this.eventLat,
    this.eventLog,
    this.placeName,
    this.category,
    this.activity,
    this.eventDateTime,
    this.eventDateTimestamp,
    this.party,
    this.totalAllowedPeople,
    this.totalJoinedPeople,
    this.eventExtra,
    this.allowedGender,
    this.dating,
    this.status,
    this.editedOn,
  });

  double? distanceInMiles;
  int? eventId;
  dynamic userId;
  String? thirdPartyUniqueId;
  String? evetType;
  String? eventName;
  double? eventLat;
  double? eventLog;
  String? placeName;
  int? category;
  int? activity;
  dynamic eventDateTime;
  dynamic eventDateTimestamp;
  int? party;
  int? totalAllowedPeople;
  int? totalJoinedPeople;
  EventExtra? eventExtra;
  String? allowedGender;
  int? dating;
  int? status;
  int? editedOn;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        distanceInMiles: json["distance_in_miles"] == null
            ? null
            : json["distance_in_miles"].toDouble(),
        eventId: json["event_id"] == null ? null : json["event_id"],
        userId: json["user_id"],
        thirdPartyUniqueId: json["third_party_unique_id"] == null
            ? null
            : json["third_party_unique_id"],
        evetType: json["evet_type"] == null ? null : json["evet_type"],
        eventName: json["event_name"] == null ? null : json["event_name"],
        eventLat:
            json["event_lat"] == null ? null : json["event_lat"].toDouble(),
        eventLog:
            json["event_log"] == null ? null : json["event_log"].toDouble(),
        placeName: json["place_name"] == null ? null : json["place_name"],
        category: json["category"] == null ? null : json["category"],
        activity: json["activity"] == null ? null : json["activity"],
        eventDateTime: json["event_date_time"],
        eventDateTimestamp: json["event_date_timestamp"],
        party: json["party"] == null ? null : json["party"],
        totalAllowedPeople: json["total_allowed_people"] == null
            ? null
            : json["total_allowed_people"],
        totalJoinedPeople: json["total_joined_people"] == null
            ? null
            : json["total_joined_people"],
        eventExtra: json["event_extra"] == null
            ? null
            : EventExtra.fromJson(json["event_extra"]),
        allowedGender:
            json["allowed_gender"] == null ? null : json["allowed_gender"],
        dating: json["dating"] == null ? null : json["dating"],
        status: json["status"] == null ? null : json["status"],
        editedOn: json["edited_on"] == null ? null : json["edited_on"],
      );

  Map<String?, dynamic> toJson() => {
        "distance_in_miles": distanceInMiles == null ? null : distanceInMiles,
        "event_id": eventId == null ? null : eventId,
        "user_id": userId,
        "third_party_unique_id":
            thirdPartyUniqueId == null ? null : thirdPartyUniqueId,
        "evet_type": evetType == null ? null : evetType,
        "event_name": eventName == null ? null : eventName,
        "event_lat": eventLat == null ? null : eventLat,
        "event_log": eventLog == null ? null : eventLog,
        "place_name": placeName == null ? null : placeName,
        "category": category == null ? null : category,
        "activity": activity == null ? null : activity,
        "event_date_time": eventDateTime,
        "event_date_timestamp": eventDateTimestamp,
        "party": party == null ? null : party,
        "total_allowed_people":
            totalAllowedPeople == null ? null : totalAllowedPeople,
        "total_joined_people":
            totalJoinedPeople == null ? null : totalJoinedPeople,
        "event_extra": eventExtra == null ? null : eventExtra!.toJson(),
        "allowed_gender": allowedGender == null ? null : allowedGender,
        "dating": dating == null ? null : dating,
        "status": status == null ? null : status,
        "edited_on": editedOn == null ? null : editedOn,
      };
}

class EventExtra {
  EventExtra({
    this.id,
    this.url,
    this.name,
    this.alias,
    this.phone,
    this.price,
    this.rating,
    this.distance,
    this.location,
    this.imageUrl,
    this.isClosed,
    this.categories,
    this.coordinates,
    this.reviewCount,
    this.transactions,
    this.displayPhone,
  });

  String? id;
  String? url;
  String? name;
  String? alias;
  String? phone;
  String? price;
  double? rating;
  double? distance;
  Location? location;
  String? imageUrl;
  bool? isClosed;
  List<Category>? categories;
  Coordinates? coordinates;
  int? reviewCount;
  List<String>? transactions;
  String? displayPhone;

  factory EventExtra.fromJson(Map<String?, dynamic> json) => EventExtra(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        name: json["name"] == null ? null : json["name"],
        alias: json["alias"] == null ? null : json["alias"],
        phone: json["phone"] == null ? null : json["phone"],
        price: json["price"] == null ? null : json["price"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        isClosed: json["is_closed"] == null ? null : json["is_closed"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
        reviewCount: json["review_count"] == null ? null : json["review_count"],
        transactions: json["transactions"] == null
            ? null
            : List<String>.from(json["transactions"].map((x) => x)),
        displayPhone:
            json["display_phone"] == null ? null : json["display_phone"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "name": name == null ? null : name,
        "alias": alias == null ? null : alias,
        "phone": phone == null ? null : phone,
        "price": price == null ? null : price,
        "rating": rating == null ? null : rating,
        "distance": distance == null ? null : distance,
        "location": location == null ? null : location!.toJson(),
        "image_url": imageUrl == null ? null : imageUrl,
        "is_closed": isClosed == null ? null : isClosed,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "coordinates": coordinates == null ? null : coordinates!.toJson(),
        "review_count": reviewCount == null ? null : reviewCount,
        "transactions": transactions == null ? null : transactions,
        "display_phone": displayPhone == null ? null : displayPhone,
      };
}

class Category {
  Category({
    this.alias,
    this.title,
  });

  String? alias;
  String? title;

  factory Category.fromJson(Map<String?, dynamic> json) => Category(
        alias: json["alias"] == null ? null : json["alias"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String?, dynamic> toJson() => {
        "alias": alias == null ? null : alias,
        "title": title == null ? null : title,
      };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Coordinates.fromJson(Map<String?, dynamic> json) => Coordinates(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String?, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}

class Location {
  Location({
    this.city,
    this.state,
    this.country,
    this.address1,
    this.address2,
    this.address3,
    this.zipCode,
    this.displayAddress,
  });

  String? city;
  String? state;
  String? country;
  String? address1;
  String? address2;
  String? address3;
  String? zipCode;
  List<String>? displayAddress;

  factory Location.fromJson(Map<String?, dynamic> json) => Location(
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        address3: json["address3"] == null ? null : json["address3"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        displayAddress: json["display_address"] == null
            ? null
            : List<String>.from(json["display_address"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "address3": address3 == null ? null : address3,
        "zip_code": zipCode == null ? null : zipCode,
        "display_address": displayAddress == null
            ? null
            : List<dynamic>.from(displayAddress!.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
