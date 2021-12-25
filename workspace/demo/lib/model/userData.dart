// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/widgets.dart';

class User {
  User({
    this.message,
    this.userData,
    this.isSuccess,
  });

  final String message;
  final UserData userData;
  final bool isSuccess;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        message: json["message"] == null ? null : json["message"],
        userData: json["userData"] == null
            ? null
            : UserData.fromMap(json["userData"]),
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "userData": userData == null ? null : userData.toMap(),
        "isSuccess": isSuccess == null ? null : isSuccess,
      };
}

class UserData extends ChangeNotifier {
  UserData({
    this.profileUrl,
    this.status,
    this.isActive,
    this.wallet,
    this.id,
    this.userType,
    this.name,
    this.email,
    this.phone,
    this.govtId,
    this.address,
    this.categoryId,
    this.locationId,
    this.partner_id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
  UserData currentUser;
  final String profileUrl;
  final bool status;
  final bool isActive;
  final String wallet;
  final String id;
  final String userType;
  final String name;
  final String partner_id;
  final String email;
  final String phone;
  final List<GovtId> govtId;
  final List<Address> address;
  final CategoryId categoryId;
  final String locationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        profileUrl: json["profileUrl"] == null ? null : json["profileUrl"],
        status: json["status"] == null ? null : json["status"],
        partner_id: json["partner_id"] == null ? null : json["partner_id"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        wallet: json["wallet"] == null ? null : json["wallet"],
        id: json["_id"] == null ? null : json["_id"],
        userType: json["user_type"] == null ? null : json["user_type"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        govtId: json["govtId"] == null
            ? null
            : List<GovtId>.from(json["govtId"].map((x) => GovtId.fromMap(x))),
        address: json["address"] == null
            ? null
            : List<Address>.from(
                json["address"].map((x) => Address.fromMap(x))),
        categoryId: json["category_id"] == null
            ? null
            : CategoryId.fromMap(
                {},
              ),
        locationId: json["locationId"] == null ? null : json["locationId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "profileUrl": profileUrl == null ? null : profileUrl,
        "status": status == null ? null : status,
        "isActive": isActive == null ? null : isActive,
        "wallet": wallet == null ? null : wallet,
        "_id": id == null ? null : id,
        "user_type": userType == null ? null : userType,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "govtId": govtId == null
            ? null
            : List<dynamic>.from(govtId.map((x) => x.toMap())),
        "address": address == null
            ? null
            : List<dynamic>.from(address.map((x) => x.toMap())),
        // "category_id": categoryId == null ? null : categoryId.toMap(),
        "locationId": locationId == null ? null : locationId,
        // "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        // "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}

class Address {
  Address({
    this.id,
    this.addressLine,
    this.city,
    this.state,
    this.zipCode,
  });

  final String id;
  final String addressLine;
  final String city;
  final String state;
  final String zipCode;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["_id"] == null ? null : json["_id"],
        addressLine: json["addressLine"] == null ? null : json["addressLine"],
        city: json["city"] == null ? null : json["city"],
        zipCode: json["zipCode"] == null ? null : json["zipCode"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toMap() => {
        // "_id": id == null ? null : id,
        "zip": zipCode == null ? "" : zipCode,
        "addressLine": addressLine == null ? null : addressLine,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
      };
}

class CategoryId {
  CategoryId({
    this.id,
    this.categoryName,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isActive,
  });

  final String id;
  final String categoryName;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isActive;

  factory CategoryId.fromJson(String str) =>
      CategoryId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryId.fromMap(Map<String, dynamic> json) => CategoryId(
        id: json["_id"] == null ? null : json["_id"],
        categoryName:
            json["categoryName"] == null ? null : json["categoryName"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        isActive: json["isActive"] == null ? null : json["isActive"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "categoryName": categoryName == null ? null : categoryName,
        "description": description == null ? null : description,
        "imageURL": imageUrl == null ? null : imageUrl,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "isActive": isActive == null ? null : isActive,
      };
}

class GovtId {
  GovtId({
    this.id,
    this.cardType,
    this.cardNumber,
    this.frontImageUrl,
    this.rearImageUrl,
  });

  final String id;
  final String cardType;
  final String cardNumber;
  final String frontImageUrl;
  final String rearImageUrl;

  factory GovtId.fromJson(String str) => GovtId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GovtId.fromMap(Map<String, dynamic> json) => GovtId(
        id: json["_id"] == null ? null : json["_id"],
        cardType: json["cardType"] == null ? null : json["cardType"],
        cardNumber: json["cardNumber"] == null ? null : json["cardNumber"],
        frontImageUrl:
            json["frontImageURL"] == null ? null : json["frontImageURL"],
        rearImageUrl:
            json["rearImageURL"] == null ? null : json["rearImageURL"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "cardType": cardType == null ? null : cardType,
        "cardNumber": cardNumber == null ? null : cardNumber,
        "frontImageURL": frontImageUrl == null ? null : frontImageUrl,
        "rearImageURL": rearImageUrl == null ? null : rearImageUrl,
      };
}
