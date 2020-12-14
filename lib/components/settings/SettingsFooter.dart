import "package:go/components/settings/SettingsFooterComponent.dart";
import 'package:flutter/material.dart';
import 'package:go/utils/gotheme.dart';
import 'package:go/utils/application.dart';
import 'package:provider/provider.dart';

class SettingsFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.watch<GoTheme>().margin * 2),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SettingsFooterComponent(
            label: "Есть проблема? ",
            buttonLabel: "Напиши нам!",
            url: "https://putnov.ru",
          ),
          SettingsFooterComponent(label: Application.version()),
        ],
      ),
    );
  }
}
