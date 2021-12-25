// To parse this JSON data, do
//
//     final payment = paymentFromMap(jsonString);

import 'dart:convert';

class Payment {
  Payment({
    this.message,
    this.data,
    this.isSuccess,
  });

  final String message;
  final List<WalletPayment> data;
  final bool isSuccess;

  factory Payment.fromJson(String str) => Payment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<WalletPayment>.from(
                json["data"].map((x) => WalletPayment.fromMap(x))),
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

class WalletPayment {
  WalletPayment({
    this.id,
    this.txnid,
    this.status,
    this.amount,
    this.paymentType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String id;
  final String txnid;
  final String status;
  final String amount;
  final String paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory WalletPayment.fromJson(String str) =>
      WalletPayment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WalletPayment.fromMap(Map<String, dynamic> json) => WalletPayment(
        id: json["_id"] == null ? null : json["_id"],
        txnid: json["txnID"] == null ? null : json["txnID"],
        status: json["status"] == null ? null : json["status"],
        amount: json["amount"] == null ? null : json["amount"],
        paymentType: json["paymentMode"] == null ? null : json["paymentMode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "txnID": txnid == null ? null : txnid,
        "partner": status == null ? null : status,
        "amount": amount == null ? null : amount,
        "paymentType": paymentType == null ? null : paymentType,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
