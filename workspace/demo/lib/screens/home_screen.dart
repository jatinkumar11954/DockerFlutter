import 'dart:convert';
import 'dart:ui';

import 'package:athome_partner_app/elements/bottomNavBar.dart';
import 'package:athome_partner_app/elements/dashboardView.dart';
import 'package:athome_partner_app/elements/items/bottomsubCat.dart';
import 'package:athome_partner_app/elements/items/customappBar.dart';
import 'package:athome_partner_app/elements/items/homeslider.dart';
import 'package:athome_partner_app/elements/items/offerslider.dart';
import 'package:athome_partner_app/helpers/hex_color.dart';
import 'package:athome_partner_app/model/bannerData.dart';
import 'package:athome_partner_app/model/categoryData.dart';
import 'package:athome_partner_app/model/dashBoard.dart';
import 'package:athome_partner_app/model/notificationData.dart';
import 'package:athome_partner_app/model/offerBanner.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/screens/orderScreen.dart';
import 'package:athome_partner_app/screens/profile.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:overlay_support/overlay_support.dart' as overlay;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String userId;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData(true);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          getData(false);

          // print(json.decode(notification.toString()));
          // print((message?.data["data"]));
          // print(json.decode((message?.notification.body)));
          // print((message?.notification.bodyLocArgs));
          print(message?.data["orderId"]);
          OrderId newOrder =
              OrderId.fromMap(json.decode(message?.data["orderId"] ?? {}));
          // print(android);
          SizeConfig().init(context);
          // print("on mesage ${notification.title}");
          overlay.showSimpleNotification(
            Text(
              notification?.title ?? "title",
            ),
            // leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Row(
              children: [
                SizedBox(
                  width: SizeConfig.w * 0.65,
                  child: Text(notification?.body ?? "status",
                      // "           " +
                      // message["data"]["status"],
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                      maxLines: 2),
                ),
                FlatButton(
                  child: Text(
                    "Open",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    userId = await prefs.getString("id") ?? "";
                    if ((userId != "") && newOrder != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  OrderScreen(newOrderData: newOrder)));
                    } else {}
                  },
                )
              ],
            ),
            slideDismiss: true,
            background: HexColor("6666FF"),
            duration: Duration(seconds: 5),
          );
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("on onLaunch $message");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = await prefs.getString("id") ?? "";
      getData(false);

      // print(webviewBase + webviewEnd + userId);
      if ((userId != "") && (notification != null && android != null)) {
        getData(false);

        // print(json.decode(notification.toString()));
        // print((message?.data["data"]));
        // print(json.decode((message?.notification.body)));
        // print((message?.notification.bodyLocArgs));
        print(message?.data["orderId"]);
        OrderId newOrder =
            OrderId.fromMap(json.decode(message?.data["orderId"] ?? {}));
        if (newOrder != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OrderScreen(newOrderData: newOrder)));
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => NotificationScreen(
        //             userId: userId,
        //             url: "http://localhost:$port/" + "redirect.html?id=")));
        // print(webviewBase + webviewEnd + widget.userId);

        // Fluttertoast.showToast(
        //   msg: message["data"] ?? " on launch notification has received",
        //   backgroundColor: Colors.grey[400],
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 3,
        // );
      }
    });
  }

  List<BannerData> bannerData = [];
  List<Category> categoryData = [];

  List<Offer> offer = [];
  int notifyCount = 0;
  List<DashBoardCategory> dashBoardCategory = [];
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false, searchTap = false;
  // List<BannerData> bannerData = [];
  getData(bool isLoad) async {
    // print("inside get data");
    if (isLoad ?? false) {
      showLoading();
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("id");
    // print("partner id $token");
    if (token != null) {
      // print("token is not null");
      Map bannerRes =
          await ApiServices.getRequest(NotificationCountEndPoint + token);
      // print("lllllll------------log${bannerRes}");
      if (bannerRes != null) {
        // print("noti null ${bannerRes["isSuccess"]}");
        if (bannerRes["isSuccess"]) {
          // print("llllllllog${bannerRes}");
          // print("count of noti");
          // print(bannerRes["count"]);

          setState(() {
            notifyCount = bannerRes["count"];
          });
          // print(notifyCount);
        }
      }

      stopLoading();
    } else {
      stopLoading();
    }
  }

  FocusNode focus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Image.asset(
                          "images/loading.gif",
                          height: 120,
                          width: SizeConfig.w * 0.8,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Image.asset(
                          "images/loading.gif",
                          height: 140,
                          width: SizeConfig.w * 0.9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Image.asset(
                          "images/loading.gif",
                          height: 50,
                          width: SizeConfig.w * 0.9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Container(
                        height: 150,
                        child: ListView.separated(
                            physics: PageScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(
                                  indent: 5,
                                ),
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 10),
                                child: Center(
                                  child: Image.asset(
                                    "images/loading_card.gif",
                                    height: 150,
                                    width: SizeConfig.w * 0.3,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            })),

                    // HomeLoadWidget()
                  ]),
            ),
          )
        : Consumer<UserData>(builder: (context, userData, ch) {
            return WillPopScope(
              onWillPop: SizeConfig.exitFromAppp,
              child: SafeArea(
                child: Scaffold(
                  // bottomNavigationBar: BottomNavBar(
                  //   index: 0,
                  // ),
                  backgroundColor: Colors.white,
                  appBar: CustomAppBar(context),
                  body: RefreshIndicator(
                    onRefresh: () => Future.value(false),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //6666FF
                          //FF8000
                          //FFB732
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text(
                            "Hi! ${userData?.currentUser?.name ?? ""}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 23),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                homeContainer(
                                    color: HexColor("008000"),
                                    name: "Wallet",
                                    icon: Icons.wallet_membership),
                                homeContainer(
                                    color: HexColor("6666FF"),
                                    name: "Profile",
                                    icon: Icons.person),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                homeContainer(
                                    color: HexColor("FF8000"),
                                    name: "Orders",
                                    icon: Icons.shopping_cart),
                                Stack(
                                  children: [
                                    homeContainer(
                                        color: HexColor("FFB732"),
                                        name: "Notifications",
                                        icon: Icons.notifications),
                                    Container(
                                      width: SizeConfig.w * 0.4,
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        notifyCount.toString() ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                              child: Text(
                            "Terms & Conditions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),

                          TermsCondition(
                              icon: Icons.wallet_membership,
                              title: "Analytics at scale"),
                          TermsCondition(
                              icon: Icons.notifications_none_outlined,
                              title: "Start saving money"),
                          TermsCondition(
                              icon: Icons.wallet_membership,
                              title: "Deploy with a kick start"),
                          TermsCondition(
                              icon: Icons.notifications_none_outlined,
                              title: "Center of excellance"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
  }
}

class TermsCondition extends StatelessWidget {
  IconData icon;
  String title;
  TermsCondition({
    Key key,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              "Reprehenderit commodo nisi consectetur quis duis pariatur eu proident esse. Eiusmod aute in do officia sint fugiat ut veniam quis. Aliquip qui est in nisi anim deserunt. Cillum cillum veniam aliquip occaecat nisi aliqua labore proident esse aute anim eiusmod. Dolor quis nisi enim non eu nostrud. Veniam do magna aliqua culpa exercitation dolore amet consectetur."),
        ],
      ),
    );
  }
}

class homeContainer extends StatelessWidget {
  HexColor color;
  String name;
  // Function ontap;
  IconData icon;
  homeContainer({
    Key key,
    this.color,
    this.name,
    // this.ontap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, user, i) {
      return InkWell(
        onTap: () {
          if (name == "Profile") {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Profile(
                currentUser: user.currentUser,
              ),
            ));
          } else
            Navigator.pushNamed(context, "/$name");
        },
        child: Container(
          color: color,
          width: SizeConfig.w * 0.4,
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
