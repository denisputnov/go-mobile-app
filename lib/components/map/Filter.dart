import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _Filter createState() => _Filter();
}

class _Filter extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DraggableScrollableSheet(
            maxChildSize: 0.5,
            initialChildSize: 0.06,
            minChildSize: 0.06,
            builder: (context, ScrollController scrollController) {
              return Container(
                child: Stack(children: [
                  ListView.builder(
                    controller: scrollController,
                    itemCount: 6,
                    itemBuilder: (BuildContext cintext, int index) {
                      return ListTile(
                        title: Text(
                          'Item index',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 30.0,
                    color: Colors.white,
                    thickness: 2.0,
                    indent: 150.0,
                    endIndent: 150.0,
                  )
                ]),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xff212121),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              );
            }));
  }
}
