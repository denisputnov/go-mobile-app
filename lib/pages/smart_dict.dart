import 'package:flutter/material.dart';
import 'package:go/components/AppBar.dart';

import 'package:go/utils/default.dart';

class SmartDict extends StatefulWidget {
  String imageSrc;

  SmartDict({this.imageSrc});

  @override
  _SmartDict createState() => _SmartDict();
}

class _SmartDict extends State<SmartDict> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SmartDictBackground(imageSrc: widget.imageSrc),
        SmartDictContent(),
      ],
    );
  }
}

class SmartDictContent extends StatefulWidget {
  @override
  _SmartDictContentState createState() => _SmartDictContentState();
}

class _SmartDictContentState extends State<SmartDictContent> {
  @override
  Widget build(BuildContext context) {
    final questions = <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        margin: Default.getDefaultMargin(),
        child: Scaffold(
          appBar: DefaultAppBar(),
        ),
      ),
    ];
    
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Container(
            padding: index != 0 ? EdgeInsets.symmetric(horizontal: Default.getDefaultPadding(onlyValue: true)) : null,
            child: Wrap(
              children: [questions[index]],
            ),
          );
        },
      ),
    );
  }
}

class SmartDictBackground extends StatefulWidget {
  String imageSrc;

  SmartDictBackground({this.imageSrc});

  @override
  _SmartDictBackgroundState createState() => _SmartDictBackgroundState();
}

class _SmartDictBackgroundState extends State<SmartDictBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Default.getDefaultBackgroundColor(),
      // appBar: DefaultAppBar(),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: Default.getDefaultMargin(),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.4,
                child: ClipRRect(
                  borderRadius: Default.getDefauilBorderRadius(),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.8)],
                        stops: [0, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      widget.imageSrc,
                      repeat: ImageRepeat.noRepeat,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
