import 'package:flutter/material.dart';

import '../pages/home.dart';

import '../components/MenuCard.dart';

import '../utils/default.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Default.getDefaultBackgroundColor(),
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
                      icon: './assets/icons/menu/earth.png',
                      decorationIcon: './assets/icons/menu/earth-decoration.png',
                    ),
                  ),
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffc04fbc),
                      endColor: Color(0xff23b4ed),
                      label: 'Home &\nSettings',
                      icon: './assets/icons/menu/home.png',
                      decorationIcon: './assets/icons/menu/home-decoration.png',
                      destination: Home(),
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
                      icon: './assets/icons/menu/book.png',
                      decorationIcon: './assets/icons/menu/book-decoration.png',
                    ),
                  ),
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffdf0021),
                      // 0xff797dc7
                      endColor: Color(0xFFBE97EE),
                      label: 'Games',
                      icon: './assets/icons/menu/game.png',
                      decorationIcon: './assets/icons/menu/game-decoration.png',
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
