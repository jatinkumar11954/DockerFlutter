import 'dart:convert';

import 'package:athome_partner_app/helpers/validation.dart';
import 'package:athome_partner_app/model/userData.dart';
import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:athome_partner_app/static/apiServices.dart';
import 'package:athome_partner_app/static/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AddAddress extends StatefulWidget {
  AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController addr = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zip = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  String state = "Telangana";
  @override
  void dispose() {
    addr.dispose();
    city.dispose();
    zip.dispose();
    super.dispose();
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<UserData>(builder: (context, user, i) {
      return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: Text("Add Address"),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("CLOSE"))
                ],
                // leading: IconButton(
                //   icon: Icon(Icons.arrow_back
              ),
              body: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: addr,
                          validator: addrValidation,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            hintText: "Address Line",
                            hintStyle: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: city,
                          validator: cityValidation,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            hintText: "City",
                            hintStyle: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          controller: zip,
                          validator: zipValidation,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            hintText: "Zip Code",
                            hintStyle: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Select State"),
                            DropdownButton<String>(
                              onChanged: (s) {
                                setState(() {
                                  state = s;
                                });
                              },
                              value: state,
                              items: <String>[
                                "Telangana",
                                "Andhara Pradesh",
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            ),
                          ],
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
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
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
                                              Map<String, dynamic> addrdata = {
                                                "addressLine": addr.text,
                                                "city": city.text,
                                                "state": state,
                                                "zipCode": zip.text
                                              };
                                              // await Future.delayed(Duration(milliseconds: 500));
                                              user.currentUser.address.add(
                                                  Address.fromMap(addrdata));
                                              Map<String, dynamic> data =
                                                  user.currentUser.toMap();

                                              // Map<String, dynamic> data = {
                                              //   "name": "veerendra",
                                              //   "email": "Sample@gmail.com",
                                              //   "phone": "9100492944",
                                              //   "address": [{}],
                                              //   "profileUrl": "Sample.jpg"
                                              // };
                                              //update
                                              print("update data");
                                              print(data.toString());
                                              // showLoading();
                                              SharedPreferences pref =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String id = pref.getString(
                                                "id",
                                              );
                                              print("part ner id $id");
                                              Map res =
                                                  await ApiServices.putRequest(
                                                      json.encode(data),
                                                      updateUserEndPoint + id);
                                              print("updated user ${res}");
                                              if (res != null) {
                                                print(
                                                    "res is not null ${res["isSuccess"]}");
                                                if (res["isSuccess"]) {
                                                  print(
                                                      "status is true ${res["data"]}");
                                                  stopLoading();

                                                  // Provider.of<UserData>(context,
                                                  //             listen: false)
                                                  //         .currentUser =
                                                  //     UserData.fromMap(
                                                  //         res["data"]);
                                                  FocusScope.of(context)
                                                      .unfocus();
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
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          "/HomeScreen");
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
                                                    backgroundColor:
                                                        Colors.grey[400],
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 3,
                                                  );
                                                } //status is not true
                                              } //res is not null

                                            } //phone number is empty
                                          },
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text("Add Address",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              ?.copyWith(
                                                  fontSize: 17,
                                                  color: Colors.white)),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )));
    });
  }
}
