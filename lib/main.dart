import 'package:flutter/material.dart';
import 'package:go/pages/menu.dart';

import './utils/default.dart';
void main() => runApp(Go());

class Go extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa', backgroundColor: Default.getDefaultBackgroundColor(), canvasColor: Colors.transparent),
      home: Menu(),
    );
  }
}