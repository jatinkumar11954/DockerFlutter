import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as hp;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class ApiServices {
  static const headers = {'Content-Type': 'application/json'};

  static Future<Map<dynamic, dynamic>> getRequest(
    String endPoint,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    Map res = {};
    try {
      await hp.get(
          Uri.parse(
            baseUrl + endPoint,
          ),
          headers: {
            "x-auth": token,
            'Content-Type': 'application/json'
          }).then((response) {
        if (response != null) {
          res = json.decode(response.body);
          // //print("response json decode" + res.toString());

          if (response.statusCode == 400) {
            res = null;
          } //
        }
      }).catchError((e) {
        //print(e);
        // Fluttertoast.showToast(
        //   msg: "Server is not responding!!!",
        //   backgroundColor: Colors.grey[400],
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 2,
        // );
        res = null;
      });
    } on SocketException {
      Fluttertoast.showToast(
        msg: "Check Your Internet Connection",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
    }
    //
    //print(res);
    return res;
  }

  static Future postRequest(var data, String endPoint) async {
    Map res = {};
    await hp
        .post(Uri.parse(baseUrl + endPoint), body: data, headers: headers)
        .then((response) {
      print("after then of http" + response.toString());
      if (response != null) {
        res = json.decode(response.body);
        print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          print("insode satus not 400");
          Fluttertoast.showToast(
            msg: res["message"],
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = {};
        } //
      }
    }).catchError((error) {
      // print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = {};
    });
    // print("at end" + res.toString());
    return res;
    //
  }

  static Future putRequest(var data, String endPoint) async {
    Map res = {};
    await hp
        .put(Uri.parse(baseUrl + endPoint), body: data, headers: headers)
        .then((response) {
      print("after then of http" + response.toString());
      if (response != null) {
        res = json.decode(response.body);
        print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          print("insode satus not 400");
          Fluttertoast.showToast(
            msg: res["message"],
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = {};
        } //
      }
    }).catchError((error) {
      // print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = {};
    });
    print("at end" + res.toString());
    return res;
    //
  }
}
