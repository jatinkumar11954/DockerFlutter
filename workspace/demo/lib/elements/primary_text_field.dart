import '../helpers/hex_color.dart';
import 'package:flutter/material.dart';

class PrimaryTextFieldBuilder extends StatelessWidget {
  final String hint;
  final double borderRadius;
  final bool hintCentered;
  final Widget trailingIcon;
  final Color color;
  final bool useCustomPadding;
  final EdgeInsets customPadding;
  final bool obscureText;
  final String text;
  final bool autoFocus;
  final Function onTap;
  final int maxLines;

  PrimaryTextFieldBuilder(
      {this.hint,
      this.borderRadius = 15.0,
      this.hintCentered = true,
      this.trailingIcon,
      this.color,
      this.useCustomPadding = true,
      this.customPadding,
      this.obscureText = false,
      this.text,
      this.autoFocus = false,
      this.onTap,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor("#F1F4FE"),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextField(
        maxLines: maxLines,
        autofocus: autoFocus,
        onTap: () {
          onTap();
        },
        controller: TextEditingController(text: hint == null ? text : ""),
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        obscureText: obscureText,
        textAlign: hintCentered ? TextAlign.center : TextAlign.start,
        decoration: InputDecoration(
          contentPadding: !hintCentered
              ? (!useCustomPadding
                  ? EdgeInsets.only(left: 20.0, top: 15.0)
                  : customPadding)
              : (useCustomPadding ? customPadding : null),
          suffixIcon: trailingIcon,
          border: InputBorder.none,
          hintText: text == null ? hint : "",
          hintStyle: TextStyle(
            color: color == null ? HexColor("#A3B8EB") : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
