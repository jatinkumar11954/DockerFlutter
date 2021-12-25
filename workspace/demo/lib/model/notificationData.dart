// To parse this JSON data, do
//
//     final notification = notificationFromMap(jsonString);

import 'dart:convert';

import 'package:athome_partner_app/model/orderData.dart';

class Notification {
  Notification({
    this.message,
    this.data,
    this.isSuccess,
  });

  final String message;
  final List<NotificationData> data;
  final bool isSuccess;

  factory Notification.fromJson(String str) =>
      Notification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromMap(x))),
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
        "isSuccess": isSuccess == null ? null : isSuccess,
      };
}

class NotificationData {
  NotificationData({
    this.isActive,
    this.id,
    this.workerId,
    this.orderId,
    this.slot,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final bool isActive;
  final String id;
  final String workerId;
  final OrderId orderId;
  final DateTime slot;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory NotificationData.fromJson(String str) =>
      NotificationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationData.fromMap(Map<String, dynamic> json) =>
      NotificationData(
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["_id"] == null ? null : json["_id"],
        workerId: json["workerId"] == null ? null : json["workerId"],
        orderId:
            json["orderId"] == null ? null : OrderId.fromMap(json["orderId"]),
        slot: json["slot"] == null ? null : DateTime.parse(json["slot"]),
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
        "workerId": workerId == null ? null : workerId,
        "orderId": orderId == null ? null : orderId.toMap(),
        "slot": slot == null ? null : slot.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}

class OrderId {
  OrderId({
    this.service,
    this.addOns,
    this.cancelByAdmin,
    this.cancelByCustomer,
    this.cancelByPartner,
    this.orderStatus,
    this.isActive,
    this.id,
    this.amount,
    this.discountAmount,
    this.categorieId,
    this.slot,
    this.totalAmount,
    this.userId,
    this.bookingDate,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.workerId,
    this.cancelBy,
  });

  final List<Service> service;
  final List<AddOn> addOns;
  final bool cancelByAdmin;
  final bool cancelByCustomer;
  final bool cancelByPartner;
  final String orderStatus;
  final bool isActive;
  final String id;
  final String amount;
  final String discountAmount;
  final String categorieId;
  final String slot;
  final String totalAmount;
  final String userId;
  final DateTime bookingDate;
  final String orderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final dynamic workerId;
  final String cancelBy;

  factory OrderId.fromJson(String str) => OrderId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderId.fromMap(Map<String, dynamic> json) => OrderId(
        service: json["service"] == null
            ? null
            : List<Service>.from(
                json["service"].map((x) => Service.fromMap(x))),
        addOns: json["addOns"] == null
            ? null
            : List<AddOn>.from(json["addOns"].map((x) => AddOn.fromMap(x))),
        cancelByAdmin:
            json["cancelByAdmin"] == null ? null : json["cancelByAdmin"],
        cancelByCustomer:
            json["cancelByCustomer"] == null ? null : json["cancelByCustomer"],
        cancelByPartner:
            json["cancelByPartner"] == null ? null : json["cancelByPartner"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["_id"] == null ? null : json["_id"],
        amount: json["amount"] == null ? null : json["amount"],
        discountAmount:
            json["discountAmount"] == null ? null : json["discountAmount"],
        categorieId: json["categorieId"] == null ? null : json["categorieId"],
        slot: json["slot"] == null ? null : json["slot"],
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        // userId: json["userId"] == null ? null : json["userId"],
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        orderId: json["orderId"] == null ? null : json["orderId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        workerId: json["workerId"],
        cancelBy: json["cancelBy"] == null ? null : json["cancelBy"],
      );

  Map<String, dynamic> toMap() => {
        "service": service == null
            ? null
            : List<dynamic>.from(service.map((x) => x.toMap())),
        "addOns": addOns == null
            ? null
            : List<dynamic>.from(addOns.map((x) => x.toMap())),
        "cancelByAdmin": cancelByAdmin == null ? null : cancelByAdmin,
        "cancelByCustomer": cancelByCustomer == null ? null : cancelByCustomer,
        "cancelByPartner": cancelByPartner == null ? null : cancelByPartner,
        "orderStatus": orderStatus == null ? null : orderStatus,
        "isActive": isActive == null ? null : isActive,
        "_id": id == null ? null : id,
        "amount": amount == null ? null : amount,
        "discountAmount": discountAmount == null ? null : discountAmount,
        "categorieId": categorieId == null ? null : categorieId,
        "slot": slot == null ? null : slot,
        "totalAmount": totalAmount == null ? null : totalAmount,
        "userId": userId == null ? null : userId,
        "bookingDate":
            bookingDate == null ? null : bookingDate.toIso8601String(),
        "orderId": orderId == null ? null : orderId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "workerId": workerId,
        "cancelBy": cancelBy == null ? null : cancelBy,
      };
}
