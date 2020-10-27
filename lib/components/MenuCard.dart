import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../utils/default.dart';

class MenuCard extends StatelessWidget {
  Color startColor;
  Color endColor;
  String label;
  String icon;
  String decorationIcon;
  Widget destination;

  MenuCard({this.startColor, this.endColor, this.label, this.icon, this.decorationIcon, this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Default.getDefaultMargin(),
      child: OpenContainer(
        openElevation: 0,
        closedElevation: 0,
        closedColor: Default.getDefaultBackgroundColor(),
        openColor: Default.getDefaultBackgroundColor(),
        transitionType: ContainerTransitionType.fadeThrough,
        closedBuilder: (context, openWidget) {
          return CardContent(
              startColor: startColor, endColor: endColor, label: label, icon: icon, decorationIcon: decorationIcon);
        },
        openBuilder: (context, openWidget) {
          return Container(
            child: destination != null ? destination : Center(child: Text('$label content')),
          );
        },
      ),
      decoration: BoxDecoration(
        borderRadius: Default.getDefauilBorderRadius(),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardContent extends StatelessWidget {
  Color startColor;
  Color endColor;
  String label;
  String icon;
  String decorationIcon;

  CardContent({this.startColor, this.endColor, this.label, this.icon, this.decorationIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: Default.getDefaultMargin(),
      padding: Default.getDefaultPadding(),
      // height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: Default.getDefaultTextStyle(),
          ),
          Align(
            child: Image.asset(icon, width: 40, height: 40),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: Default.getDefauilBorderRadius(),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        image: DecorationImage(
          image: AssetImage(decorationIcon),
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
