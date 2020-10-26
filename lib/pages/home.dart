import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 50, 8, 16),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xff007cda),
                      endColor: Color(0xff23b4ed),
                      label: 'Maps',
                      icon: './assets/icons/earth.png',
                      decorationIcon: './assets/icons/earth-decoration.png',
                    ),
                  ),
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffc04fbc),
                      endColor: Color(0xff23b4ed),
                      label: 'Home &\nSettings',
                      icon: './assets/icons/home.png',
                      decorationIcon: './assets/icons/home-decoration.png',
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffc04fbc),
                      endColor: Color(0xff41a3ef),
                      label: 'Dictionary',
                      icon: './assets/icons/book.png',
                      decorationIcon: './assets/icons/book-decoration.png',
                    ),
                  ),
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffdf0021),
                      // 0xff797dc7
                      endColor: Color(0xFFBE97EE),
                      label: 'Games',
                      icon: './assets/icons/game.png',
                      decorationIcon: './assets/icons/game-decoration.png',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  Color startColor;
  Color endColor;
  String label;
  String icon;
  String decorationIcon;
  Widget destination;

  MenuCard({this.startColor, this.endColor, this.label, this.icon, this.decorationIcon});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openElevation: 0,
      closedElevation: 0,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, openWidget) {
        return CardContent(
            startColor: startColor, endColor: endColor, label: label, icon: icon, decorationIcon: decorationIcon);
      },
      openBuilder: (context, openWidget) {
        return Container(
          child: Center(child: Text('$label content')),
        );
      },
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
      margin: Utils.getDefaultMargin(),
      width: double.infinity,
      padding: Utils.getDefaultPadding(),
      // height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: Utils.getDefaultTextStyle(),
          ),
          Align(
            child: Image.asset(icon, width: 40, height: 40),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: Utils.getDefauilBorderRadius(),
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
