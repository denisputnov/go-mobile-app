import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/variables/userdata.dart' as userdata;
import '../../utils/gotheme.dart';
import '../../utils/auth.dart';
import 'package:provider/provider.dart';

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
      margin: EdgeInsets.all(context.watch<GoTheme>().margin),
      height: 160,
      decoration: BoxDecoration(
        boxShadow: context.watch<GoTheme>().boxShadow,
        borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
        color: context.watch<GoTheme>().secondaryColor,
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
                      icon: Icon(Icons.logout, color: context.watch<GoTheme>().iconColor),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Scaffold(
                              body: Theme(
                                data: ThemeData.dark(),
                                child: CupertinoAlertDialog(
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
                      padding: EdgeInsets.all(context.watch<GoTheme>().padding),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(child: userPhoto, borderRadius: BorderRadius.circular(72)),
                          SizedBox(width: context.watch<GoTheme>().padding),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                username,
                                style: TextStyle(color: context.watch<GoTheme>().textColor, fontSize: 16),
                                overflow: TextOverflow.fade,
                              ),
                              SizedBox(height: context.watch<GoTheme>().padding / 3),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: context.watch<GoTheme>().subtitleColor,
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
                radius: context.watch<GoTheme>().borderRadius,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      './assets/icons/sad_face.svg',
                      color: context.watch<GoTheme>().textColor,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Вы не авторизованы. Нажмите, чтобы авторизоваться.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.watch<GoTheme>().textColor),
                    )
                  ],
                ),
                onTap: this.signInGoogle,
              ),
            ),
    );
  }
}
