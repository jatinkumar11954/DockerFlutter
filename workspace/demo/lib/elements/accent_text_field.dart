
import 'package:flutter/material.dart';

import '../main.dart';

class AccentTextFieldBuilder extends StatelessWidget {
  final String hint;
  final IconData leadingIcon;
  AccentTextFieldBuilder({@required this.hint, @required this.leadingIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: primaryColor),
          ),
          hintText: hint,
          hintStyle:
              TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
          prefixIcon: Icon(
            leadingIcon,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}

class AccentTextFormFieldBuilder extends StatelessWidget {
  final String hint;
  Key key;
  TextEditingController controller;
  String Function(String) validator;
  final IconData leadingIcon;
  AccentTextFormFieldBuilder(
      {@required this.hint,
      this.validator,
      this.controller,
      this.key,
      @required this.leadingIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        controller: controller,
        key: key,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: primaryColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: primaryColor),
          ),
          hintText: hint,
          hintStyle:
              TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
          prefixIcon: Icon(
            leadingIcon,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
