import 'package:flutter/material.dart';

import 'package:go/utils/default.dart';

class SmartDict extends StatefulWidget {
  final label;

  SmartDict({this.label});

  @override
  _SmartDict createState() => _SmartDict(label);
}

class _SmartDict extends State<SmartDict> {
  final label;

  _SmartDict(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Smart Dict")),
    );
  }
}
