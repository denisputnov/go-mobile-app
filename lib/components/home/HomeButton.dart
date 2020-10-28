import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go/utils/launchUrl.dart';

import '../../utils/default.dart';

class HomeButton extends StatelessWidget {
  String title;
  IconData icon;
  Widget destination;
  String url;
  double iconSize;

  HomeButton({this.title, this.icon, this.iconSize, this.destination, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: Default.getDefaultPadding(),
      margin: Default.getDefaultMargin(),
      decoration: BoxDecoration(
        boxShadow: Default.getDefaultBoxShadow(),
        color: Default.getDefaultSecondaryColor(),
        borderRadius: Default.getDefauilBorderRadius(),
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          children: <Widget>[
            FaIcon(icon, color: Default.getDefaultIconColor(), size: iconSize),
            SizedBox(width: Default.getDefaultMargin(onlyValue: true) * 2),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                title,
                style: Default.getDefaultTextStyle(fsz: 16),
                // overflow: TextOverflow.ellipsis
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward_ios, color: Default.getDefaultIconColor(), size: 30),
              ),
            ),
          ],
        ),
        onTap: () async {
          url == null
              ? Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, anotrerAnimation) {
                      return destination;
                    },
                    transitionDuration: Duration(milliseconds: 300),
                    transitionsBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation, Widget child) {
                      animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
                      return new SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                )
              : launchUrl(url);
        },
      ),
    );
  }
}
