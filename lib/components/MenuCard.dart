import 'package:flutter/material.dart';

import '../utils/gotheme.dart';
import 'package:provider/provider.dart';

class MenuCard extends StatelessWidget {
  Color startColor;
  Color endColor;
  String label;
  String icon;
  String decorationIcon;
  Widget destination;

  MenuCard({this.startColor, this.endColor, this.label, this.icon, this.decorationIcon, this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, anotrerAnimation) {
              return destination;
            },
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) {
              animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(context.watch<GoTheme>().margin),
        child: CardContent(
            startColor: startColor, endColor: endColor, label: label, icon: icon, decorationIcon: decorationIcon),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardContent extends StatelessWidget {
  Color startColor;
  Color endColor;
  String label;
  String icon;
  String decorationIcon;

  CardContent({this.startColor, this.endColor, this.label, this.icon, this.decorationIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: Default.getDefaultMargin(),
        padding: EdgeInsets.all(context.watch<GoTheme>().padding),
        // height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Align(
              child: Image.asset(icon, width: 40, height: 40),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          image: DecorationImage(
            image: AssetImage(decorationIcon),
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            alignment: Alignment.center,
          ),
          boxShadow: context.watch<GoTheme>().boxShadow,
        ),
      ),
    );
  }
}
