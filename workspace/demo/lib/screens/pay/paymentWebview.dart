import 'dart:convert';

import 'package:athome_partner_app/model/paymentdata.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class paymentWebview extends StatefulWidget {
  String userId;
  int amount;

  paymentWebview({
    Key key,
    this.amount,
    this.userId,
  }) : super(key: key);

  @override
  _paymentWebviewState createState() => _paymentWebviewState();
}

class _paymentWebviewState extends State<paymentWebview> {
  InAppWebViewController webView;
  @override
  void initState() {
    super.initState();
  }

  // getpayment() async {
  //   Map res = await ApiServices.postRequest(
  //       json.encode(param), "https://test.payu.in/_payment");
  //   if (res != null) {
  //     print("res is not null ${res["data"]}");
  //     if (res["isSuccess"]) {
  //       print("status is true");
  //       print("res is not null $res");

  //       Fluttertoast.showToast(
  //         msg: "Order Placed Successfully!!",
  //         backgroundColor: Colors.grey[400],
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 3,
  //       );
  //     }
  //   }
  // }

  Map param;

  @override
  Widget build(BuildContext context) {
    print(
        "${baseUrl}api/recharge/paypai?id=${widget?.userId ?? " "}&amount=${widget?.amount ?? 1}&type=MOBILE");
    //5123456789012346
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, "/Wallet");
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 25,
            backgroundColor: Colors.white,
            // leading: Container(),
            elevation: 0,
            title: Text(
              "Payment Gateway",
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontFamily: "QuickSand",
                    fontWeight: FontWeight.w800,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "${baseUrl}api/recharge/paypai?id=${widget?.userId ?? " "}&amount=${widget?.amount ?? 1}&type=MOBILE"),
                ),
                // initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        // cacheEnabled: true,
                        javaScriptEnabled: true
                        //debuggingEnabled: true,
                        )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                  controller.clearCache();
                  // controller.
                  controller.addJavaScriptHandler(
                      handlerName: "PAYMENT_SUCCESS",
                      callback: (args) async {
                        // Here you receive all the arguments from the JavaScript side
                        // that is a List<dynamic>
                        print("From the JavaScript side:");
                        // print(args[0]);
                        // Navigator.pop(context);

                        if (widget?.userId != null) {
                          Map res = await ApiServices.getRequest(
                              getUserEndPoint + "/" + widget?.userId ?? " ");
                          print("llllllllog${res}");
                          if (res != null) {
                            print("res is not null ${res["isSuccess"]}");
                            if (res["isSuccess"]) {
                              print("status is true");
                              print(res["data"]);
                              // stopLoading();
                              // SharedPreferences prefs = await SharedPreferences.getInstance();

                              // await prefs.setString("token", res["token"]);
                              Provider.of<UserData>(context, listen: false)
                                  .currentUser = UserData.fromMap(res["data"]);
                              // print(res["token"]);
                            }
                          }
                        }
                        Navigator.pushReplacementNamed(context, "/Wallet");
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (_) => OrderConfirmation(
                        //           fromPayment: true,
                        //           transaction: args[1],
                        //           ssREf: args[2],
                        //           orderIds: json.decode(args[0]),
                        //         )));
                        return "ok";
                      });
                  controller.addJavaScriptHandler(
                      handlerName: "PAYMENT_FAILURE",
                      callback: (args) {
                        // Here you receive all the arguments from the JavaScript side
                        // that is a List<dynamic>
                        print("From the payment failed");
                        print(args);
                        // Navigator.pushNamed(context, "/Wallet");

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            // insetPadding:  EdgeInsets.all(20),
                            titlePadding: EdgeInsets.fromLTRB(15, 30, 0, 10),
                            contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                            title: Column(
                              children: <Widget>[
                                Text('Payment has Failed', //red
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(color: Colors.red)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  args[0] ?? "",
                                ), //red
                              ],
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/Wallet");
                                },
                                child: Text('Close',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                            ],
                          ),
                        );
                        return "ok";
                      });
                },

                // onLoadStart: (InAppWebViewController controller, String url) {
                //   setState(() {
                //     this.iframeUrl = url;
                //   });
                // },
                // onLoadStop: (InAppWebViewController controller, String url) async {
                //   setState(() {
                //     this.iframeUrl = url;
                //   });
                // },
                // onProgressChanged: (InAppWebViewController controller, int progress) {
                //   setState(() {
                //     this.progress = progress / 100;
                //   });
                // },admin@123 9988776655
              ),
            ),
          ),
        ));
  }
}
