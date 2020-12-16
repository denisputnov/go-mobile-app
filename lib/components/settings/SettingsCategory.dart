import 'package:go/utils/gotheme.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class SettingsCategory extends StatelessWidget {
  String label;

  SettingsCategory({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: context.watch<GoTheme>().textColor,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
