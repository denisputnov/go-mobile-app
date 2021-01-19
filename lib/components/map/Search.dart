import 'package:flutter/material.dart';

import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 8, MediaQuery.of(context).size.width / 80,
          MediaQuery.of(context).size.width / 80, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          fillColor: Color(0xff575757),
          hintText: "Start typing...",
          hintStyle: TextStyle(color: Color(0xffFFFFFF)),
          suffixIcon: Icon(
            Icons.search,
            size: MediaQuery.of(context).size.width / 10,
            color: context.watch<GoTheme>().backgroundColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
