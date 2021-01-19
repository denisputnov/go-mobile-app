import 'package:flutter/material.dart';

class Back extends StatefulWidget {
  @override
  _Back createState() => _Back();
}

class _Back extends State<Back> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 50,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
