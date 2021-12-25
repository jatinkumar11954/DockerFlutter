  // To parse this JSON data, do
  //
  //     final TransactionObject = TransactionObjectFromMap(jsonString);

  import 'dart:convert';
  import 'orderData.dart';
  class TransactionObject {
      TransactionObject({
          this.message,
          this.data,
          this.isSuccess,
      });

      final String message;
      final List<TransactionData> data;
      final bool isSuccess;

      factory TransactionObject.fromJson(String str) => TransactionObject.fromMap(json.decode(str));

      String toJson() => json.encode(toMap());

      factory TransactionObject.fromMap(Map<String, dynamic> json) => TransactionObject(
          message: json["message"] == null ? null : json["message"],
          data: json["data"] == null ? null : List<TransactionData>.from(json["data"].map((x) => TransactionData.fromMap(x))),
          isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
      );

      Map<String, dynamic> toMap() => {
          "message": message == null ? null : message,
          "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
          "isSuccess": isSuccess == null ? null : isSuccess,
      };
  }

  class TransactionData {
      TransactionData({
          this.id,
          this.partner,
          this.order,
          this.amount,
          this.paymentStatus,
          this.createdAt,
          this.updatedAt,
          this.v,
      });

      final String id;
      final String partner;
      final Order order;
      final double amount;
      final String paymentStatus;
      final DateTime createdAt;
      final DateTime updatedAt;
      final int v;

      factory TransactionData.fromJson(String str) => TransactionData.fromMap(json.decode(str));

      String toJson() => json.encode(toMap());

      factory TransactionData.fromMap(Map<String, dynamic> json) => TransactionData(
          id: json["_id"] == null ? null : json["_id"],
          partner: json["partner"] == null ? null : json["partner"],
          order: json["order"] == null ? null : Order.fromMap(json["order"]),
          amount: json["amount"] == null ? null : json["amount"].toDouble(),
          paymentStatus: json["paymentStatus"] == null ? null : json["paymentStatus"],
          createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
          updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
          v: json["__v"] == null ? null : json["__v"],
      );

      Map<String, dynamic> toMap() => {
          "_id": id == null ? null : id,
          "partner": partner == null ? null : partner,
          "order": order == null ? null : order.toMap(),
          "amount": amount == null ? null : amount,
          "paymentStatus": paymentStatus == null ? null : paymentStatus,
          "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
          "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
          "__v": v == null ? null : v,
      };
  }

  class Order {
      Order({
          this.address,
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
      });

      final Address address;
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
      final String workerId;

      factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

      String toJson() => json.encode(toMap());

      factory Order.fromMap(Map<String, dynamic> json) => Order(
          address: json["address"] == null ? null : Address.fromMap(json["address"]),
          service: json["service"] == null ? null : List<Service>.from(json["service"].map((x) => Service.fromMap(x))),
          addOns: json["addOns"] == null ? null : List<AddOn>.from(json["addOns"].map((x) => AddOn.fromMap(x))),
          cancelByAdmin: json["cancelByAdmin"] == null ? null : json["cancelByAdmin"],
          cancelByCustomer: json["cancelByCustomer"] == null ? null : json["cancelByCustomer"],
          cancelByPartner: json["cancelByPartner"] == null ? null : json["cancelByPartner"],
          orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
          isActive: json["isActive"] == null ? null : json["isActive"],
          id: json["_id"] == null ? null : json["_id"],
          amount: json["amount"] == null ? null : json["amount"],
          discountAmount: json["discountAmount"] == null ? null : json["discountAmount"],
          categorieId: json["categorieId"] == null ? null : json["categorieId"],
          slot: json["slot"] == null ? null : json["slot"],
          totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
          userId: json["userId"] == null ? null : json["userId"],
          bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
          orderId: json["orderId"] == null ? null : json["orderId"],
          createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
          updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
          v: json["__v"] == null ? null : json["__v"],
          workerId: json["workerId"] == null ? null : json["workerId"],
      );

      Map<String, dynamic> toMap() => {
          "address": address == null ? null : address.toMap(),
          "service": service == null ? null : List<dynamic>.from(service.map((x) => x.toMap())),
          "addOns": addOns == null ? null : List<dynamic>.from(addOns.map((x) => x.toMap())),
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
          "bookingDate": bookingDate == null ? null : bookingDate.toIso8601String(),
          "orderId": orderId == null ? null : orderId,
          "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
          "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
          "__v": v == null ? null : v,
          "workerId": workerId == null ? null : workerId,
      };
  }

  // class AddOn {
  //     AddOn({
  //         this.isActive,
  //         this.id,
  //         this.subCategorieId,
  //         this.addOnName,
  //         this.quantity,
  //         this.price,
  //         this.v,
  //         this.description,
  //     });

  //     final bool isActive;
  //     final String id;
  //     final String subCategorieId;
  //     final String addOnName;
  //     final int quantity;
  //     final String price;
  //     final int v;
  //     final String description;

  //     factory AddOn.fromJson(String str) => AddOn.fromMap(json.decode(str));

  //     String toJson() => json.encode(toMap());

  //     factory AddOn.fromMap(Map<String, dynamic> json) => AddOn(
  //         isActive: json["isActive"] == null ? null : json["isActive"],
  //         id: json["_id"] == null ? null : json["_id"],
  //         subCategorieId: json["subCategorieId"] == null ? null : json["subCategorieId"],
  //         addOnName: json["addOnName"] == null ? null : json["addOnName"],
  //         quantity: json["quantity"] == null ? null : json["quantity"],
  //         price: json["price"] == null ? null : json["price"],
  //         v: json["__v"] == null ? null : json["__v"],
  //         description: json["description"] == null ? null : json["description"],
  //     );

  //     Map<String, dynamic> toMap() => {
  //         "isActive": isActive == null ? null : isActive,
  //         "_id": id == null ? null : id,
  //         "subCategorieId": subCategorieId == null ? null : subCategorieId,
  //         "addOnName": addOnName == null ? null : addOnName,
  //         "quantity": quantity == null ? null : quantity,
  //         "price": price == null ? null : price,
  //         "__v": v == null ? null : v,
  //         "description": description == null ? null : description,
  //     };
  // }

  // class Address {
  //     Address({
  //         this.addressLine,
  //         this.city,
  //         this.state,
  //         this.zipCode,
  //     });

  //     final String addressLine;
  //     final String city;
  //     final String state;
  //     final String zipCode;

  //     factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  //     String toJson() => json.encode(toMap());

  //     factory Address.fromMap(Map<String, dynamic> json) => Address(
  //         addressLine: json["addressLine"] == null ? null : json["addressLine"],
  //         city: json["city"] == null ? null : json["city"],
  //         state: json["state"] == null ? null : json["state"],
  //         zipCode: json["zipCode"] == null ? null : json["zipCode"],
  //     );

  //     Map<String, dynamic> toMap() => {
  //         "addressLine": addressLine == null ? null : addressLine,
  //         "city": city == null ? null : city,
  //         "state": state == null ? null : state,
  //         "zipCode": zipCode == null ? null : zipCode,
  //     };
  // }

  // class Service {
  //     Service({
  //         this.isActive,
  //         this.id,
  //         this.subcategoryId,
  //         this.quantity,
  //         this.serviceName,
  //         this.range,
  //         this.price,
  //         this.time,
  //         this.description,
  //         this.imageUrl,
  //         this.v,
  //         this.discount,
  //         this.offeredPrice,
  //     });

  //     final bool isActive;
  //     final String id;
  //     final String subcategoryId;
  //     final int quantity;
  //     final String serviceName;
  //     final String range;
  //     final String price;
  //     final String time;
  //     final String description;
  //     final String imageUrl;
  //     final int v;
  //     final String discount;
  //     final String offeredPrice;

  //     factory Service.fromJson(String str) => Service.fromMap(json.decode(str));

  //     String toJson() => json.encode(toMap());

  //     factory Service.fromMap(Map<String, dynamic> json) => Service(
  //         isActive: json["isActive"] == null ? null : json["isActive"],
  //         id: json["_id"] == null ? null : json["_id"],
  //         subcategoryId: json["subcategory_id"] == null ? null : json["subcategory_id"],
  //         quantity: json["quantity"] == null ? null : json["quantity"],
  //         serviceName: json["serviceName"] == null ? null : json["serviceName"],
  //         range: json["range"] == null ? null : json["range"],
  //         price: json["price"] == null ? null : json["price"],
  //         time: json["time"] == null ? null : json["time"],
  //         description: json["description"] == null ? null : json["description"],
  //         imageUrl: json["imageURL"] == null ? null : json["imageURL"],
  //         v: json["__v"] == null ? null : json["__v"],
  //         discount: json["discount"] == null ? null : json["discount"],
  //         offeredPrice: json["offeredPrice"] == null ? null : json["offeredPrice"],
  //     );

  //     Map<String, dynamic> toMap() => {
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
  //     };
  // }
