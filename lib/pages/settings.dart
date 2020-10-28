import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:go/components/AppBar.dart';
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
              Container(
                decoration:
                    BoxDecoration(color: Default.getDefaultSecondaryColor(), borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: ListTile(
                  title: Text("Настройка 1", style: TextStyle(color: Colors.white)),
                  trailing: CupertinoSwitch(
                    trackColor: Colors.grey.withOpacity(0.3),
                    value: _settingOne,
                    onChanged: (bool value) {
                      setState(() {
                        _settingOne = value;
                        print(_settingOne);
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _settingOne = !_settingOne;
                      print(_settingOne);
                    });
                  },
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Default.getDefaultSecondaryColor(), borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: ListTile(
                  title: Text("Настройка 2", style: TextStyle(color: Colors.white)),
                  trailing: CupertinoSwitch(
                    trackColor: Colors.grey.withOpacity(0.3),
                    value: _settingTwo,
                    onChanged: (bool value) {
                      setState(() {
                        _settingTwo = value;
                        print(_settingTwo);
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _settingTwo = !_settingTwo;
                      print(_settingTwo);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
