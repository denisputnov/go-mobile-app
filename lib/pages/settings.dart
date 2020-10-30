import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:go/components/AppBar.dart';
import 'package:go/components/settings/SettingsCategory.dart';
import 'package:go/components/settings/SettingsField.dart';
import 'package:go/components/settings/SettingsFooter.dart';

import 'package:go/utils/default.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _settingOne = true;
  bool _settingTwo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      backgroundColor: Default.getDefaultBackgroundColor(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              SettingsCategory(label: "Основные настройки:"),
              SettingsField(label: "Настройка 1", setting: _settingOne),
              SettingsField(label: "Настройка 2", setting: _settingTwo),
              SettingsField(label: "Настройка 3", setting: _settingOne),
              SettingsField(label: "Настройка 4", setting: _settingTwo),
              SettingsField(label: "Настройка 5", setting: _settingTwo),
              SettingsField(label: "Настройка 6", setting: _settingTwo),
              SettingsCategory(label: "Доп. настройки:"),
              SettingsField(label: "Настройка 7", setting: _settingTwo),
              SettingsField(label: "Настройка 8", setting: _settingTwo),
              SettingsField(label: "Настройка 9", setting: _settingTwo),
              SettingsField(label: "Настройка 10", setting: _settingOne),
              SettingsField(label: "Настройка 11", setting: _settingTwo),
              SettingsField(label: "Настройка 12", setting: _settingTwo),
              SettingsField(label: "Настройка 13", setting: _settingTwo),
              SettingsField(label: "Настройка 14", setting: _settingOne),
              SettingsCategory(label: "Аккаунт:"),
              SettingsField(label: "Настройка 15", setting: _settingOne),
              SettingsField(label: "Настройка 16", setting: _settingOne),
              SettingsField(label: "Настройка 17", setting: _settingTwo),
              SettingsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
