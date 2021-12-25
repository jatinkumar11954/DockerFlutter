import 'dart:convert';

import 'package:athome_partner_app/elements/addAddress.dart';
import 'package:athome_partner_app/elements/items/customappBar.dart';
import 'package:athome_partner_app/helpers/validation.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  UserData currentUser;
  Profile({Key key, this.currentUser}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  void initState() {
    super.initState();
    name.text = widget?.currentUser?.name ?? "";
    email.text = widget?.currentUser?.email ?? "";
    phoneNo.text = widget?.currentUser?.phone ?? "";

    for (int i = 0; i < widget.currentUser.address.length; i++) {
      address.add([]);

      address[i].add(TextEditingController());
      address[i][0].text = widget.currentUser.address[i].addressLine;
      address[i].add(TextEditingController());

      address[i][1].text = widget.currentUser.address[i].city;
      address[i].add(TextEditingController());

      address[i][2].text = widget.currentUser.address[i].zipCode;
      address[i].add(TextEditingController());

      address[i][3].text = widget.currentUser.address[i].state;
    }
    ;
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  // GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isLoading = false;
  bool enabled = false;
  String firebaseToken;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController email = TextEditingController();
  List<List<TextEditingController>> address = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<UserData>(builder: (context, item, i) {
      return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, "/HomeScreen");
          return Future.value(true);
        },
        child: Scaffold(
            appBar: BackAppBar(context, "Settings"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          // Container(
                          //     padding: EdgeInsets.only(right: 20),
                          //     child: InkWell(
                          //       onTap: () => setState(() {
                          //         enabled = true;
                          //       }),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           Icon(Icons.edit),
                          //           Text("Edit"),
                          //         ],
                          //       ),
                          //     )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: EdgeInsets.only(right: 20),
                              child: InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  await prefs.remove(
                                    "token",
                                  );
                                  await prefs.remove(
                                    "phone",
                                  );
                                  await prefs.remove(
                                    "id",
                                  );

                                  Navigator.pushNamed(context, "/Login");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.logout),
                                    Text("Logout"),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Consumer<UserData>(builder: (context, user, i) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name"),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    height: 30,
                                    color: enabled
                                        ? Colors.white
                                        : Colors.grey[300],
                                    child: TextFormField(
                                      controller: name,
                                      validator: userNameValidation,
                                      enabled: enabled,
                                      decoration: InputDecoration(
                                        // errorStyle: TextStyle(height: 0),s
                                        // labelText: "Name",
                                        labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        hintStyle: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Text("Mobile No"),
                                  Container(
                                    color: Colors.grey[300],
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    height: 30,
                                    child: TextFormField(
                                      controller: phoneNo,
                                      validator: phoneValidation,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        // errorStyle: TextStyle(height: 0),s
                                        // labelText: "Name",
                                        labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        hintStyle: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Text("Email"),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    height: 30,
                                    color: enabled
                                        ? Colors.white
                                        : Colors.grey[300],
                                    child: TextFormField(
                                      controller: email,
                                      validator: emailValidation,
                                      enabled: enabled,
                                      decoration: InputDecoration(
                                        // errorStyle: TextStyle(height: 0),s
                                        // labelText: "Name",
                                        labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // borderSide:
                                          //     BorderSide(color: primaryColor),
                                        ),
                                        hintStyle: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddAddress()));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_circle_outline,
                                            size: 14),
                                        Text("Address")
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: address.length,
                                itemBuilder: (context, addressIndex) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                    "Address${addressIndex + 1}"),
                                              ),
                                              addressIndex != 0
                                                  ? InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            // insetPadding:  EdgeInsets.all(20),
                                                            titlePadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        40,
                                                                        30,
                                                                        40,
                                                                        10),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        40,
                                                                        5,
                                                                        40,
                                                                        0),
                                                            backgroundColor:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    54,
                                                                    67,
                                                                    1),
                                                            title: Text(
                                                                'Do you want to delete this address?',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            // content: Text('Your Credentials will be vanished!',
                                                            //     style: TextStyle(color: Colors.white)),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child:
                                                                    Text('No'),
                                                              ),
                                                              FlatButton(
                                                                onPressed:
                                                                    () async {
                                                                  UserData
                                                                      addressRemove =
                                                                      user.currentUser;

                                                                  addressRemove
                                                                      .address
                                                                      .removeAt(
                                                                          addressIndex);

                                                                  Map userjson =
                                                                      addressRemove
                                                                          .toMap();
                                                                  showLoading();
                                                                  SharedPreferences
                                                                      pref =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  String id = pref
                                                                      .getString(
                                                                    "id",
                                                                  );
                                                                  Map res = await ApiServices.putRequest(
                                                                      json.encode(
                                                                          userjson),
                                                                      updateUserEndPoint +
                                                                          "/" +
                                                                          id);
                                                                  print(
                                                                      "llllllllog${res}");
                                                                  if (res !=
                                                                      null) {
                                                                    print(
                                                                        "res is not null ${res["isSuccess"]}");
                                                                    if (res[
                                                                        "isSuccess"]) {
                                                                      print(
                                                                          "status is true ${res["data"]}");

                                                                      SharedPreferences
                                                                          pref =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      String
                                                                          id =
                                                                          pref.getString(
                                                                        "id",
                                                                      );
                                                                      print(
                                                                          "partner id $id");
                                                                      if (id !=
                                                                          null) {
                                                                        Map updateres = await ApiServices.getRequest(getUserEndPoint +
                                                                            "/" +
                                                                            id);
                                                                        print(
                                                                            "llllllllog${updateres}");
                                                                        if (updateres !=
                                                                            null) {
                                                                          print(
                                                                              "updateres is not null ${updateres["isSuccess"]}");
                                                                          if (updateres[
                                                                              "isSuccess"]) {
                                                                            print("status is true");
                                                                            print(updateres["data"]);
                                                                            // stopLoading();
                                                                            // SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                            // await prefs.setString("token", updateres["token"]);
                                                                            Provider.of<UserData>(context, listen: false).currentUser =
                                                                                UserData.fromMap(updateres["data"]);
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);

                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (_) => Profile(
                                                                                          currentUser: user.currentUser,
                                                                                        )));
                                                                            // print(res["token"]);

                                                                            setState(() {
                                                                              enabled = false;
                                                                            });
                                                                          }
                                                                        }
                                                                      }
                                                                      // stopLoading();
                                                                    }
                                                                  }
                                                                },
                                                                child:
                                                                    Text('Yes'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .remove_circle_outline,
                                                              size: 14),
                                                          Text("Remove")
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          Text("Address Line"),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            height: 30,
                                            color: enabled
                                                ? Colors.white
                                                : Colors.grey[300],
                                            child: TextFormField(
                                              controller: address[addressIndex]
                                                  [0],
                                              validator: userNameValidation,
                                              enabled: enabled,
                                              decoration: InputDecoration(
                                                // errorStyle: TextStyle(height: 0),s
                                                // labelText: "Name",
                                                labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Text("City"),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            height: 30,
                                            color: enabled
                                                ? Colors.white
                                                : Colors.grey[300],
                                            child: TextFormField(
                                              controller: address[addressIndex]
                                                  [1],
                                              validator: userNameValidation,
                                              enabled: enabled,
                                              decoration: InputDecoration(
                                                // errorStyle: TextStyle(height: 0),s
                                                // labelText: "Name",
                                                labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Text("Zip Code"),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            height: 30,
                                            color: enabled
                                                ? Colors.white
                                                : Colors.grey[300],
                                            child: TextFormField(
                                              controller: address[addressIndex]
                                                  [2],
                                              maxLength: 6,
                                              validator: zipValidation,
                                              enabled: enabled,
                                              decoration: InputDecoration(
                                                // errorStyle: TextStyle(height: 0),s
                                                // labelText: "Name",
                                                labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                counterText: "",
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Text("State"),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            height: 30,
                                            color: enabled
                                                ? Colors.white
                                                : Colors.grey[300],
                                            child: TextFormField(
                                              controller: address[addressIndex]
                                                  [3],
                                              validator: userNameValidation,
                                              enabled: enabled,
                                              decoration: InputDecoration(
                                                // errorStyle: TextStyle(height: 0),s
                                                // labelText: "Name",
                                                labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  // borderSide:
                                                  //     BorderSide(color: primaryColor),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
//                   TextFormField(
// controller: ,

//                   )
                            ,
                            !enabled
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: RaisedButton(
                                            color: Colors.pink,
                                            onPressed: () {
                                              name.text =
                                                  widget.currentUser.name;
                                              email.text =
                                                  widget.currentUser.email;
                                              phoneNo.text =
                                                  widget.currentUser.phone;

                                              for (int i = 0;
                                                  i <
                                                      widget.currentUser.address
                                                          .length;
                                                  i++) {
                                                address[i][0].text = widget
                                                    .currentUser
                                                    .address[i]
                                                    .addressLine;

                                                address[i][1].text = widget
                                                    .currentUser
                                                    .address[i]
                                                    .city;

                                                address[i][2].text = widget
                                                    .currentUser
                                                    .address[i]
                                                    .zipCode;

                                                address[i][3].text = widget
                                                    .currentUser
                                                    .address[i]
                                                    .state;
                                              }
                                              setState(() {
                                                enabled = false;
                                              });
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // ClipRRect(
                                      //   borderRadius: BorderRadius.circular(5),
                                      //   child: _isLoading
                                      //       ? Center(
                                      //           child: CircularProgressIndicator(
                                      //             backgroundColor:
                                      //                 Theme.of(context)
                                      //                     .primaryColor,
                                      //           ),
                                      //         )
                                      //       : RaisedButton(
                                      //           color: Colors.green[400],
                                      //           onPressed: () async {
                                      //             UserData newuser =
                                      //                 widget.currentUser;
                                      //             newuser.name = name.text;
                                      //             newuser.email = email.text;
                                      //             newuser.phone = phoneNo.text;

                                      //             for (int i = 0;
                                      //                 i < newuser.address.length;
                                      //                 i++) {
                                      //               newuser.address[i]
                                      //                       .addressLine =
                                      //                   address[i][0].text;

                                      //               newuser.address[i].city =
                                      //                   address[i][1].text;

                                      //               newuser.address[i].zipCode =
                                      //                   address[i][2].text;

                                      //               newuser.address[i].state =
                                      //                   address[i][3].text;
                                      //             }
                                      //             Map userjson = newuser.toMap();
                                      //             showLoading();
                                      //             SharedPreferences pref =
                                      //                 await SharedPreferences
                                      //                     .getInstance();
                                      //             String id = pref.getString(
                                      //               "id",
                                      //             );
                                      //             Map res = await ApiServices
                                      //                 .putRequest(
                                      //                     json.encode(userjson),
                                      //                     updateUserEndPoint +
                                      //                         "/" +
                                      //                         id);
                                      //             print("llllllllog${res}");
                                      //             if (res != null) {
                                      //               print(
                                      //                   "res is not null ${res["isSuccess"]}");
                                      //               if (res["isSuccess"]) {
                                      //                 print(
                                      //                     "status is true ${res["data"]}");

                                      //                 SharedPreferences pref =
                                      //                     await SharedPreferences
                                      //                         .getInstance();
                                      //                 String id = pref.getString(
                                      //                   "id",
                                      //                 );
                                      //                 if (id != null) {
                                      //                   Map res = await ApiServices
                                      //                       .getRequest(
                                      //                           getUserEndPoint +
                                      //                               "/" +
                                      //                               id);
                                      //                   print("llllllllog${res}");
                                      //                   if (res != null) {
                                      //                     print(
                                      //                         "res is not null ${res["isSuccess"]}");
                                      //                     if (res["isSuccess"]) {
                                      //                       print(
                                      //                           "status is true");
                                      //                       print(res["data"]);
                                      //                       // stopLoading();
                                      //                       // SharedPreferences prefs = await SharedPreferences.getInstance();

                                      //                       // await prefs.setString("token", res["token"]);
                                      //                       Provider.of<UserData>(
                                      //                                   context,
                                      //                                   listen: false)
                                      //                               .currentUser =
                                      //                           UserData.fromMap(
                                      //                               res["data"]);
                                      //                       // print(res["token"]);

                                      //                       setState(() {
                                      //                         enabled = false;
                                      //                       });
                                      //                     }
                                      //                   }
                                      //                 }
                                      //                 stopLoading();
                                      //               }
                                      //             }
                                      //           },
                                      //           child: Text(
                                      //             "Save",
                                      //             style: TextStyle(
                                      //                 color: Colors.white),
                                      //           )),
                                      // ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
