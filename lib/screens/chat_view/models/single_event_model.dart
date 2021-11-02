// To parse this JSON data, do
//
//     final singleEventDetail = singleEventDetailFromJson(jsonString);

import 'dart:convert';

SingleEventDetail singleEventDetailFromJson(String str) =>
    SingleEventDetail.fromJson(json.decode(str));

String singleEventDetailToJson(SingleEventDetail data) =>
    json.encode(data.toJson());

class SingleEventDetail {
  SingleEventDetail({
    this.success,
    this.data,
    this.total,
  });

  dynamic success;
  List<EventDetails>? data;
  dynamic total;

  factory SingleEventDetail.fromJson(Map<String, dynamic> json) =>
      SingleEventDetail(
        success: json["success"],
        data: List<EventDetails>.from(
            json["data"].map((x) => EventDetails.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class EventDetails {
  EventDetails({
    this.eventId,
    this.userId,
    this.thirdPartyUniqueId,
    this.eventType,
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
    this.mashEventChatId,
    this.editedOn,
  });

  dynamic eventId;
  dynamic userId;
  String? thirdPartyUniqueId;
  String? eventType;
  String? eventName;
  double? eventLat;
  double? eventLog;
  String? placeName;
  dynamic category;
  dynamic activity;
  dynamic eventDateTime;
  dynamic eventDateTimestamp;
  dynamic party;
  dynamic totalAllowedPeople;
  dynamic totalJoinedPeople;
  EventExtra? eventExtra;
  String? allowedGender;
  dynamic dating;
  dynamic status;
  dynamic mashEventChatId;
  dynamic editedOn;

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
        eventId: json["event_id"],
        userId: json["user_id"],
        thirdPartyUniqueId: json["third_party_unique_id"],
        eventType: json["event_type"],
        eventName: json["event_name"],
        eventLat: json["event_lat"].toDouble(),
        eventLog: json["event_log"].toDouble(),
        placeName: json["place_name"],
        category: json["category"],
        activity: json["activity"],
        eventDateTime: json["event_date_time"],
        eventDateTimestamp: json["event_date_timestamp"],
        party: json["party"],
        totalAllowedPeople: json["total_allowed_people"],
        totalJoinedPeople: json["total_joined_people"],
        eventExtra: EventExtra.fromJson(json["event_extra"]),
        allowedGender: json["allowed_gender"],
        dating: json["dating"],
        status: json["status"],
        mashEventChatId: json["mash_event_chat_id"],
        editedOn: json["edited_on"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "user_id": userId,
        "third_party_unique_id": thirdPartyUniqueId,
        "event_type": eventType,
        "event_name": eventName,
        "event_lat": eventLat,
        "event_log": eventLog,
        "place_name": placeName,
        "category": category,
        "activity": activity,
        "event_date_time": eventDateTime,
        "event_date_timestamp": eventDateTimestamp,
        "party": party,
        "total_allowed_people": totalAllowedPeople,
        "total_joined_people": totalJoinedPeople,
        "event_extra": eventExtra!.toJson(),
        "allowed_gender": allowedGender,
        "dating": dating,
        "status": status,
        "mash_event_chat_id": mashEventChatId,
        "edited_on": editedOn,
      };
}

class EventExtra {
  EventExtra({
    this.id,
    this.url,
    this.name,
    this.alias,
    this.phone,
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
  dynamic rating;
  double? distance;
  Location? location;
  String? imageUrl;
  bool? isClosed;
  List<Category>? categories;
  Coordinates? coordinates;
  dynamic reviewCount;
  List<dynamic>? transactions;
  String? displayPhone;

  factory EventExtra.fromJson(Map<String, dynamic> json) => EventExtra(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        alias: json["alias"],
        phone: json["phone"],
        rating: json["rating"],
        distance: json["distance"].toDouble(),
        location: Location.fromJson(json["location"]),
        imageUrl: json["image_url"],
        isClosed: json["is_closed"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        coordinates: Coordinates.fromJson(json["coordinates"]),
        reviewCount: json["review_count"],
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
        displayPhone: json["display_phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "alias": alias,
        "phone": phone,
        "rating": rating,
        "distance": distance,
        "location": location!.toJson(),
        "image_url": imageUrl,
        "is_closed": isClosed,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "coordinates": coordinates!.toJson(),
        "review_count": reviewCount,
        "transactions": List<dynamic>.from(transactions!.map((x) => x)),
        "display_phone": displayPhone,
      };
}

class Category {
  Category({
    this.alias,
    this.title,
  });

  String? alias;
  String? title;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        alias: json["alias"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "alias": alias,
        "title": title,
      };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
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
  dynamic address3;
  String? zipCode;
  List<String>? displayAddress;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        zipCode: json["zip_code"],
        displayAddress:
            List<String>.from(json["display_address"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "zip_code": zipCode,
        "display_address": List<dynamic>.from(displayAddress!.map((x) => x)),
      };
}
