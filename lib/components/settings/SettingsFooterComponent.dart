import 'package:go/utils/gotheme.dart';
import 'package:go/utils/launchUrl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsFooterComponent extends StatelessWidget {
  String label;
  String url;
  String buttonLabel;

  SettingsFooterComponent({this.label = '', this.url = '', this.buttonLabel = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.watch<GoTheme>().margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: context.watch<GoTheme>().subtitleColor, fontSize: 12)),
          GestureDetector(
            child: Text(buttonLabel, style: TextStyle(color: context.watch<GoTheme>().linkColor, fontSize: 12)),
            onTap: () => launchUrl(url),
          ),
        ],
      ),
    );
  }
}
