import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:go/utils/default.dart';

import '../components/games/GamesTopText.dart';
import '../components/games/GamesAppBar.dart';
import '../components/games/GameCard.dart';

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
                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.32, horizontal: screenWidth * 0.15),
                  height: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(circularRadiusForBackgroundDecoration),
                      bottomRight: Radius.circular(circularRadiusForBackgroundDecoration),
                    ),
                    gradient: LinearGradient(
                        colors: [Color(0xffe11030), Color(0xffb482bf)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topLeft),
                    image: DecorationImage(
                      image: AssetImage('./assets/icons/menu/game-decoration.png'),
                      fit: BoxFit.fill,
                      repeat: ImageRepeat.noRepeat,
                      alignment: Alignment.center,
                    ),
                  ),
                  child: DelayedDisplay(
                    delay: Duration(milliseconds: 250),
                    fadingDuration: Duration(milliseconds: 250),
                    slidingBeginOffset: Offset(0, -0.10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GameTopText('играй', screenWidth),
                        GameTopText('развлекайся', screenWidth),
                        GameTopText('получай скидки', screenWidth),
                      ],
                    ),
                  ),
                ),
                GamesAppBar(),
                Container(
                  margin: EdgeInsets.only(top: screenWidth - 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GameCard(),
                      GameCard(),
                      GameCard(),
                      GameCard(),
                      GameCard(),
                      GameCard(),
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
