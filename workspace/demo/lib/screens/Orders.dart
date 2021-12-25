import 'package:athome_partner_app/elements/items/customappBar.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
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
          appBar: BackAppBar(context, "Orders"),

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
                    "Hi! name",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
