import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefautlAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool hasBackButton;
  String title;
  Color color;

  DefautlAppBar({this.hasBackButton = true, this.title = '', this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
