import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:athome_partner_app/auth/otp.dart';
import 'package:athome_partner_app/helpers/validation.dart';
import 'package:athome_partner_app/model/categoryData.dart';
import 'package:athome_partner_app/model/locationdata.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
// import 'package:multipart_request/multipart_request.dart' as http;
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../static/SizeConfig.dart';
import '../static/apiServices.dart';
import '../static/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../elements/items/photoupload.dart';
import '../main.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  showButtonLoading() => setState(() {
        _isButLoading = true;
      });
  stopBUttonLoading() => setState(() {
        _isButLoading = false;
      });
  @override
  void dispose() {
    super.dispose();
    // phoneNo.clear();clear
    phoneNo.dispose();
    password.dispose();
    name.dispose();
    email.dispose();
    addr.dispose();
    city.dispose();
    zip.dispose();
    proofNo.dispose();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  List<LocationItem> locatindata = [];
  List<Category> categorydata = [];
  bool isFileUploading = false;
  getLocation() async {
    showLoading();

    Map subCategoryRes = await ApiServices.getRequest(getAllLocationEndPoint);
    // print("llllllllog${subCategoryRes}");
    if (subCategoryRes != null) {
      // print("res is not null ${subCategoryRes["isSuccess"]}");
      if (subCategoryRes["isSuccess"]) {
        // print("status is true");
        locatindata.add(LocationItem(locationName: "Select Location"));
        locatindata.addAll(List<LocationItem>.from(
            subCategoryRes["data"].map((x) => LocationItem.fromMap(x))));

        // stopLoading();
      } else {
        locatindata = [];
        // stopLoading();
      }
    }

    Map categoryRes = await ApiServices.getRequest(categoryEndPoint);
    // //print("llllllllog${categoryRes}");
    if (categoryRes != null) {
      // //print("res is not null ${categoryRes["isSuccess"]}");
      if (categoryRes["isSuccess"]) {
        // //print("status is true");
        categorydata.add(Category(categoryName: "Select Category"));
        categorydata.addAll(List<Category>.from(
            categoryRes["data"].map((x) => Category.fromMap(x))));
        stopLoading();
      }
      stopLoading();
    } else {
      stopLoading();
    }
  }

  PickedFile frontimage;
  PickedFile backimage;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String firebaseToken;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController proofNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController addr = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zip = TextEditingController();
  String state = "Telangana";
  String preLocation = "Select Location";
  String selectCat = "Select Category";
  String proof = "Select Proof";
  String firstImageUrl;
  String secondImageUrl;
  bool _isLoading = false;
  bool _isButLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColorLight,
        body: SingleChildScrollView(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 25),
                      Center(child: Text("Partner Sign Up")),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Image.asset(
                            'images/logo.png',
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          controller: name,

                          // key: key,

                          keyboardType: TextInputType.text,
                          validator: userNameValidation,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Name*",
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
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.person,
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
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.phone,
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
                          controller: email,

                          // key: key,

                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidation,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Email*",
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
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.email,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Prefered Location"),
                            DropdownButton<String>(
                              onChanged: (s) {
                                setState(() {
                                  preLocation = s;
                                });
                              },
                              value: preLocation,
                              items: locatindata.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.locationName,
                                  child: new Text(value.locationName),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Select Category"),
                            DropdownButton<String>(
                              onChanged: (s) {
                                setState(() {
                                  selectCat = s;
                                });
                              },
                              value: selectCat,
                              items: categorydata.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.categoryName,
                                  child: new Text(value.categoryName),
                                );
                              }).toList(),
                            ),
                          ],
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
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Proof Type"),
                            DropdownButton<String>(
                              onChanged: (s) {
                                setState(() {
                                  proof = s;
                                });
                              },
                              value: proof,
                              items: [
                                "Select Proof",
                                "Aadhar",
                                "Voter Id",
                                "Passport"
                              ].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            ),
                          ],
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

                          controller: proofNo,
                          validator: userNameValidation,
                          // obscureText: showPwd,

                          decoration: InputDecoration(
                            // errorStyle: TextStyle(height: 0),s
                            labelText: "Proof No*",
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
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.info,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Address"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          controller: zip,
                          validator: zipValidation,
                          decoration: InputDecoration(
                            counterText: "",
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
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
                      ),
                      Container(
                        height: 70,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text("Front Image "),
                            ),
                            frontimage == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                        _buildAddPhoto(
                                            context, "front", "camera"),
                                        _buildAddPhoto(
                                            context, "front", "gallery")
                                      ])
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 1),

                                    // width: SizeConfig.w * 0.65,
                                    height: 50,
                                    child: Text(
                                      frontimage.path.split("/").last,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 70,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text("Back Image "),
                            ),
                            backimage == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                        _buildAddPhoto(
                                            context, "back", "camera"),
                                        _buildAddPhoto(
                                            context, "back", "gallery")
                                      ])
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 1),

                                    // width: SizeConfig.w * 0.65,
                                    height: 50,
                                    child: Text(
                                      backimage.path.split("/").last,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/Login");
                              },
                              child: Text(
                                "Have account already? Login",
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
                          child: _isButLoading
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
                                  onPressed: _isButLoading
                                      ? () {}
                                      : () async {
                                          FocusScope.of(context).unfocus();
                                          if (_form.currentState.validate() &&
                                              (selectCat !=
                                                  "Select Category") &&
                                              (proof != "Select Proof") &&
                                              preLocation !=
                                                  "Select Location" &&
                                              firstImageUrl != null &&
                                              secondImageUrl != null) {
                                            showButtonLoading();
                                            // name.text = "jarin";
                                            // email.text = "skdb@lnsf.sdf";
                                            // password.text = "123456";
                                            // phoneNo.text = "7702231889";
                                            // await Future.delayed(Duration(milliseconds: 500));
                                            Map body = {
                                              "name": name.text,
                                              "email": email.text,
                                              "password": password.text,
                                              "phone": phoneNo.text,
                                              "govtId": [
                                                {
                                                  "cardType": proof,
                                                  "cardNumber": proofNo.text,
                                                  "frontImageURL":
                                                      firstImageUrl,
                                                  "rearImageURL": secondImageUrl
                                                }
                                              ],
                                              "address": [
                                                {
                                                  "addressLine": addr.text,
                                                  "city": city.text,
                                                  "state": state,
                                                  "zipCode": zip.text,
                                                }
                                              ],
                                              "locationId": locatindata
                                                  .firstWhere((element) =>
                                                      element.locationName ==
                                                      preLocation)
                                                  .id,
                                              "category_id": categorydata
                                                  .firstWhere((element) =>
                                                      element.categoryName ==
                                                      selectCat)
                                                  .id,
                                              "profileUrl": "Sample.jpg"
                                            };
//{"name":
// "dsfsdf",
// "email": "dfs@fdg.dfgf",
// "password": 123456, "phone": "6300843969",
// "govtId": [{"cardType": "Aadhar",
// "cardNumber": "1234567",
//"frontImageURL":
//"https://oit-athome.s3.amazonaws.com/proofs/1630913769048-d8c16f9b-74b9-4691-95d8-3998e5c4fd488172085211303590616.jpg",
// "rearImageURL":
// "https://oit-athome.s3.amazonaws.com/proofs/1630913777125-d8c16f9b-74b9-4691-95d8-3998e5c4fd488172085211303590616.jpg"}],
// "address": [{"addressLine": "fgdfg", "city": "dfgdf", "state": "Telangana", "zipCode": "500070"}],
// "locationId": "60241b6998da6923285793a1", "category_id": "604a39b6ed14f596b11dffed",
// "profileUrl":"Sample.jpg"}
                                            print(body.toString());
                                            // showLoading();

                                            Map res =
                                                await ApiServices.postRequest(
                                                    json.encode(body),
                                                    registerEndPoint);
                                            print("llllllllog${res}");
                                            if (res != null) {
                                              print(
                                                  "res is not null ${res["isSuccess"]}");
                                              if (res["isSuccess"] ?? false) {
                                                print("status is true");
                                                stopBUttonLoading();
                                                FocusScope.of(context)
                                                    .unfocus();

                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Customer Details Saved Successfully!",
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 3,
                                                );

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Otp(
                                                          phone: phoneNo.text),
                                                    ));
                                              } //status is true
                                              else {
                                                stopBUttonLoading();

                                                Fluttertoast.showToast(
                                                  msg: res["message"],
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 3,
                                                );
                                              } //status is not true
                                            } //res is not null
                                            else {
                                              stopBUttonLoading();

                                              print("res is null trye again");
                                            }
                                          } //phone number is empty
                                          else {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           Otp(phone: phoneNo.text),
                                            //     ));
                                            Fluttertoast.showToast(
                                              msg: "Please fill all the fields",
                                              backgroundColor: Colors.grey[400],
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 3,
                                            );
                                          }
                                        },
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text("Register",
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
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  _buildAddPhoto(
      BuildContext context, String frontorback, String camorGallery) {
    return InkWell(
      onTap: () => camorGallery == "camera"
          ? _onAddPhotoClicked(
              context,
              frontorback,
              ImageSource.camera,
            )
          : _onAddPhotoClicked(
              context,
              frontorback,
              ImageSource.gallery,
            ),
      child: Container(
        margin: EdgeInsets.all(5),
        // height: 100,
        width: 100,
        // color: kDarkGray,
        child: Center(
          child: Icon(
            camorGallery == "camera" ? Icons.camera_alt_outlined : Icons.photo,
            // color: kLightGray,
          ),
        ),
      ),
    );
  }

  _showOpenAppSettingsDialog(context) {
    return CustomDialog.show(
      context,
      'Permission needed',
      'Photos and Storage permission is needed to select photos',
      'Open settings',
      openAppSettings,
    );
  }

  _onAddPhotoClicked(context, String frontOrBack, ImageSource imgSource) async {
    Permission permission;

    if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }

    PermissionStatus permissionStatus = await permission.status;

    print(permissionStatus);

    if (permissionStatus == PermissionStatus.restricted) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus == PermissionStatus.granted) {
        grantedmethod(context, frontOrBack, imgSource);
      }
    }
    if (permissionStatus == PermissionStatus.undetermined) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus == PermissionStatus.granted) {
        //Only continue if permission granted
        grantedmethod(context, frontOrBack, imgSource);
      }
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showOpenAppSettingsDialog(context);

      permissionStatus = await permission.status;

      if (permissionStatus == PermissionStatus.granted) {
        grantedmethod(context, frontOrBack, imgSource);
      }
    }

    if (permissionStatus == PermissionStatus.denied) {
      if (Platform.isIOS) {
        _showOpenAppSettingsDialog(context);
      } else {
        permissionStatus = await permission.request();
      }

      if (permissionStatus == PermissionStatus.granted) {
        //Only continue if permission granted
        grantedmethod(context, frontOrBack, imgSource);
      }
    }

    if (permissionStatus == PermissionStatus.granted) {
      //Only continue if permission granted
      grantedmethod(context, frontOrBack, imgSource);
    }
  }

  grantedmethod(context, String frontOrBack, ImageSource imgSource) async {
    print('Permission granted inside');
    PickedFile image = await ImagePicker().getImage(
      source: imgSource,
      imageQuality: 80,
    );
    // imagetemp.

    if (image != null) {
      String fileExtension = image.path.split(".").last;
      print(fileExtension);
      // _galleryItems.add(
      //   GalleryItem(
      //     id: Uuid().v1(),
      //     resource: image.path,
      //     isSvg: fileExtension.toLowerCase() == ".svg",
      //   ),
      // );

      setState(() {
        if (frontOrBack == "front")
          frontimage = image;
        else {
          backimage = image;
        }
        print(frontimage?.path ?? "");
        // _photos.add(image);
        // _photosSources.add(PhotoSource.FILE);
      });
      String result;
      var request = http.MultipartRequest(
          "POST", Uri.parse(baseUrl + "partner/imageUploads"));
      // request.setUrl("https://oit-athome.s3.amazonaws.com/");
      setState(() => isFileUploading = true);
      displayUploadDialog();
      // print(image.path);
      // File img = File(image.path);

      print(image.path);

      request.files.add(await MultipartFile.fromPath("file", image.path));

      await request.send().then((result) async {
        // result.stream.listen((progress) {
        //   print("progress from response object " + progress.toString());
        // });

        http.Response.fromStream(result)
          ..then((response) {
            print("inside upload res ${response.body}");
            if (response.statusCode == 200) {
              print("Uploaded! ");
              print('response.body ' + response.body);
              if (frontOrBack == "front")
                setState(() {
                  firstImageUrl = json.decode(response.body)["path"];
                });
              else
                setState(() {
                  secondImageUrl = json.decode(response.body)["path"];
                });
              setState(() => isFileUploading = false);
              Navigator.pop(context);
            } else {
              setState(() {
                if (frontOrBack == "front")
                  frontimage = null;
                else {
                  backimage = null;
                }
              });
              setState(() => isFileUploading = false);

              Navigator.pop(context);

              Fluttertoast.showToast(
                msg: "Please upload an image with smaller size!!",
                backgroundColor: Colors.grey[400],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
              );
              // print(json.decode(response.body)["message"]);
            }
          });
      }).catchError((err) {
        setState(() {
          if (frontOrBack == "front")
            frontimage = null;
          else {
            backimage = null;
          }
        });
        setState(() {
          if (frontOrBack == "front")
            frontimage = image;
          else {
            backimage = image;
          }
          print(frontimage?.path ?? "");
          // _photos.add(image);
          // _photosSources.add(PhotoSource.FILE);
        });
        setState(() => isFileUploading = false);

        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: "Please upload an image with smaller size!!",
          backgroundColor: Colors.grey[400],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
        );
      }).whenComplete(() {});
    } else {
      print("image null");
    }
  }

  Future displayUploadDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => buildFileUploadDialog(context));
  }

  AlertDialog buildFileUploadDialog(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: EdgeInsets.all(6),
        child: LinearProgressIndicator(
          value: isFileUploading ? Random().nextInt(100) / 100 : 0,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('Uploading...')),
            // Text("${snapshot.data ?? 0}%"),
          ],
        ),
      ),
    );
  }
}
