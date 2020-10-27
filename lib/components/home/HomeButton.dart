import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/default.dart';

class HomeButton extends StatelessWidget {
  String title;
  IconData icon;
  Widget destination;
  double iconSize;

  HomeButton({this.title, this.icon, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: Default.getDefaultPadding(),
      margin: Default.getDefaultMargin(),
      decoration: BoxDecoration(
        boxShadow: Default.getDefaultBoxShadow(),
        color: Default.getDefaultSecondaryColor(),
        borderRadius: Default.getDefauilBorderRadius(),
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          children: <Widget>[
            FaIcon(icon, color: Default.getDefaultIconColor(), size: iconSize),
            SizedBox(width: Default.getDefaultMargin(onlyValue: true)),
            Text(title, style: Default.getDefaultTextStyle(fsz: 20)),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward_ios, color: Default.getDefaultIconColor(), size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
