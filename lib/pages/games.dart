import 'package:flutter/material.dart';

import 'package:go/utils/default.dart';

class Games extends StatefulWidget {
  final label;

  Games({this.label});

  @override
  _GamesState createState() => _GamesState(label);
}

class _GamesState extends State<Games> {
  final label;

  _GamesState(this.label);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circularRadiusForBackgroundDecoration = screenWidth / 2;

    return Hero(
      tag: label,
      child: Material(
        child: Scaffold(
          backgroundColor: Default.getDefaultBackgroundColor(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.32,
                      horizontal: screenWidth * 0.15),
                  height: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            circularRadiusForBackgroundDecoration),
                        bottomRight: Radius.circular(
                            circularRadiusForBackgroundDecoration),
                      ),
                      gradient: LinearGradient(
                          colors: [Color(0xffe11030), Color(0xffb482bf)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topLeft),
                      image: DecorationImage(
                        image: AssetImage(
                            './assets/icons/menu/game-decoration.png'),
                        fit: BoxFit.fitHeight,
                        repeat: ImageRepeat.noRepeat,
                        alignment: Alignment.center,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GameTopText('играй', screenWidth),
                      GameTopText('развлекайся', screenWidth),
                      GameTopText('получай скидки', screenWidth),
                    ],
                  ),
                ),
                GamesAppBar(),
                Container(
                  margin: EdgeInsets.only(top: screenWidth - 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GameCard(number: "1"),
                      GameCard(number: "2"),
                      GameCard(number: "3"),
                      GameCard(number: "4"),
                      GameCard(number: "5"),
                      GameCard(number: "6"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  String number = 'lol';

  GameCard({number});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double cardWidth =
        screenWidth - Default.getDefaultMargin(onlyValue: true) * 2;
    double cardHeight = cardWidth * 9 / 16;

    return Container(
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(16)),
      margin: Default.getDefaultMargin(),
      width: cardWidth,
      height: cardHeight,
      child: Center(
        child: Text(number),
      ),
    );
  }
}

class GamesAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

class GameTopText extends StatelessWidget {
  String text;
  double screenWidth;

  GameTopText(this.text, this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.08));
  }
}
