import 'package:athome_partner_app/helpers/hex_color.dart';
import 'package:athome_partner_app/model/transactionData.dart';
import 'package:athome_partner_app/model/walletpay.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class TransactionScreen extends StatefulWidget {
  TransactionScreen({Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false, searchTap = false;
  // List<BannerData> bannerData = [];
  getData() async {
    // if(isLoad)
    showLoading();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String phone = await prefs.getString("partner_id");
    String userId = await prefs.getString("id");

    print(transactionEndPoint + userId);
    Map bannerRes = await ApiServices.getRequest(transactionEndPoint + userId);
    print("llllllllog${bannerRes} " + transactionEndPoint + phone);
    if (bannerRes != null) {
      print("res is not null for trans ${bannerRes["isSuccess"]}");
      if (bannerRes["isSuccess"]) {
        //print("status is true");
        setState(() {
          orderData = List<TransactionData>.from(
              bannerRes["data"].map((x) => TransactionData.fromMap(x)));
        });
        print(orderData.length);
        stopLoading();
      }
      stopLoading();
    } else {
      stopLoading();
    }
  }

  List<TransactionData> orderData = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            separatorBuilder: (context, sIndex) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  height: 2,
                  // thickness: 2,
                ),
              );
            },
            // physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            shrinkWrap: true,
            itemCount: orderData.length,
            itemBuilder: (context, cartIndex) {
              // AddonsData additem = item?.cartaddonsData[addIndex];
              TransactionData additem = orderData[cartIndex];
              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => BookingDetail(
                  //           orderData: orderData[cartIndex]),
                  //     ));
                },
                child: Card(
                  child: ListTile(
                    title: SizedBox(
                        width: SizeConfig.w * 0.55,
                        child: Text(
                          additem?.order?.id ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: primaryColor),
                        )),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            additem.paymentStatus,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    additem.paymentStatus.toString() != "debit"
                                        ? Colors.red
                                        : Colors.green),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            DateFormat('MM/dd/yyyy')
                                .format(additem.createdAt)
                                .toString(),
                            style: TextStyle(fontSize: 14, color: primaryColor),
                          ),
                        ]),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getPrice(
                              // double.parse(
                              additem.amount
                              // )

                              ),
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getPrice(double.parse(
                            additem.order.totalAmount,
                          )),
                          //   //   style: TextStyle(
                          //   //       fontSize: 14,
                          //   //       fontWeight: FontWeight.w600,
                          //   //       color: additem.orderStatus.toString() ==
                          //   //               "CANCELLED"
                          //   //           ? Colors.red
                          //   //           : additem.orderStatus.toString() ==
                          //   //                   "ORDER BOOKED"
                          //   //               ? Colors.orange
                          //   //               : Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
