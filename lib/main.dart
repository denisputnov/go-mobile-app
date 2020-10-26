import 'package:flutter/material.dart';
import 'package:go/pages/home.dart';
void main() => runApp(Go());

class Go extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa', backgroundColor: Color(0xff212121)),
      home: HomePage(),
    );
  }
}