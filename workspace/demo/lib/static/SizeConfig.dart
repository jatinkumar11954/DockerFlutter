import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SizeConfig {
  static double h = 0.0;
  static double w = 0.0;

  void init(BuildContext context) {
    h = (MediaQuery.of(context).size.height);
    w = (MediaQuery.of(context).size.width);
  }

  static DateTime currentBackPressTime;

  static Future<bool> exitFromAppp() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "tapAgainToLeave");
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
