// To parse this JSON data, do
//
//     final categoryData = categoryDataFromMap(jsonString);

import 'dart:convert';

class CategoryData {
    CategoryData({
        this.isSuccess,
        this.category,
    });

    final bool isSuccess;
    final List<Category> category;

    factory CategoryData.fromJson(String str) => CategoryData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CategoryData.fromMap(Map<String, dynamic> json) => CategoryData(
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
        category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "isSuccess": isSuccess == null ? null : isSuccess,
        "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toMap())),
    };
}

class Category {
    Category({
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

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"] == null ? null : json["_id"],
        categoryName: json["categoryName"] == null ? null : json["categoryName"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
