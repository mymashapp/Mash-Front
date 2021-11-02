// To parse this JSON data, do
//
//     final chatUsersModel = chatUsersModelFromJson(jsonString);

import 'dart:convert';

List<ChatUsersModel> chatUsersModelFromJson(String str) =>
    List<ChatUsersModel>.from(
        json.decode(str).map((x) => ChatUsersModel.fromJson(x)));

String chatUsersModelToJson(List<ChatUsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatUsersModel {
  ChatUsersModel({
    this.chatMainUsersListId,
    this.chatMainUsersChatId,
    this.chatMainUsersId,
    this.lastOpenedAt,
    this.chatMainId,
    this.chatMainEventId,
    this.chatMainName,
    this.chatMainLastUpdateAt,
    this.chatMainTotalJoinedPeople,
    this.chatCreatedAt,
    this.eventExtra,
  });

  int? chatMainUsersListId;
  String? chatMainUsersChatId;
  int? chatMainUsersId;
  int? lastOpenedAt;
  String? chatMainId;
  int? chatMainEventId;
  String? chatMainName;
  int? chatMainLastUpdateAt;
  int? chatMainTotalJoinedPeople;
  int? chatCreatedAt;
  EventExtra? eventExtra;

  factory ChatUsersModel.fromJson(Map<String, dynamic> json) => ChatUsersModel(
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
        chatMainId: json["chat_main_id"] == null ? null : json["chat_main_id"],
        chatMainEventId: json["chat_main_event_id"] == null
            ? null
            : json["chat_main_event_id"],
        chatMainName:
            json["chat_main_name"] == null ? null : json["chat_main_name"],
        chatMainLastUpdateAt: json["chat_main_last_update_at"] == null
            ? null
            : json["chat_main_last_update_at"],
        chatMainTotalJoinedPeople: json["chat_main_total_joined_people"] == null
            ? null
            : json["chat_main_total_joined_people"],
        chatCreatedAt:
            json["chat_created_at"] == null ? null : json["chat_created_at"],
        eventExtra: json["event_extra"] == null
            ? null
            : EventExtra.fromJson(json["event_extra"]),
      );

  Map<String, dynamic> toJson() => {
        "chat_main_users_list_id":
            chatMainUsersListId == null ? null : chatMainUsersListId,
        "chat_main_users_chat_id":
            chatMainUsersChatId == null ? null : chatMainUsersChatId,
        "chat_main_users_id": chatMainUsersId == null ? null : chatMainUsersId,
        "last_opened_at": lastOpenedAt == null ? null : lastOpenedAt,
        "chat_main_id": chatMainId == null ? null : chatMainId,
        "chat_main_event_id": chatMainEventId == null ? null : chatMainEventId,
        "chat_main_name": chatMainName == null ? null : chatMainName,
        "chat_main_last_update_at":
            chatMainLastUpdateAt == null ? null : chatMainLastUpdateAt,
        "chat_main_total_joined_people": chatMainTotalJoinedPeople == null
            ? null
            : chatMainTotalJoinedPeople,
        "chat_created_at": chatCreatedAt == null ? null : chatCreatedAt,
        "event_extra": eventExtra == null ? null : eventExtra!.toJson(),
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
  dynamic rating;
  double? distance;
  Location? location;
  String? imageUrl;
  bool? isClosed;
  List<Category>? categories;
  Coordinates? coordinates;
  int? reviewCount;
  List<String>? transactions;
  String? displayPhone;

  factory EventExtra.fromJson(Map<String, dynamic> json) => EventExtra(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        name: json["name"] == null ? null : json["name"],
        alias: json["alias"] == null ? null : json["alias"],
        phone: json["phone"] == null ? null : json["phone"],
        price: json["price"] == null ? null : json["price"],
        rating: json["rating"] == null ? null : json["rating"],
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

  Map<String, dynamic> toJson() => {
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
        "transactions": transactions == null
            ? null
            : List<dynamic>.from(transactions!.map((x) => x)),
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        alias: json["alias"] == null ? null : json["alias"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
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

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
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

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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

  Map<String, dynamic> toJson() => {
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
