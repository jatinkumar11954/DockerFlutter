import 'dart:convert';

import 'package:athome_partner_app/helpers/hex_color.dart';
import 'package:athome_partner_app/model/notificationData.dart';
import 'package:athome_partner_app/model/orderData.dart';
import 'package:athome_partner_app/model/serviceData.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class OrderScreen extends StatefulWidget {
  NotificationData notificationData;
  OrderId newOrderData;
  OrderScreen({
    Key key,
    this.notificationData,
    this.newOrderData,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderId orderData;

  @override
  void initState() {
    super.initState();

    getNotification();
  }

  getNotification() async {
    showLoading();
    if (widget.notificationData == null) {
      print("inside normal");

      orderData = widget.newOrderData;
      print("inside normal order id");

      print(orderData.id);
    } else {
      print("inside notification");
      orderData = widget.notificationData.orderId;
      print("inside notification order id");

      print(orderData.id);
    }
    Map bannerRes =
        await ApiServices.getRequest(NotificationEndPoint + orderData.id);
    print("llllllllog of notification${bannerRes}");
    if (bannerRes != null) {
      print("res is not null ${bannerRes}");
      if (bannerRes["isSuccess"]) {
        print("status is true");
        print(bannerRes["data"]);
        setState(() {
          orderData = OrderId.fromMap(bannerRes["data"]);
        });
        stopLoading();
      }
      stopLoading();
    } else {
      stopLoading();
    }
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false, searchTap = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<UserData>(builder: (context, user, i) {
      return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, "/Notifications");
          return Future.value(true);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/Notifications"),
              ),
            ),
            body: SingleChildScrollView(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Order Details"),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: SizeConfig.h * 0.25,
                                  child: ListView.separated(
                                      separatorBuilder: (context, sIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Divider(
                                            height: 2,
                                            thickness: 2,
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      itemCount: orderData.service?.length ?? 0,
                                      itemBuilder: (context, cartIndex) {
                                        // AddonsData additem = item?.cartaddonsData[addIndex];
                                        Service cartitem =
                                            orderData.service[cartIndex];
                                        return ListTile(
                                          title: SizedBox(
                                              width: SizeConfig.w * 0.55,
                                              child: Text(
                                                cartitem.serviceName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 14),
                                              )),
                                          subtitle: Text(
                                            cartitem.quantity.toString() +
                                                " x " +
                                                getPrice(double.parse(
                                                  cartitem.offeredPrice,
                                                )).toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primaryColor),
                                          ),
                                          trailing: Text(
                                            getPrice(double.parse(
                                                      cartitem.offeredPrice,
                                                    ) *
                                                    cartitem.quantity)
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primaryColor),
                                          ),
                                        );
                                      }),
                                ),
                                orderData.addOns?.isNotEmpty ?? false
                                    ? Column(
                                        children: [
                                          Text("Add On"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: SizeConfig.h * 0.1,
                                            child: ListView.separated(
                                                separatorBuilder:
                                                    (context, sIndex) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8),
                                                    child: Divider(
                                                      height: 2,
                                                      thickness: 2,
                                                    ),
                                                  );
                                                },
                                                shrinkWrap: true,
                                                itemCount:
                                                    orderData.addOns?.length ??
                                                        0,
                                                itemBuilder:
                                                    (context, cartIndex) {
                                                  // AddonsData additem = item?.cartaddonsData[addIndex];
                                                  AddOn additem = orderData
                                                      .addOns[cartIndex];
                                                  return ListTile(
                                                    title: SizedBox(
                                                        width:
                                                            SizeConfig.w * 0.55,
                                                        child: Text(
                                                          additem.addOnName,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        )),
                                                    subtitle: Text(
                                                      additem.quantity
                                                              .toString() +
                                                          " x " +
                                                          getPrice(double.parse(
                                                            additem.price,
                                                          )).toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: primaryColor),
                                                    ),
                                                    trailing: Text(
                                                      getPrice(double.parse(
                                                                additem.price,
                                                              ) *
                                                              additem.quantity)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: primaryColor),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : orderData.orderStatus == "ORDER BOOKED"
                                ? Container(//cancelByPartner: false, orderStatus: ORDER BOOKED, isActive: true, _id: 61acc9e1ff773e25575d7ada, amount: 1000, discountAmount: 300, categorieId: 6049e3b5e

                                    margin: EdgeInsets.all(6),
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: Colors.green[800],
                                    ),
                                    child: Center(
                                      child: TextButton(
                                          onPressed: () async {
                                            print("candidate id");
                                            print(user.currentUser.id);
                                            print("notification id");
                                            print(orderData.id);
                                            print(confirmOrderEndPoint);
                                            Map data = {
                                              "partnerId": user.currentUser.id,
                                              "orderId": orderData.id
                                            };
                                            showLoading();
                                            Map bannerRes =
                                                await ApiServices.putRequest(
                                                    json.encode(data),
                                                    confirmOrderEndPoint);
                                            print("llllllllog${bannerRes}");
                                            if (bannerRes != null) {
                                              print(
                                                  "res is not null ${bannerRes}");
                                              if (bannerRes["isSuccess"] ??
                                                  false) {
                                                //print("status is true");
                                                // orderData = List<NotificationData>.from(
                                                Fluttertoast.showToast(
                                                  msg: bannerRes["message"] ??
                                                      "Order Confirmed",
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 3,
                                                );
                                                Navigator.pushReplacementNamed(
                                                    context, "/Orders");
                                                //     bannerRes["data"].map((x) => NotificationData.fromMap(x)));
                                                stopLoading();
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg: bannerRes["message"] ??
                                                      "Order not confirmed",
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 3,
                                                );
                                              }
                                              if (mounted) stopLoading();
                                            } else {
                                              if (mounted) stopLoading();
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.check,
                                                  color: Colors.white),
                                              Text(
                                                "Accept",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ))
                                : Container()
                      ],
                    ),
            ),
          ),
        ),
      );
    }); //user con
  }
}
