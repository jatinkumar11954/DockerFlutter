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

class ResetPassword extends StatefulWidget {
  String phone;
  ResetPassword({Key key, this.phone}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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

  bool showPwdS = true;
  Icon _iconS = Icon(
    Icons.visibility,
  );
  void _toggleS() {
    setState(() {
      showPwdS = !showPwdS;
      if (showPwdS) {
        _iconS = Icon(
          Icons.visibility,
        );
      } else {
        _iconS = Icon(Icons.visibility_off, color: Colors.grey);
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
    confirmpassword.dispose();
    password.dispose();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String firebaseToken;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController confirmpassword = TextEditingController();
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
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 5),
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
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextFormField(
                    // controller: controller,
                    // key: key,

                    controller: confirmpassword,
                    validator: (s) => conpassValidation(s, password.text),
                    obscureText: showPwdS,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _iconS,
                        onPressed: _toggleS,
                      ),
                      // errorStyle: TextStyle(height: 0),s
                      labelText: "Confirm Password*",
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
                                    //go to logins
                                    FocusScope.of(context).unfocus();
                                    if (_form.currentState.validate()) {
                                      showLoading();

                                      // await Future.delayed(Duration(milliseconds: 500));
                                      Map<String, dynamic> data = {
                                        "phoneNumber": widget.phone,
                                        "password": password.text
                                      }; //update
                                      print(data.toString());
                                      // showLoading();

                                      Map res = await ApiServices.putRequest(
                                          json.encode(data),
                                          updatePasswordEndPoint);

                                      print("llllllllog${res}");
                                      if (res != null) {
                                        print(
                                            "res is not null ${res["isSuccess"]}");
                                        if (res["isSuccess"]) {
                                          print("status is true");
                                          stopLoading();
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
                                    } //phone number is empty
                                  },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("RESET PASSWORD",
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
