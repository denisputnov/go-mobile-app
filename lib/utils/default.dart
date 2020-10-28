import 'package:flutter/material.dart';

// ignore: unused_element
class Default {
  static TextStyle getDefaultTextStyle({double fsz = 24}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fsz,
      fontWeight: FontWeight.w400,
    );
  }

  static dynamic getDefaultBoxShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        spreadRadius: 2,
      ),
    ];
  }

  static dynamic getDefaultMargin({double mg = 8, bool onlyValue = false}) {
    return onlyValue ? mg : EdgeInsets.all(mg);
  }

  static dynamic getDefaultPadding({double pd = 16, bool onlyValue = false}) {
    return onlyValue ? pd : EdgeInsets.all(pd);
  }

  static dynamic getDefauilBorderRadius({double br = 16, bool onlyValue = false}) {
    return onlyValue ? br : BorderRadius.circular(br);
  }

  static Color getDefaultBackgroundColor() {
    return Color(0xff212121);
  }

  static Color getDefaultSecondaryColor() {
    return Color(0xff313131);
  }

  static Color getDefaultThirdlyColor() {
    return Color(0xff3B3B3B);
  }

  static Color getDefaultSubtitleColor() {
    return Color(0xff575757);
  }

  static Color getDefaultIconColor() {
    return Color(0xff575757);
  }

  static Color getDefaultLinkColor() {
    return Colors.indigo;
  }
}
