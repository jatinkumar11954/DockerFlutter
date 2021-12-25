import 'dart:async';
import 'dart:convert';

import 'package:athome_partner_app/helpers/validation.dart';
import 'package:athome_partner_app/model/serviceData.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../static/SizeConfig.dart';
import '../static/apiServices.dart';
import '../static/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPwd = true;
  Icon _icon = Icon(
    Icons.visibility,
  );
  void _toggle() {
    setState(() {
      showPwd = !showPwd;
      if (showPwd) {
        _icon = Icon(
          Icons.visibility,
        );
      } else {
        _icon = Icon(Icons.visibility_off, color: Colors.grey);
      }
    });
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  @override
  void dispose() {
    super.dispose();
    // phoneNo.clear();clear
    phoneNo.dispose();
    password.dispose();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String firebaseToken;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColorLight,
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Image.asset(
                      'images/logo.png',
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Center(
                    child: Text(
                  "Partner Login",
                  style: Theme.of(context).textTheme.headline5,
                )),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    controller: phoneNo,

                    // key: key,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    validator: phoneValidation,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: "Mobile Number*",
                      // suffixText: "",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      counterText: "",
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      hintStyle: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    // controller: controller,
                    // key: key,

                    controller: password,
                    validator: passValidation,
                    obscureText: showPwd,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _icon,
                        onPressed: _toggle,
                      ),
                      // errorStyle: TextStyle(height: 0),s
                      labelText: "Password*",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      hintStyle: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/Forgot");
                        },
                        child: Text(
                          "Forget Password",
                          style: TextStyle(color: primaryColor),
                        ))),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/Register");
                        },
                        child: Text(
                          "Don't have an account? SignUp",
                          style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline),
                        ))),
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
                              backgroundColor: Theme.of(context).primaryColor,
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
                                    if (_form.currentState.validate()) {
                                      showLoading();

                                      // await Future.delayed(Duration(milliseconds: 500));
                                      Map<String, dynamic> data = {
                                        "phone": phoneNo.text,
                                        "password": password.text
                                      }; //update
                                      print(data.toString());
                                      // showLoading();

                                      Map res = await ApiServices.postRequest(
                                          json.encode(data), loginEndPoint);
                                      print("llllllllog${res}");
                                      if (res != null) {
                                        print(
                                            "res is not null ${res["isSuccess"]}");
                                        if (res["isSuccess"] ?? false) {
                                          print("status is true");
                                          stopLoading();
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          await prefs.setString(
                                              "token", res["token"]);

                                          await prefs.setString(
                                              "partner_id", res["data"]["partner_id"]);
                                          await prefs.setString(
                                              "id", res["data"]["_id"]);
                                          Provider.of<UserData>(context,
                                                      listen: false)
                                                  .currentUser =
                                              UserData.fromMap(res["data"]);
                                          await _firebaseMessaging
                                              .getToken()
                                              .then((String token) {
                                            // assert(token != null);
                                            firebaseToken = token;
                                          }).catchError(
                                                  (e) => print(e.toString()));
                                          _firebaseMessaging
                                              .requestPermission();
                                          // Map<String, dynamic> fcmData = {
                                          //   "id": res["userId"],
                                          //   "notificattionToken": firebaseToken
                                          // };
                                          Map updateData = res["data"];
                                          print("notificationToken");
                                          updateData.putIfAbsent(
                                              "notificationToken",
                                              () => firebaseToken);
                                          updateData.update("notificationToken",
                                              (value) => firebaseToken);
                                          // updateData["notificationToken"] =
                                          //     firebaseToken;
                                          print(
                                              updateData["notificationToken"]);
                                          //9966562333
                                          print(res["data"]);
                                          Map update =
                                              await ApiServices.putRequest(
                                                  json.encode(res["data"]),
                                                  partnerUpdateEndPoint +
                                                      res["data"]["_id"]);
                                          print(update);
                                          FocusScope.of(context).unfocus();

                                          // print(fcmData);
                                          // Map fcmRes =
                                          //     await ApiServices.putRequest(
                                          //         json.encode(fcmData),
                                          //         fcmEndPoint);

//9100492944
                                          Navigator.pushReplacementNamed(
                                              context, "/HomeScreen");
                                          // context,
                                          //     MaterialPageRoute(
                                          //         builder: (_) => InAppWebViewPage(
                                          //             userId: res["userId"],
                                          //             url:
                                          //                 webviewBase + webviewEnd)));
                                        } //status is true
                                        else {
                                          stopLoading();

                                          Fluttertoast.showToast(
                                            msg: res["message"],
                                            backgroundColor: Colors.grey[400],
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                          );
                                        } //status is not true
                                      } //res is not null

                                    } //phone number is empty
                                  },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                          fontSize: 17, color: Colors.white)),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
