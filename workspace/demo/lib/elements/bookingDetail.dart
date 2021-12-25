import 'package:athome_partner_app/helpers/hex_color.dart';
import 'package:athome_partner_app/model/orderData.dart';
// import 'package:athome_partner_app/model/serviceData.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class BookingDetail extends StatelessWidget {
  OrderData orderData;
  BookingDetail({Key key, this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back
            ),
            body: SingleChildScrollView(
                child: Column(children: [
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
                      Text("#${orderData.orderId}"),
                      SizedBox(
                        height: SizeConfig.h * 0.25,
                        child: ListView.separated(
                            separatorBuilder: (context, sIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
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
                              Service cartitem = orderData.service[cartIndex];
                              return ListTile(
                                title: SizedBox(
                                    width: SizeConfig.w * 0.55,
                                    child: Text(
                                      cartitem?.serviceName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14),
                                    )),
                                subtitle: Text(
                                  cartitem.quantity.toString() +
                                      " x " +
                                      getPrice(double.parse(
                                        cartitem?.offeredPrice ?? " ",
                                      )).toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: primaryColor),
                                ),
                                trailing: Text(
                                  getPrice(double.parse(
                                                cartitem?.offeredPrice ?? " ",
                                              ) *
                                              cartitem?.quantity ??
                                          " ")
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: primaryColor),
                                ),
                              );
                            }),
                      ),
                      orderData.addOns?.isNotEmpty ?? false
                          ? Column(
                              children: [
                                Text("Add Ons"),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: SizeConfig.h * 0.1,
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
                                      itemCount: orderData.addOns?.length ?? 0,
                                      itemBuilder: (context, cartIndex) {
                                        // AddonsData additem = item?.cartaddonsData[addIndex];
                                        AddOn additem =
                                            orderData.addOns[cartIndex];
                                        return ListTile(
                                          title: SizedBox(
                                              width: SizeConfig.w * 0.55,
                                              child: Text(
                                                additem.addOnName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 14),
                                              )),
                                          subtitle: Text(
                                            additem?.quantity.toString() +
                                                " x " +
                                                getPrice(double.parse(
                                                  additem?.price ?? "0",
                                                )).toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: primaryColor),
                                          ),
                                          trailing: Text(
                                            getPrice(double.parse(
                                                      (additem?.price ?? "1"),
                                                    ) *
                                                    (additem?.quantity ?? "1"))
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
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 5),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total"),
                            Text(
                              getPrice(double.parse(
                                      orderData?.totalAmount ?? "0"))
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 16, color: primaryColor),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 8.0, right: 8, bottom: 15),
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(8.0),
                margin: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address:",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(orderData?.address?.addressLine ?? ""),
                        Text(orderData?.address?.city ?? ""),
                        // Text(orderData?.address?.zipCode ?? ""),
                        Text(orderData?.address?.state ?? ""),
                      ],
                    ),
                  ),
                ),
              ),
            ]))));
  }
}
