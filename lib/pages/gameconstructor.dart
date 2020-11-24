import 'package:flutter/material.dart';
import 'package:go/components/AppBar.dart';
import 'package:go/utils/default.dart';

class GameConstrucor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      backgroundColor: Default.getDefaultBackgroundColor(),
    );
  }
}
