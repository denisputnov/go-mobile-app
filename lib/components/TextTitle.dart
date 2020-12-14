import 'package:flutter/material.dart';
import 'package:go/utils/gotheme.dart';

class TextTitle extends StatelessWidget {
  String label;

  TextTitle(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 20,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
