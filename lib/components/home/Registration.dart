import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/variables/userdata.dart' as userdata;
import '../../utils/default.dart';
import '../../utils/auth.dart';

class RegistrationWidget extends StatefulWidget {
  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  bool isAuthorized = userdata.isAuthorized;
  Image userPhoto = userdata.userPhoto;
  String username = userdata.username;
  String email = userdata.email;

  User user;

  void signOutGoogle() {
    singOutWithGoogle();
    setState(() {
      isAuthorized = false;
    });
  }

  void signInGoogle() {
    signInWithGoogle().then(
      (user) => {
        setState(() {
          this.username = user.displayName;
          this.email = user.email;
          this.userPhoto = Image.network(user.photoURL);
          this.isAuthorized = true;
        })
      },
    );
  }

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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Scaffold(
                              body: CupertinoAlertDialog(
                                title: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text('Выход'),
                                ),
                                content: Text("Вы уверены, что хотите выйти?"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Отмена'),
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('Выйти', style: TextStyle(color: Colors.redAccent)),
                                    onPressed: () {
                                      signOutGoogle();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  DelayedDisplay(
                    slidingBeginOffset: Offset(0.03, 0),
                    delay: Duration(milliseconds: 200),
                    fadingDuration: Duration(milliseconds: 200),
                    child: Container(
                      padding: Default.getDefaultPadding(),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(child: userPhoto, borderRadius: BorderRadius.circular(72)),
                          SizedBox(width: Default.getDefaultPadding(onlyValue: true)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                username,
                                style: TextStyle(color: Colors.white, fontSize: 16),
                                overflow: TextOverflow.fade,
                              ),
                              SizedBox(height: Default.getDefaultPadding(onlyValue: true) / 3),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Default.getDefaultSubtitleColor(),
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
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
                      Text(
                        'Вы не авторизованы. Нажмите, чтобы авторизоваться.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  onTap: this.signInGoogle),
            ),
    );
  }
}
