// To parse this JSON data, do
//
//     final dashboardData = dashboardDataFromMap(jsonString);

import 'dart:convert';

class DashboardData {
  DashboardData({
    this.isSuccess,
    this.dashBoardCategory,
  });

  final bool isSuccess;
  final List<DashBoardCategory> dashBoardCategory;

  factory DashboardData.fromJson(String str) =>
      DashboardData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DashboardData.fromMap(Map<String, dynamic> json) => DashboardData(
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
        dashBoardCategory: json["categories"] == null
            ? null
            : List<DashBoardCategory>.from(
                json["categories"].map((x) => DashBoardCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "isSuccess": isSuccess == null ? null : isSuccess,
        "categories": dashBoardCategory == null
            ? null
            : List<dynamic>.from(dashBoardCategory.map((x) => x.toMap())),
      };
}

class DashBoardCategory {
  DashBoardCategory({
    this.id,
    this.categoryName,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isActive,
    this.subCategories,
  });

  final String id;
  final String categoryName;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isActive;
  final List<SubCategory> subCategories;

  factory DashBoardCategory.fromJson(String str) =>
      DashBoardCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DashBoardCategory.fromMap(Map<String, dynamic> json) =>
      DashBoardCategory(
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
        subCategories: json["subCategories"] == null
            ? null
            : List<SubCategory>.from(
                json["subCategories"].map((x) => SubCategory.fromMap(x))),
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
        "subCategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories.map((x) => x.toMap())),
      };
}


class SubCategory {
  SubCategory({
    this.id,
    this.categoryId,
    this.subCategoryName,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isActive,
    this.videoUrl,
  });

  final String id;
  final String categoryId;
  final String subCategoryName;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isActive;
  final String videoUrl;

  factory SubCategory.fromJson(String str) =>
      SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        id: json["_id"] == null ? null : json["_id"],
        categoryId: json["category_id"] == null
            ? null
            : json["category_id"],
        subCategoryName:
            json["subCategoryName"] == null ? null : json["subCategoryName"],
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
        videoUrl: json["videoURL"] == null ? null : json["videoURL"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "subCategoryName": subCategoryName == null ? null : subCategoryName,
        "description": description == null ? null : description,
        "imageURL": imageUrl == null ? null : imageUrl,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "isActive": isActive == null ? null : isActive,
        "videoURL": videoUrl == null ? null : videoUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
