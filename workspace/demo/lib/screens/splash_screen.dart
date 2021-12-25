import 'dart:convert';

import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:permission_handler/permission_handler.dart';

import '../elements/custom_button.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    checkId();
  }

  checkId() async {
    await Future.delayed(Duration(seconds: 1));

    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString(
      "id",
    );
    if (id != null) {
      Map res = await ApiServices.getRequest(getUserEndPoint + "/" + id);
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
          Navigator.of(context).pushReplacementNamed("/HomeScreen");
        } else {
          await pref.remove("id");
          await Permission.storage.request();
          await Permission.camera.request();
          Navigator.of(context).pushReplacementNamed("/Login");
        }
      } else {
        await pref.remove("id");
        await Permission.storage.request();
        await Permission.camera.request();
        Navigator.of(context).pushReplacementNamed("/Login");
      }
    } else {
      await pref.remove("id");
      await Permission.storage.request();
      await Permission.camera.request();
      Navigator.of(context).pushReplacementNamed("/Login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
