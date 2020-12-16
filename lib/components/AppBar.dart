import 'package:flutter/material.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool hasBackButton;
  String title;
  Color color;
  Color backgroundColor;

  DefaultAppBar({this.hasBackButton = true, this.title = '', this.color = Colors.white, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    this.color = context.watch<GoTheme>().textColor;
    return SafeArea(
      child: Container(
        decoration: backgroundColor == null
            ? BoxDecoration()
            : BoxDecoration(
                color: backgroundColor,
                boxShadow: context.watch<GoTheme>().boxShadow,
              ),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: this.color),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                this.title,
                style: TextStyle(color: this.color, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
