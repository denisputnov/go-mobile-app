import 'package:flutter/material.dart';

import '../../utils/default.dart';

class NewsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.9 * 9 / 16,
      // padding: EdgeInsets.only(left: Default.getDefaultMargin(onlyValue: true)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: <Widget>[
            // SizedBox(width: Default.getDefaultMargin(onlyValue: true)),
            SliderCard(color: Colors.cyan, number: '1'),
            SliderCard(color: Colors.red, number: '2'),
            SliderCard(color: Colors.green, number: '3'),
            SliderCard(color: Colors.amber, number: '4'),
            // SizedBox(width: Default.getDefaultMargin(onlyValue: true)),
          ],
        ),
      ),
    );
  }
}

class SliderCard extends StatelessWidget {
  String number;
  Color color;

  SliderCard({this.number, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: Default.getDefaultMargin(),
      decoration: BoxDecoration(borderRadius: Default.getDefauilBorderRadius(), color: this.color),
      child: Center(child: Text(this.number)),
    );
  }
}
