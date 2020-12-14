import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go/utils/launchUrl.dart';

import '../../utils/gotheme.dart';
import 'package:provider/provider.dart';

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
      padding: EdgeInsets.all(context.watch<GoTheme>().padding),
      margin: EdgeInsets.all(context.watch<GoTheme>().margin),
      decoration: BoxDecoration(
        boxShadow: context.watch<GoTheme>().boxShadow,
        color: context.watch<GoTheme>().secondaryColor,
        borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          children: <Widget>[
            FaIcon(icon, color: context.watch<GoTheme>().iconColor, size: iconSize),
            SizedBox(width: context.watch<GoTheme>().margin * 2),
            Expanded(
              child: SizedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    color: context.watch<GoTheme>().textColor,
                    fontSize: MediaQuery.of(context).size.width / 25,
                    fontWeight: FontWeight.w400,
                  ),
                  // overflow: TextOverflow.ellipsis
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios, color: context.watch<GoTheme>().iconColor, size: 30),
            ),
          ],
        ),
        onTap: () async {
          url == null
              ? await Navigator.of(context).push(
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
