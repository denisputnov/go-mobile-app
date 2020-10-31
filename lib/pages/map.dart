import 'package:flutter/material.dart';

import '../components/map/GoogleMaps.dart';
import '../components/map/Search.dart';
import '../components/map/Filter.dart';
import '../components/Back.dart';

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
              Back(),
              Filter(),
            ]),
          ),
        ),
      ),
    );
  }
}
