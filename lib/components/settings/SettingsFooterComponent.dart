import 'package:go/utils/default.dart';
import 'package:go/utils/launchUrl.dart';
import 'package:flutter/material.dart';

class SettingsFooterComponent extends StatelessWidget {
  String label;
  String url;
  String buttonLabel;

  SettingsFooterComponent({this.label = '', this.url = '', this.buttonLabel = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Default.getDefaultMargin(onlyValue: true)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Default.getDefaultSubtitleColor(), fontSize: 12)),
          GestureDetector(
            child: Text(buttonLabel, style: TextStyle(color: Default.getDefaultLinkColor(), fontSize: 12)),
            onTap: () => launchUrl(url),
          ),
        ],
      ),
    );
  }
}
