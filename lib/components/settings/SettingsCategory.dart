import "package:go/utils/default.dart";
import "package:flutter/material.dart";

class SettingsCategory extends StatelessWidget {
  String label;

  SettingsCategory({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: Default.getDefaultTextStyle(), textAlign: TextAlign.left),
      ),
    );
  }
}

