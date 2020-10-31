import 'package:flutter/material.dart';
import 'package:go/components/Back.dart';

import '../components/Back.dart';
import '../pages/smart_dict.dart';
import '../pages/info_dict.dart';

import 'package:go/utils/default.dart';

class Dict extends StatefulWidget {
  final label;

  Dict({this.label});

  @override
  _Dict createState() => _Dict(label);
}

class _Dict extends State<Dict> {
  final label;

  _Dict(this.label);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: label,
        child: Material(
            child: Scaffold(
                backgroundColor: Default.getDefaultBackgroundColor(),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Stack(children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SmartDict(label: "SmartDict")));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                            colors: [
                                          Color(0x07D95BA),
                                          Color(0xff8E86BF)
                                        ],
                                            stops: [
                                          0.0,
                                          1.0
                                        ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)
                                        .createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: Image.asset(
                                    './assets/icons/smart_dict.jpg',
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InfotDict(label: "InfoDict")));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                            colors: [
                                          Color(0x0FFFFFF),
                                          Color(0xff9720C0)
                                        ],
                                            stops: [
                                          0.0,
                                          1.0
                                        ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)
                                        .createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: Image.asset(
                                    './assets/icons/info_dict.jpg',
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Back(),
                    ]),
                  ),
                ))));
  }
}
