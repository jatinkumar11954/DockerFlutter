import 'dart:ui';
import 'package:intl/intl.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String curencySymbol = "₹";

String getPrice(double myPrice) {
  var format = NumberFormat.currency(locale: 'HI', symbol: curencySymbol);
  var noDecimalformat = NumberFormat.currency(
      locale: 'HI', symbol: curencySymbol + " ", decimalDigits: 2);
  myPrice = myPrice ?? 0.0;
  try {
    if (myPrice <= 0) {
      return noDecimalformat.format(0.00);
    }
    return format.format(myPrice.abs() ?? 0.00);
  } catch (e) {
    return '0';
  }
}
