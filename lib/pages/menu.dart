import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/games.dart';
import '../pages/dictionary.dart';

import '../components/MenuCard.dart';

import '../utils/gotheme.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<GoTheme>().backgroundColor,
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
                      label: 'Карты',
                      icon: './assets/icons/menu/earth.png',
                      decorationIcon: './assets/icons/menu/earth-decoration.png',
                      destination: MapWidget(label: "Maps"),
                    ),
                  ),
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffc04fbc),
                      endColor: Color(0xff23b4ed),
                      label: 'Аккаунт &\nНастройки',
                      icon: './assets/icons/menu/home.png',
                      decorationIcon: './assets/icons/menu/home-decoration.png',
                      destination: Home(label: "Home &\nSettings"),
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
                      label: 'Личный\nпомошник',
                      icon: './assets/icons/menu/book.png',
                      decorationIcon: './assets/icons/menu/book-decoration.png',
                      destination: Dictionary(),
                    ),
                  ),
                  Flexible(
                    child: MenuCard(
                      startColor: Color(0xffdf0021),
                      // 0xff797dc7
                      endColor: Color(0xFFBE97EE),
                      label: 'Игры',
                      icon: './assets/icons/menu/game.png',
                      decorationIcon: './assets/icons/menu/game-decoration.png',
                      destination: Games(label: "Games"),
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
