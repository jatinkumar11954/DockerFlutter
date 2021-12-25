// To parse this JSON data, do
//
//     final offerBanner = offerBannerFromMap(jsonString);

import 'dart:convert';

class OfferBanner {
    OfferBanner({
        this.message,
        this.offer,
        this.isSuccess,
    });

    final String message;
    final List<Offer> offer;
    final bool isSuccess;

    factory OfferBanner.fromJson(String str) => OfferBanner.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OfferBanner.fromMap(Map<String, dynamic> json) => OfferBanner(
        message: json["message"] == null ? null : json["message"],
        offer: json["offer"] == null ? null : List<Offer>.from(json["offer"].map((x) => Offer.fromMap(x))),
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    );

    Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "offer": offer == null ? null : List<dynamic>.from(offer.map((x) => x.toMap())),
        "isSuccess": isSuccess == null ? null : isSuccess,
    };
}

class Offer {
    Offer({
        this.isActive,
        this.id,
        this.bannerName,
        this.size,
        this.bannerUrl,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    final bool isActive;
    final String id;
    final String bannerName;
    final String size;
    final String bannerUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory Offer.fromJson(String str) => Offer.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Offer.fromMap(Map<String, dynamic> json) => Offer(
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["_id"] == null ? null : json["_id"],
        bannerName: json["bannerName"] == null ? null : json["bannerName"],
        size: json["size"] == null ? null : json["size"],
        bannerUrl: json["bannerUrl"] == null ? null : json["bannerUrl"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "isActive": isActive == null ? null : isActive,
        "_id": id == null ? null : id,
        "bannerName": bannerName == null ? null : bannerName,
        "size": size == null ? null : size,
        "bannerUrl": bannerUrl == null ? null : bannerUrl,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
