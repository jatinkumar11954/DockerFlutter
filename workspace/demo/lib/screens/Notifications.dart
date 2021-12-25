import 'package:athome_partner_app/elements/bookingDetail.dart';
import 'package:athome_partner_app/elements/bottomNavBar.dart';
import 'package:athome_partner_app/elements/items/customappBar.dart';
import 'package:athome_partner_app/helpers/hex_color.dart';
import 'package:athome_partner_app/model/notificationData.dart';
import 'package:athome_partner_app/model/orderData.dart';
import 'package:athome_partner_app/screens/orderScreen.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<NotificationData> orderData = [];

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false, searchTap = false;
  // List<BannerData> bannerData = [];
  getData() async {
    showLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = await prefs.getString("id");
    Map bannerRes = await ApiServices.getRequest(notificationEndPoint + userId);
    // //print("llllllllog${bannerRes}");
    if (bannerRes != null) {
      print("res is not null ${bannerRes}");
      if (bannerRes["isSuccess"]) {
        //print("status is true");
        orderData = List<NotificationData>.from(
            bannerRes["data"].map((x) => NotificationData.fromMap(x)));
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
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, "/HomeScreen");
        return Future.value(true);
      },
      child: Scaffold(
        // bottomNavigationBar: BottomNavBar(index: 1),
        backgroundColor: Colors.white,
        appBar: BackAppBar(context, "Notifications"),

        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: orderData?.length == 0
                    ? Center(
                        child: Text("No Bookings Yet!"),
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
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                        shrinkWrap: true,
                        itemCount: orderData?.length ?? 0,
                        itemBuilder: (context, cartIndex) {
                          // AddonsData additem = item?.cartaddonsData[addIndex];
                          NotificationData additem = orderData[cartIndex];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderScreen(
                                        notificationData: orderData[cartIndex]),
                                  ));
                            },
                            child: Card(
                              child: ListTile(
                                title: SizedBox(
                                    width: SizeConfig.w * 0.55,
                                    child: Text(
                                      additem.orderId.service[0].serviceName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14, color: primaryColor),
                                    )),
                                subtitle: Text(
                                  additem.slot.toString().replaceAll("_", "  "),
                                  style: TextStyle(
                                      fontSize: 14, color: primaryColor),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      getPrice(double.parse(
                                        additem.orderId.totalAmount,
                                      )).toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: primaryColor),
                                    ),
                                    Text(
                                      additem.orderId.orderStatus.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: additem.orderId.orderStatus
                                                      .toString() ==
                                                  "CANCELLED"
                                              ? Colors.red
                                              : additem.orderId.orderStatus
                                                          .toString() ==
                                                      "ORDER BOOKED"
                                                  ? Colors.orange
                                                  : Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
      ),
    );
  }
}
