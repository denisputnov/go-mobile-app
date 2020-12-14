import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

class SettingsField extends StatefulWidget {
  String label;
  dynamic setting;
  Function callback;

  SettingsField({Key key, this.label, this.setting, this.callback}) : super(key: key);

  @override
  _SettingsFieldState createState() => _SettingsFieldState();
}

class _SettingsFieldState extends State<SettingsField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.watch<GoTheme>().secondaryColor,
        borderRadius: BorderRadius.circular(
          context.watch<GoTheme>().borderRadius,
        ),
      ),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 4),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(widget.label, style: TextStyle(color: Colors.white)),
            ),
            CupertinoSwitch(
              trackColor: Colors.grey.withOpacity(0.3),
              value: widget.setting,
              onChanged: (bool value) => setState(() {
                widget.setting = value;
                widget.callback();
              }),
            ),
          ],
        ),
        onTap: () {
          setState(() => widget.callback());
        },
      ),
    );
  }
}
