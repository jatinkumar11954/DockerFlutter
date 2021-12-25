import 'dart:async';
import 'dart:convert';

import 'package:athome_partner_app/helpers/validation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../static/SizeConfig.dart';
import '../static/apiServices.dart';
import '../static/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

class Otp extends StatefulWidget {
  String phone;
  Otp({Key key, this.phone}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
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

  @override
  void initState() {
    super.initState();
    // sendOtp();
  }

  sendOtp() async {
    showLoading();
    print(widget.phone);
    Map<String, dynamic> data = {
      "phoneNumber": widget.phone,
    }; //
    try {
      Map res =
          await ApiServices.postRequest(json.encode(data), RequestOtpEndPoint);
      if (res != null) {
        print("res is not null ${res["isSuccess"]}");
        if (res["isSuccess"] ?? false) {
          print("status is true");
          Fluttertoast.showToast(
            msg: "Otp Sent Successfully!!",
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
          );
          stopLoading();

//9100492944

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
    } //try

    catch (e) {
      stopLoading();
    }
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
    // otp.clear();clear
    otp.dispose();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String firebaseToken;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController otp = TextEditingController();
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
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    controller: otp,

                    // key: key,
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    validator: otpValidation,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: "OTP",
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
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {
                          // Navigator.pushNamed(context, "/Register");
                          Map<String, dynamic> data = {
                            "phoneNumber": widget.phone,
                          }; //update
                          print(data.toString());
                          // showLoading();

                          Map res = await ApiServices.postRequest(
                              json.encode(data), RequestOtpEndPoint);
                          if (res != null) {
                            print("res is not null ${res["isSuccess"]}");
                            if (res["isSuccess"]) {
                              print("status is true");
                              Fluttertoast.showToast(
                                msg: "Otp Sent Successfully!!",
                                backgroundColor: Colors.grey[400],
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                              );
//9100492944

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
                          }
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(color: primaryColor),
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
                                        "phoneNumber": widget.phone,
                                        "otp": otp.text,
                                      }; //update
                                      print(data.toString());
                                      // showLoading();
                                      try {
                                        Map res = await ApiServices.postRequest(
                                            json.encode(data),
                                            verifyOtpEndPoint);
                                        print("llllllllog${res}");
                                        if (res != null) {
                                          print(
                                              "res is not null ${res["isSuccess"]}");
                                          if (res["isSuccess"]) {
                                            print("status is true");
                                            stopLoading();
                                            // SharedPreferences prefs =
                                            //     await SharedPreferences
                                            //         .getInstance();

                                            // await prefs.setString(
                                            //     "userId", res["userId"]);
                                            FocusScope.of(context).unfocus();
                                            // await _firebaseMessaging
                                            //     .getToken()
                                            //     .then((String token) {
                                            //   // assert(token != null);
                                            //   firebaseToken = token;
                                            // }).catchError(
                                            //         (e) => print(e.toString()));
                                            // _firebaseMessaging
                                            //     .requestPermission();
                                            // Map<String, dynamic> fcmData = {
                                            //   "id": res["userId"],
                                            //   "notificattionToken": firebaseToken
                                            // };
                                            // print(fcmData);
                                            // Map fcmRes =
                                            //     await ApiServices.putRequest(
                                            //         json.encode(fcmData),
                                            //         fcmEndPoint);

//9100492944
                                            Navigator.pushReplacementNamed(
                                                context, "/Login");
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
                                      } catch (e) {
                                        stopLoading();
                                      }
                                    }
                                  },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Verify OTP",
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
