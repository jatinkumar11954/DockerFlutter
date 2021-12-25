import 'package:athome_partner_app/main.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:flutter/material.dart';

PreferredSize CustomAppBar(BuildContext context) {
  SizeConfig().init(context);
  return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
          leading: Container(),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                width: 40,
              ),
              Text(
                'Athome',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Arial',
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          leadingWidth: 10,
          titleSpacing: 0.0,
          backgroundColor: primaryColor,
          actions: <Widget>[
            // Slider Code Start Here,
          ]));
}

PreferredSize BackAppBar(BuildContext context, String text) {
  SizeConfig().init(context);
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: AppBar(
      title: Text(text),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/HomeScreen");
          }),
    ),
  );
}
