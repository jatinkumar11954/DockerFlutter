// To parse this JSON data, do
//
//     final locationData = locationDataFromMap(jsonString);

import 'dart:convert';

class LocationData {
    LocationData({
        this.message,
        this.data,
        this.isSuccess,
    });

    final String message;
    final List<LocationItem> data;
    final bool isSuccess;

    factory LocationData.fromJson(String str) => LocationData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LocationData.fromMap(Map<String, dynamic> json) => LocationData(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<LocationItem>.from(json["data"].map((x) => LocationItem.fromMap(x))),
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    );

    Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
        "isSuccess": isSuccess == null ? null : isSuccess,
    };
}

class LocationItem {
    LocationItem({
        this.loc,
        this.isActive,
        this.id,
        this.cityName,
        this.locationName,
        this.pincode,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    final Loc loc;
    final bool isActive;
    final String id;
    final String cityName;
    final String locationName;
    final String pincode;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory LocationItem.fromJson(String str) => LocationItem.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LocationItem.fromMap(Map<String, dynamic> json) => LocationItem(
        loc: json["loc"] == null ? null : Loc.fromMap(json["loc"]),
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["_id"] == null ? null : json["_id"],
        cityName: json["city_name"] == null ? null : json["city_name"],
        locationName: json["location_name"] == null ? null : json["location_name"],
        pincode: json["pincode"] == null ? null : json["pincode"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "loc": loc == null ? null : loc.toMap(),
        "isActive": isActive == null ? null : isActive,
        "_id": id == null ? null : id,
        "city_name": cityName == null ? null : cityName,
        "location_name": locationName == null ? null : locationName,
        "pincode": pincode == null ? null : pincode,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}

class Loc {
    Loc({
        this.coordinates,
    });

    final List<dynamic> coordinates;

    factory Loc.fromJson(String str) => Loc.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Loc.fromMap(Map<String, dynamic> json) => Loc(
        coordinates: json["coordinates"] == null ? null : List<dynamic>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
    };
}
