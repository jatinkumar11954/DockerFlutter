// To parse this JSON data, do
//
//     final banner = bannerFromMap(jsonString);

import 'dart:convert';

class Banner {
  Banner({
    this.message,
    this.bannerData,
    this.isSuccess,
  });

  final String message;
  final List<BannerData> bannerData;
  final bool isSuccess;

  factory Banner.fromJson(String str) => Banner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        message: json["message"] == null ? null : json["message"],
        bannerData: json["bannerData"] == null
            ? null
            : List<BannerData>.from(
                json["bannerData"].map((x) => BannerData.fromMap(x))),
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "bannerData": bannerData == null
            ? null
            : List<dynamic>.from(bannerData.map((x) => x.toMap())),
        "isSuccess": isSuccess == null ? null : isSuccess,
      };
}

class BannerData {
  BannerData({
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

  factory BannerData.fromJson(String str) =>
      BannerData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerData.fromMap(Map<String, dynamic> json) => BannerData(
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["_id"] == null ? null : json["_id"],
        bannerName: json["bannerName"] == null ? null : json["bannerName"],
        size: json["size"] == null ? null : json["size"],
        bannerUrl: json["bannerUrl"] == null ? null : json["bannerUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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
