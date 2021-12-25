import 'dart:convert';

import 'package:athome_partner_app/elements/items/customappBar.dart';
import 'package:athome_partner_app/helpers/hex_color.dart';
import 'package:athome_partner_app/model/paymentdata.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/model/walletpay.dart';
import 'package:athome_partner_app/screens/pay/paymentWebview.dart';
import 'package:athome_partner_app/screens/transaction.dart';
import 'package:athome_partner_app/screens/walletWidget.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Wallet extends StatefulWidget {
  Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
    if (userId != null) {
      Map res =
          await ApiServices.getRequest(getUserEndPoint + "/" + userId ?? " ");
      print("llllllllog${res}");
      if (res != null) {
        print("res is not null ${res["isSuccess"]}");
        if (res["isSuccess"]) {
          print("status is true");
          print(res["data"]);
          // stopLoading();
          // SharedPreferences prefs = await SharedPreferences.getInstance();

          // await prefs.setString("token", res["token"]);
          Provider.of<UserData>(context, listen: false).currentUser =
              UserData.fromMap(res["data"]);
          // print(res["token"]);
        }
      }
    }
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

  int amount;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<UserData>(builder: (context, user, i) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, "/HomeScreen");
            return Future.value(true);
          },
          child: SafeArea(
            child: Scaffold(
              // bottomNavigationBar: BottomNavBar(
              //   index: 0,
              // ),
              backgroundColor: Colors.white,
              appBar: BackAppBar(context, "Your Wallet"),
              body: RefreshIndicator(
                onRefresh: () => getData(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //6666FF
                      //FF8000
                      //FFB732
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        "*10Rs Equal To 1 Credit",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      )),
                      Center(
                          child: Text(
                        "${user?.currentUser?.wallet ?? "0"}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 23),
                      )),

                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.only(top: 15),
                          width: (SizeConfig?.w) * 0.5,
                          height: 40,
                          child: _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                )
                              : RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 0,
                                  color: Theme.of(context).primaryColor,
                                  onPressed: _isLoading
                                      ? () {}
                                      : () async {
                                          FocusScope.of(context).unfocus();

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              // insetPadding:  EdgeInsets.all(20),
                                              titlePadding: EdgeInsets.fromLTRB(
                                                  15, 30, 0, 10),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 5, 20, 0),
                                              // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                                              title: Column(
                                                children: <Widget>[
                                                  Text('Credits', //red
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          .copyWith(
                                                              color:
                                                                  Colors.red)),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (s) {
                                                      setState(() {
                                                        amount = int.parse(s);
                                                      });
                                                    },
                                                  ), //red
                                                ],
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    Navigator.pop(context);
                                                    String userId = await prefs
                                                        .getString("id");
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              paymentWebview(
                                                                  amount:
                                                                      amount,
                                                                  userId:
                                                                      userId),
                                                        ));
                                                    // Navigator.pushNamed(
                                                    //     context, "/Wallet");
                                                  },
                                                  child: Text('Recharge',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6),
                                                ),
                                              ],
                                            ),
                                          );

                                          // }
                                          // }
                                        },
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Add Credits",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                fontSize: 17,
                                                color: Colors.white)),
                                  ),
                                ),
                        ),
                      ),

                      Container(
                        height: SizeConfig.h * 0.75,
                        child: Scaffold(
                            appBar: AppBar(
                              leading: Container(),
                              title: Container(),
                              titleSpacing: 0,
                              toolbarHeight: 100,
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.white,
                              bottom: TabBar(
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    icon: Icon(Icons.wallet_giftcard),
                                    text: "Wallet",
                                  ),
                                  Tab(
                                    icon: Icon(Icons.open_in_full),
                                    text: "Transaction",
                                  ),
                                ],
                              ),
                            ),
                            body: TabBarView(children: [
                             WalletWidget(),   TransactionScreen()
                              // Center(
                              //   child: Text("Transaction"),
                              // )
                            ])),
                      ),
                      Container(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
