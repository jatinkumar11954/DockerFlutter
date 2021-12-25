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

class WalletWidget extends StatefulWidget {
  WalletWidget({Key key}) : super(key: key);

  @override
  _WalletWidgetState createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  List<WalletPayment> orderData = [];

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
    print(phone + "--partner id");

    Map bannerRes = await ApiServices.getRequest(paymentEndPoint + phone);
    // //print("llllllllog${bannerRes}");
    if (bannerRes != null) {
      //print("res is not null ${bannerRes["isSuccess"]}");
      if (bannerRes["isSuccess"]) {
        //print("status is true");
        orderData = List<WalletPayment>.from(
            bannerRes["data"].map((x) => WalletPayment.fromMap(x)));
        print(orderData.length);
        stopLoading();
      }
      stopLoading();
    } else {
      stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
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
            itemCount: orderData?.length ?? 0,
            itemBuilder: (context, cartIndex) {
              // AddonsData additem = item?.cartaddonsData[addIndex];
              WalletPayment additem = orderData[cartIndex];
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
                          additem?.txnid ?? "",
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
                          additem?.paymentType ?? "",
                          style: TextStyle(fontSize: 14, color: primaryColor),
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
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getPrice(double.parse(additem?.amount ?? "")),
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                        Text(
                          additem?.status ?? "",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: additem.status.toString() == "failure"
                                  ? Colors.red
                                  // : additem.status.toString() ==
                                  //         "ORDER BOOKED"
                                  //     ? Colors.orange
                                  : Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
