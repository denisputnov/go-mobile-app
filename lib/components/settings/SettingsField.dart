import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go/utils/default.dart';


class SettingsField extends StatefulWidget {
  String label;
  dynamic setting;

  SettingsField({Key key, this.label, this.setting}) : super(key: key);

  @override
  _SettingsFieldState createState() => _SettingsFieldState(label, setting);
}

class _SettingsFieldState extends State<SettingsField> {
  String label;
  dynamic setting;

  _SettingsFieldState(this.label, this.setting);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Default.getDefaultSecondaryColor(), borderRadius: Default.getDefauilBorderRadius()),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: TextStyle(color: Colors.white)),
            ),
            CupertinoSwitch(
              trackColor: Colors.grey.withOpacity(0.3),
              value: setting,
              onChanged: (bool value) {
                setState(() {
                  setting = value;
                });
              },
            ),
          ],
        ),
        onTap: () {
          setState(() {
            setting = !setting;
          });
        },
      ),
    );
  }
}
