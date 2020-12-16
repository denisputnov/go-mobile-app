import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:go/components/AppBar.dart';
import 'package:go/components/settings/SettingsCategory.dart';
import 'package:go/components/settings/SettingsField.dart';
import 'package:go/components/settings/SettingsFooter.dart';

import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = context.watch<GoTheme>().textColor == Colors.white ? true : false;

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
              SettingsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
