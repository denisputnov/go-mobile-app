import 'dart:ui';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/AppBar.dart';

import '../pages/smart_dict.dart';
import '../pages/info_dict.dart';

import 'package:go/utils/default.dart';

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Default.getDefaultBackgroundColor(),
      appBar: DefaultAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            DisctionaryCard(
              destination: SmartDict(imageSrc: 'assets/icons/smart_dict.jpg'),
              imageSrc: 'assets/icons/smart_dict.jpg',
              startColor: Color(0xff0acffe).withOpacity(0.8),
              endColor: Color(0xff495aff).withOpacity(0.8),
              label: "Куда мне поехать?\nПомощник поможет выбрать путь!",
              duration: 200,
            ),
            DisctionaryCard(
              destination: InfoDict(),
              imageSrc: 'assets/icons/info_dict.jpg',
              startColor: Color(0xff9be15d).withOpacity(0.4),
              endColor: Color(0xff9be15d).withOpacity(0.4),
              label: "Информация о разных туристических местах",
              duration: 300,
            )
          ],
        ),
      ),
    );
  }
}

class DisctionaryCard extends StatelessWidget {
  Widget destination;
  String imageSrc;
  Color startColor;
  Color endColor;
  String label;
  Color fontColor;
  double fontSize;
  int duration; 

  DisctionaryCard(
      {this.destination, this.imageSrc, this.startColor, this.endColor, this.label, this.fontColor = Colors.white, this.duration});

  @override
  Widget build(BuildContext context) {
    fontSize = MediaQuery.of(context).size.width / 20;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: DelayedDisplay(
        delay: Duration(milliseconds: duration),
        slidingBeginOffset: Offset(0, 0.15),
        fadingDuration: Duration(milliseconds: duration),
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width * 0.8,
          margin: Default.getDefaultMargin(),
          child: Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: Default.getDefauilBorderRadius(),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [startColor, endColor],
                          stops: [0, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
                      child: Image.asset(
                        imageSrc,
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Default.getDefaultPadding(onlyValue: true) * 2),
                      child: Text(
                        label,
                        style: TextStyle(color: fontColor, fontSize: fontSize),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
