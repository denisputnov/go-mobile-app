import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go/utils/gotheme.dart';

import '../components/games/GamesTopText.dart';
import '../components/games/GamesAppBar.dart';
import '../components/games/GameCard.dart';

import 'package:provider/provider.dart';

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

    return Material(
      child: Scaffold(
        backgroundColor: context.watch<GoTheme>().backgroundColor,
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
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 400),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        GameCard(
                          image:
                              "http://i.piccy.info/i9/924a8cac61624681da603a5738b462a4/1606300145/148353/1391381/coffe.png",
                          startColor: Color(0xffC28456),
                          endColor: Colors.white.withOpacity(0),
                          startGradientPos: 0,
                          endGradientPos: 1,
                          contentColor: Colors.white,
                          category: "Подпишись в соцсетях",
                          categoryFontSize: 14,
                          icon: Icons.settings,
                          title: 'Кофе "Coffies co скидкой 10%"',
                          titleFontSize: 30,
                          isBoldTitle: true,
                        ),
                        GameCard(
                          image:
                              "http://i.piccy.info/i9/924a8cac61624681da603a5738b462a4/1606300145/148353/1391381/coffe.png",
                          startColor: Color(0xffC28456),
                          endColor: Colors.white.withOpacity(0),
                          startGradientPos: 0,
                          endGradientPos: 1,
                          contentColor: Colors.white,
                          category: "Подпишись в соцсетях",
                          categoryFontSize: 14,
                          icon: Icons.settings,
                          title: 'Кофе "Coffies co скидкой 10%"',
                          titleFontSize: 30,
                          isBoldTitle: true,
                        ),
                        GameCard(
                          image:
                              "http://i.piccy.info/i9/924a8cac61624681da603a5738b462a4/1606300145/148353/1391381/coffe.png",
                          startColor: Color(0xffC28456),
                          endColor: Colors.white.withOpacity(0),
                          startGradientPos: 0,
                          endGradientPos: 1,
                          contentColor: Colors.white,
                          category: "Подпишись в соцсетях",
                          categoryFontSize: 14,
                          icon: Icons.settings,
                          title: 'Кофе "Coffies co скидкой 10%"',
                          titleFontSize: 30,
                          isBoldTitle: true,
                        ),
                        GameCard(
                          image:
                              "http://i.piccy.info/i9/924a8cac61624681da603a5738b462a4/1606300145/148353/1391381/coffe.png",
                          startColor: Color(0xffC28456),
                          endColor: Colors.white.withOpacity(0),
                          startGradientPos: 0,
                          endGradientPos: 1,
                          contentColor: Colors.white,
                          category: "Подпишись в соцсетях",
                          categoryFontSize: 14,
                          icon: Icons.settings,
                          title: 'Кофе "Coffies co скидкой 10%"',
                          titleFontSize: 30,
                          isBoldTitle: true,
                        ),
                        GameCard(
                          image:
                              "http://i.piccy.info/i9/924a8cac61624681da603a5738b462a4/1606300145/148353/1391381/coffe.png",
                          startColor: Color(0xffC28456),
                          endColor: Colors.white.withOpacity(0),
                          startGradientPos: 0,
                          endGradientPos: 1,
                          contentColor: Colors.white,
                          category: "Подпишись в соцсетях",
                          categoryFontSize: 14,
                          icon: Icons.settings,
                          title: 'Кофе "Coffies co скидкой 10%"',
                          titleFontSize: 30,
                          isBoldTitle: true,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
