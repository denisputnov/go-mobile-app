import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:go/components/AppBar.dart';
import 'package:go/components/settings/SettingsCategory.dart';
import 'package:go/components/settings/SettingsField.dart';
import 'package:go/components/settings/SettingsFooter.dart';

import 'package:go/utils/gotheme.dart';
import 'package:go/utils/launchUrl.dart';
import 'package:go/utils/variables/webconstructor.dart';
import 'package:provider/provider.dart';

import 'package:go/utils/variables/userdata.dart' as userdata;
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = context.watch<GoTheme>().isDarkTheme;

    String activationString =
        userdata.canAddGames ? 'Творческий аккаунт активирован' : 'Активировать творческий аккаунт';

    void changeTheme() {
      isDarkTheme ? context.read<GoTheme>().applyWhiteTheme() : context.read<GoTheme>().applyDarkTheme();
      isDarkTheme = !isDarkTheme;
    }

    return Scaffold(
      appBar: DefaultAppBar(),
      backgroundColor: context.watch<GoTheme>().backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              SettingsCategory(label: "Основные настройки:"),
              SettingsField(label: "Тёмная тема", setting: isDarkTheme, callback: changeTheme),
              SettingsCategory(label: "Аккаунт:"),
              GestureDetector(
                onTap: () {
                  if (userdata.canAddGames) return;
                  if (userdata.isAuthorized) {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: Theme(
                            data: context.watch<GoTheme>().isDarkTheme ? ThemeData.dark() : ThemeData.light(),
                            child: CupertinoAlertDialog(
                              content: Text(
                                "Творческий аккаунт создан для владельцев собственных точек интереса, бизнеса.\n\nПосле получения ключа активации вам открывается возможность создания собствтенных акций и игр во встроенном конструкторе.\n\nМы готовы поделиться своей аудиторией в обмен на акцию для неё ;)",
                                style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
                                textAlign: TextAlign.start,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Как получить ключ?'),
                                  onPressed: () {
                                    launchUrl('https:/vk.com');
                                    // Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  // isDefaultAction: true,
                                  child: Text(
                                    'Ввести ключ',
                                    // style: TextStyle(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    TextEditingController _controller = TextEditingController();
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Scaffold(
                                          body: Theme(
                                            data: context.watch<GoTheme>().isDarkTheme
                                                ? ThemeData.dark()
                                                : ThemeData.light(),
                                            child: CupertinoAlertDialog(
                                              content: TextField(
                                                onChanged: (newString) {},
                                                controller: _controller,
                                                keyboardType: TextInputType.multiline,
                                                maxLines: null,
                                                style: TextStyle(color: context.watch<GoTheme>().textColor),
                                                cursorColor: context.watch<GoTheme>().textColor.withOpacity(0.8),
                                                decoration: InputDecoration(
                                                  hintText: 'Ваш ключ активации',
                                                  hintStyle: TextStyle(
                                                    color: context.watch<GoTheme>().textColor.withOpacity(0.5),
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                CupertinoDialogAction(
                                                  child: Text('Проверить'),
                                                  onPressed: () {
                                                    if (_controller.text == userdata.uid) {
                                                      userdata.canAddGames = true;
                                                      setState(() {});
                                                    } else {}
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
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text(
                                    'Отменить',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: Theme(
                            data: context.watch<GoTheme>().isDarkTheme ? ThemeData.dark() : ThemeData.light(),
                            child: CupertinoAlertDialog(
                              content: Text(
                                "Для выполнения действия необходимо авторизоваться",
                                style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Понятно'),
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: context.watch<GoTheme>().secondaryColor,
                    borderRadius: BorderRadius.circular(
                      context.watch<GoTheme>().borderRadius,
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  width: double.infinity,
                  height: 48,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activationString,
                        style: TextStyle(
                          color: context.watch<GoTheme>().textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SettingsFooter(),
              FlatButton(
                  onPressed: () {
                    userdata.canAddGames = false;
                    setState(() {});
                  },
                  child: Text('ыврдпрвы'))
            ],
          ),
        ),
      ),
    );
  }
}
