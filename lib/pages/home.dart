import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/settings.dart';
import '../components/AppBar.dart';
import '../components/home/NewsSlider.dart';
import '../components/home/Registration.dart';
import '../components/home/HomeButton.dart';

import '../utils/gotheme.dart';
import 'package:go/utils/application.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final label;

  Home({this.label});

  @override
  _HomeState createState() => _HomeState(label: label);
}

class _HomeState extends State<Home> {
  final label;

  _HomeState({this.label});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: label,
      child: Material(
        child: Scaffold(
          appBar: DefaultAppBar(),
          backgroundColor: context.watch<GoTheme>().backgroundColor,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 400),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: <Widget>[
                    NewsSlider(),
                    RegistrationWidget(),
                    HomeButton(title: 'Настройки', icon: Icons.settings, iconSize: 35, destination: Settings()),
                    HomeButton(
                      title: 'Политика конфиденциальности',
                      icon: FontAwesomeIcons.balanceScale,
                      iconSize: 27,
                      url: "https://google.com",
                    ),
                    HomeButton(title: 'О нас', icon: Icons.info_outline, iconSize: 35, url: "https://putnov.ru"),
                    SizedBox(height: 10),
                    Text(Application.version(),
                        style: TextStyle(color: context.watch<GoTheme>().subtitleColor, fontSize: 12))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
