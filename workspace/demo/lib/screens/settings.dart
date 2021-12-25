import 'package:athome_partner_app/elements/bottomNavBar.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void dispose() {
    super.dispose();
    // phoneNo.clear();clear
    phoneNo.dispose();
    password.dispose();
    name.dispose();
    confirmpassword.dispose();
    email.dispose();
  }

  String firebaseToken;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<UserData>(builder: (context, item, i) {
      return Scaffold(
          bottomNavigationBar: BottomNavBar(
            index: 2,
          ),
          appBar: AppBar(
            backgroundColor: primaryColor,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Provider.of<Service>(context, listen: false).init();

            //     Navigator.pop(context);
            //   },
            // ),
            title: Text("Settings"),
          ),
          body: Column(
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Exit"),
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () => SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop'))
                ],
              )),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Logout"),
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.remove(
                          "token",
                        );
                        Navigator.pushNamed(context, "/Login");
                      })
                ],
              )),
              Consumer<UserData>(builder: (context, user, i) {
                return Column(
                  children: [
                    Text("Name"),
//                   TextFormField(
// controller: ,

//                   )
                  ],
                );
              })
            ],
          ));
    });
  }
}
