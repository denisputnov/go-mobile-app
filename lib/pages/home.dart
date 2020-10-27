import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go/utils/application.dart';

import '../components/AppBar.dart';
import '../components/home/NewsSlider.dart';
import '../components/home/Registration.dart';
import '../components/home/HomeButton.dart';

import '../utils/default.dart';

class Home extends StatefulWidget {
  final label;

  Home({this.label});

  @override
  _HomeState createState() => _HomeState(label: label);
}

class _HomeState extends State<Home> {
  final label;

  _HomeState({this.label});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: label,
      child: Material(
        child: Scaffold(
          appBar: DefautlAppBar(),
          backgroundColor: Default.getDefaultBackgroundColor(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                NewsSlider(),
                RegistrationWidget(),
                HomeButton(title: 'Settings', icon: Icons.settings, iconSize: 35),
                HomeButton(title: 'Policy', icon: FontAwesomeIcons.balanceScale, iconSize: 27),
                HomeButton(title: 'About', icon: Icons.info_outline, iconSize: 35),
                SizedBox(height: 10),
                Text(Application.version(), style: TextStyle(color: Default.getDefaultSubtitleColor(), fontSize: 12))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
