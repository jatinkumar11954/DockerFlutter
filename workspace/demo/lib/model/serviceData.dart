// // To parse this JSON data, do
// //
// //     final service = serviceFromMap(jsonString);

// import 'dart:convert';

// import 'package:flutter/widgets.dart';

// class Service extends ChangeNotifier {
//   Service({
//     this.message,
//     this.subCatData,
//     this.servicesData,
//     this.addonsData,
//     this.isSuccess,
//   });

//   final String message;
//   final SubCatData subCatData;
//   final List<ServicesData> servicesData;
//   List<ServicesData> currentData;
//   List<ServicesData> _cartData;
//   List<ServicesData> get cartData => _cartData;
//   List<AddonsData> addonsData;
//   List<AddonsData> cartaddonsData;
//   final bool isSuccess;
//   double _totalPrice;
//   double get totalPrice => _totalPrice;
//   init() {
//     currentData = [];
//     addonsData = [];
//     cartaddonsData = [];
//     _cartData = [];
//     _totalPrice = 0;
//     notifyListeners();
//   }

//   addQuan(ServicesData q) {
//     print(_cartData?.any((element) => element == q));
//     if (_cartData?.any((element) => element == q) ?? false) {
//       print("inside if of add");
//       print(_cartData.length);
//       int index = _cartData?.indexOf(q);
//       if (_cartData[index].quantity < 10) {
//         print("inside 2nd if of add");

//         currentData[currentData.indexOf(q)].quantity += 1;
//         print(currentData[currentData.indexOf(q)].quantity);
//         _cartData[index] = currentData[currentData.indexOf(q)];

//         print("inside 2nd if of add afer");

//         print(currentData[currentData.indexOf(q)].quantity);
//       }
//       countPrice();
//     } else {
//       print("inside else of add");

//       q.quantity = 1;
//       currentData[currentData.indexOf(q)].quantity = 1;
//       ServicesData n = q;
//       // print(currentData[currentData.indexOf(q)].quantity);
//       _cartData.add(n);
//       countPrice();
//     }
//     notifyListeners();
//   }

//   addAddOn(AddonsData q) {
//     print(cartaddonsData?.any((element) => element == q));
//     if (addonsData?.isNotEmpty ??
//         false) if (cartaddonsData?.any((element) => element == q) ?? false) {
//       print("inside if of add");
//       print(cartaddonsData.length);
//       int index = cartaddonsData?.indexOf(q);
//       if (cartaddonsData[index].quantity < 10) {
//         print("inside 2nd if of add");

//         addonsData[addonsData.indexOf(q)].quantity += 1;
//         print(addonsData[addonsData.indexOf(q)].quantity);
//         cartaddonsData[index] = addonsData[addonsData.indexOf(q)];

//         print("inside 2nd if of add afer");

//         print(addonsData[addonsData.indexOf(q)].quantity);
//       }
//       countPrice();
//     } else {
//       print("inside else of add");

//       q.quantity = 1;
//       addonsData[addonsData.indexOf(q)].quantity = 1;
//       AddonsData n = q;
//       // print(currentData[currentData.indexOf(q)].quantity);
//       cartaddonsData.add(n);
//       countPrice();
//     }
//     notifyListeners();
//   }

//   countPrice() {
//     _totalPrice = 0.0;
//     if (_cartData?.isNotEmpty ?? false) {
//       _cartData.forEach((element) {
//         _totalPrice += (element.quantity *
//             double.parse(element?.offeredPrice ?? element.price ?? "0"));
//       });

//       if (cartaddonsData?.isNotEmpty ?? false)
//         cartaddonsData.forEach((element) {
//           _totalPrice += (element.quantity *
//               double.parse(element?.price ?? element.price ?? "0"));
//         });
//     } else {
//       _totalPrice = 0.0;
//     }
//   }

//   subAddOn(AddonsData q) {
//     if ((cartaddonsData?.contains(q) ?? false) &&
//         (addonsData?.isNotEmpty ?? false)) {
//       print("inside  if of add");

//       int index = cartaddonsData?.indexOf(q);
//       if (cartaddonsData[index].quantity <= 10 &&
//           cartaddonsData[index].quantity >= 1) {
//         addonsData[addonsData.indexOf(q)].quantity -= 1;
//         print("inside 2nd if of add");
//         cartaddonsData[index] = addonsData[addonsData.indexOf(q)];
//         countPrice();
//         if (totalPrice == 0.0) {
//           _cartData = [];
//         }
//       }
//     }
//     notifyListeners();
//   }

//   subQuan(ServicesData q) {
//     if (_cartData?.contains(q) ?? false) {
//       print("inside  if of add");

//       int index = _cartData?.indexOf(q);
//       if (_cartData[index].quantity <= 10 && _cartData[index].quantity >= 1) {
//         currentData[currentData.indexOf(q)].quantity -= 1;
//         print("inside 2nd if of add");
//         _cartData[index] = currentData[currentData.indexOf(q)];
//         countPrice();
//         if (totalPrice == 0.0) {
//           _cartData = [];
//         }
//       }
//     }
//     notifyListeners();
//   }

//   factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Service.fromMap(Map<String, dynamic> json) => Service(
//         message: json["message"] == null ? null : json["message"],
//         subCatData: json["subCatData"] == null
//             ? null
//             : SubCatData.fromMap(json["subCatData"]),
//         servicesData: json["servicesData"] == null
//             ? null
//             : List<ServicesData>.from(
//                 json["servicesData"].map((x) => ServicesData.fromMap(x))),
//         addonsData: json["addonsData"] == null
//             ? null
//             : List<AddonsData>.from(
//                 json["addonsData"].map((x) => AddonsData.fromMap(x))),
//         isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
//       );

//   Map<String, dynamic> toMap() => {
//         "message": message == null ? null : message,
//         "subCatData": subCatData == null ? null : subCatData.toMap(),
//         "servicesData": servicesData == null
//             ? null
//             : List<dynamic>.from(servicesData.map((x) => x.toMap())),
//         "addonsData": addonsData == null
//             ? null
//             : List<dynamic>.from(addonsData.map((x) => x.toMap())),
//         "isSuccess": isSuccess == null ? null : isSuccess,
//       };
// }

// class AddonsData {
//   AddonsData({
//     this.isActive,
//     this.id,
//     this.subCategorieId,
//     this.addOnName,
//     this.price,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.quantity = 0,
//     this.description,
//   });
//   int quantity;
//   final bool isActive;
//   final String id;
//   final String subCategorieId;
//   final String addOnName;
//   final String price;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String description;

//   factory AddonsData.fromJson(String str) =>
//       AddonsData.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory AddonsData.fromMap(Map<String, dynamic> json) => AddonsData(
//         isActive: json["isActive"] == null ? null : json["isActive"],
//         id: json["_id"] == null ? null : json["_id"],
//         quantity: json["_id"] == null ? 0 : json["quantity"],
//         subCategorieId:
//             json["subCategorieId"] == null ? null : json["subCategorieId"],
//         addOnName: json["addOnName"] == null ? null : json["addOnName"],
//         price: json["price"] == null ? null : json["price"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"] == null ? null : json["__v"],
//         description: json["description"] == null ? null : json["description"],
//       );

//   Map<String, dynamic> toMap() => {
//         "isActive": isActive == null ? null : isActive,
//         "_id": id == null ? null : id,
//         "subCategorieId": subCategorieId == null ? null : subCategorieId,
//         "addOnName": addOnName == null ? null : addOnName,
//         "quantity": quantity == null ? null : quantity,
//         "price": price == null ? null : price,
//         "__v": v == null ? null : v,
//         "description": description == null ? null : description,
//       };
// }

// class ServicesData {
//   ServicesData(
//       {this.isActive,
//       this.id,
//       this.subcategoryId,
//       this.serviceName,
//       this.range,
//       this.price,
//       this.time,
//       this.description,
//       this.imageUrl,
//       this.createdAt,
//       this.updatedAt,
//       this.v,
//       this.discount,
//       this.offeredPrice,
//       this.quantity = 0});
//   int quantity;
//   final bool isActive;
//   final String id;
//   final String subcategoryId;
//   final String serviceName;
//   final String range;
//   final String price;
//   final String time;
//   final String description;
//   final String imageUrl;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String discount;
//   final String offeredPrice;

//   factory ServicesData.fromJson(String str) =>
//       ServicesData.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory ServicesData.fromMap(Map<String, dynamic> json) => ServicesData(
//         isActive: json["isActive"] == null ? null : json["isActive"],
//         id: json["_id"] == null ? null : json["_id"],
//         quantity: json["quantity"] == null ? 0 : json["quantity"],
//         subcategoryId:
//             json["subcategory_id"] == null ? null : json["subcategory_id"],
//         serviceName: json["serviceName"] == null ? null : json["serviceName"],
//         range: json["range"] == null ? null : json["range"],
//         price: json["price"] == null ? null : json["price"],
//         time: json["time"] == null ? null : json["time"],
//         description: json["description"] == null ? null : json["description"],
//         imageUrl: json["imageURL"] == null ? null : json["imageURL"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"] == null ? null : json["__v"],
//         discount: json["discount"] == null ? null : json["discount"],
//         offeredPrice:
//             json["offeredPrice"] == null ? null : json["offeredPrice"],
//       );

//   Map<String, dynamic> toMap() => {
//         "isActive": isActive == null ? null : isActive,
//         "_id": id == null ? null : id,
//         "subcategory_id": subcategoryId == null ? null : subcategoryId,
//         "quantity": quantity == null ? null : quantity,
//         "serviceName": serviceName == null ? null : serviceName,
//         "range": range == null ? null : range,
//         "price": price == null ? null : price,
//         "time": time == null ? null : time,
//         "description": description == null ? null : description,
//         "imageURL": imageUrl == null ? null : imageUrl,
//         "__v": v == null ? null : v,
//         "discount": discount == null ? null : discount,
//         "offeredPrice": offeredPrice == null ? null : offeredPrice,
//       };
// }

// class SubCatData {
//   SubCatData({
//     this.id,
//     this.subCategoryName,
//   });

//   final String id;
//   final String subCategoryName;

//   factory SubCatData.fromJson(String str) =>
//       SubCatData.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory SubCatData.fromMap(Map<String, dynamic> json) => SubCatData(
//         id: json["_id"] == null ? null : json["_id"],
//         subCategoryName:
//             json["subCategoryName"] == null ? null : json["subCategoryName"],
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id == null ? null : [id],
//         "subCategoryName": subCategoryName == null ? null : subCategoryName,
//       };
// }
