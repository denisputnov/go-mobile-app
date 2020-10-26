import 'package:flutter/material.dart';

// ignore: unused_element
class Utils {
  static TextStyle getDefaultTextStyle({double fsz = 24}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fsz,
      fontWeight: FontWeight.w400,
    );
  }
  static EdgeInsets getDefaultMargin({double mg = 8}) {
    return EdgeInsets.all(mg);
  }
  static EdgeInsets getDefaultPadding({double pd = 16}) {
    return EdgeInsets.all(pd);
  }
  static double getDefaultPaddingValue({double pd = 16}) {
    return 16.0;
  }
  static double getDefaultSpacing() {
    return 16.0;
  }
  static BorderRadius getDefauilBorderRadius({double br = 16}) {
    return BorderRadius.circular(br);
  }
}