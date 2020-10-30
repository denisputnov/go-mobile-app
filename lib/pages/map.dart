import 'package:flutter/material.dart';

import '../components/map/GoogleMaps.dart';
import '../components/map/Search.dart';
import '../components/map/Filter.dart';

import 'package:go/utils/default.dart';

class MapWidget extends StatefulWidget {
  final label;

  MapWidget({this.label});

  @override
  _MapWidgetState createState() => _MapWidgetState(label: label);
}

class _MapWidgetState extends State<MapWidget> {
  final label;

  _MapWidgetState({this.label});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: label,
      child: Material(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: Stack(children: [
              GoogleMaps(),
              Search(),
              Container(
                margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Filter(),
            ]),
          ),
        ),
      ),
    );
  }
}
