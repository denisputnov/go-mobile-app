import 'package:flutter/material.dart';

import 'package:go/utils/default.dart';

class InfotDict extends StatefulWidget {
  final label;

  InfotDict({this.label});

  @override
  _InfotDict createState() => _InfotDict(label);
}

class _InfotDict extends State<InfotDict> {
  final label;

  _InfotDict(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Info Dict")),
    );
  }
}
