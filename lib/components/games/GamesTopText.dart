import 'package:flutter/material.dart';

class GameTopText extends StatelessWidget {
  String text;
  double screenWidth;

  GameTopText(this.text, this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.08));
  }
}
