import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/default.dart';

class RegistrationWidget extends StatefulWidget {
  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  bool isAuthorized = false;
  Image userPhoto = Image.asset('./assets/icons/denis.jpg');
  String username = "Denis Putnov";
  String email = "your@email.com";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(Default.getDefaultMargin(onlyValue: true)),
      height: 160,
      decoration: BoxDecoration(
        boxShadow: Default.getDefaultBoxShadow(),
        borderRadius: Default.getDefauilBorderRadius(),
        color: Default.getDefaultSecondaryColor(),
      ),
      child: isAuthorized
          ? Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.logout, color: Default.getDefaultIconColor()),
                      onPressed: () {
                        setState(() {
                          isAuthorized = false;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: Default.getDefaultPadding(),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(child: userPhoto, borderRadius: BorderRadius.circular(72)),
                        SizedBox(width: Default.getDefaultPadding(onlyValue: true)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(username, style: TextStyle(color: Colors.white, fontSize: 20)),
                            SizedBox(height: Default.getDefaultPadding(onlyValue: true) * 2/3 ),
                            Text(email, style: TextStyle(color: Default.getDefaultSubtitleColor(),),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                radius: Default.getDefauilBorderRadius(onlyValue: true),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('./assets/icons/sad_face.svg'),
                    SizedBox(height: 20),
                    Text('Вы не авторизованы. Нажмите, чтобы авторизоваться.',
                        textAlign: TextAlign.center, style: TextStyle(color: Colors.white))
                  ],
                ),
                onTap: () {
                  setState(() {
                    isAuthorized = true;
                  });
                },
              ),
            ),
    );
  }
}
