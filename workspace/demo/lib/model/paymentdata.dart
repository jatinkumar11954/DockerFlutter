// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromMap(jsonString);

import 'dart:convert';

class PaymentModel {
    PaymentModel({
        this.message,
        this.paymentData,
        this.isSuccess,
    });

    final String message;
    final PaymentData paymentData;
    final bool isSuccess;

    factory PaymentModel.fromJson(String str) => PaymentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
        message: json["message"] == null ? null : json["message"],
        paymentData: json["paymentData"] == null ? null : PaymentData.fromMap(json["paymentData"]),
        isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    );

    Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "paymentData": paymentData == null ? null : paymentData.toMap(),
        "isSuccess": isSuccess == null ? null : isSuccess,
    };
}

class PaymentData {
    PaymentData({
        this.udf5,
        this.surl,
        this.furl,
        this.curl,
        this.key,
        this.amount,
        this.productinfo,
        this.firstname,
        this.lastname,
        this.email,
        this.phone,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.pg,
        this.hash,
        this.txnid,
        this.submitUrl,
    });

    final String udf5;
    final String surl;
    final String furl;
    final String curl;
    final String key;
    final String amount;
    final String productinfo;
    final String firstname;
    final String lastname;
    final String email;
    final String phone;
    final String address1;
    final String address2;
    final String city;
    final String state;
    final String country;
    final String pg;
    final String hash;
    final String txnid;
    final String submitUrl;

    factory PaymentData.fromJson(String str) => PaymentData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentData.fromMap(Map<String, dynamic> json) => PaymentData(
        udf5: json["udf5"] == null ? null : json["udf5"],
        surl: json["surl"] == null ? null : json["surl"],
        furl: json["furl"] == null ? null : json["furl"],
        curl: json["curl"] == null ? null : json["curl"],
        key: json["key"] == null ? null : json["key"],
        amount: json["amount"] == null ? null : json["amount"],
        productinfo: json["productinfo"] == null ? null : json["productinfo"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        address1: json["address1"] == null ? null : json["address1"],
        address2: json["address2"] == null ? null : json["address2"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        pg: json["Pg"] == null ? null : json["Pg"],
        hash: json["hash"] == null ? null : json["hash"],
        txnid: json["txnid"] == null ? null : json["txnid"],
        submitUrl: json["submit_url"] == null ? null : json["submit_url"],
    );

    Map<String, dynamic> toMap() => {
        "udf5": udf5 == null ? null : udf5,
        "surl": surl == null ? null : surl,
        "furl": furl == null ? null : furl,
        "curl": curl == null ? null : curl,
        "key": key == null ? null : key,
        "amount": amount == null ? null : amount,
        "productinfo": productinfo == null ? null : productinfo,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "address1": address1 == null ? null : address1,
        "address2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "Pg": pg == null ? null : pg,
        "hash": hash == null ? null : hash,
        "txnid": txnid == null ? null : txnid,
        "submit_url": submitUrl == null ? null : submitUrl,
    };
}
