import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:go/utils/filter_icons.dart';
import 'package:go/utils/variables/filter.dart' as filter;

class Filter extends StatefulWidget {
  @override
  _Filter createState() => _Filter();
}

class _ListItem {
  _ListItem({this.icons, this.value, this.checked});
  var icons;
  final String value;
  bool checked;
}

class _Filter extends State<Filter> {
  List<_ListItem> _items = [
    _ListItem(
      checked: filter.fastfood,
      icons: IcoFontIcons.burger,
      value: 'Fastfood',
    ),
    _ListItem(
      checked: filter.restaurant,
      icons: IcoFontIcons.restaurant,
      value: 'Restaurant',
    ),
    _ListItem(
      checked: filter.mall,
      icons: IcoFontIcons.bag,
      value: 'Mall',
    ),
    _ListItem(
      checked: filter.museum,
      icons: IcoFontIcons.bankAlt,
      value: 'Museum',
    ),
    _ListItem(
      checked: filter.pharmacy,
      icons: IcoFontIcons.pills,
      value: 'Pharmacy',
    ),
    _ListItem(
      checked: filter.hospital,
      icons: IcoFontIcons.hospital,
      value: 'Hospital',
    ),
    _ListItem(
      checked: filter.hotel,
      icons: IcoFontIcons.hotel,
      value: 'Hotel',
    ),
    _ListItem(
      checked: filter.bank,
      icons: IcoFontIcons.money,
      value: 'Bank',
    ),
    _ListItem(
      checked: filter.sight,
      icons: IcoFontIcons.star,
      value: 'Sight',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _listeTiles = _items
        .map(
          (item) => CheckboxListTile(
            controlAffinity: ListTileControlAffinity.platform,
            key: Key(item.value),
            value: item.checked ?? false,
            onChanged: (bool newValue) {
              if (item.value == 'Fastfood') {
                setState(() => item.checked = filter.fastfood = newValue);
              }
              if (item.value == 'Restaurant') {
                setState(() => item.checked = filter.restaurant = newValue);
              }
              if (item.value == 'Hotel') {
                setState(() => item.checked = filter.hotel = newValue);
              }
              if (item.value == 'Mall') {
                setState(() => item.checked = filter.mall = newValue);
              }
              if (item.value == 'Sight') {
                setState(() => item.checked = filter.sight = newValue);
              }
              if (item.value == 'Museum') {
                setState(() => item.checked = filter.museum = newValue);
              }
              if (item.value == 'Bank') {
                setState(() => item.checked = filter.bank = newValue);
              }
              if (item.value == 'Pharmacy') {
                setState(() => item.checked = filter.pharmacy = newValue);
              }
              if (item.value == 'Hospital') {
                setState(() => item.checked = filter.hospital = newValue);
              }
            },
            title: Text(
              '${item.value}',
              style: TextStyle(color: Colors.white),
            ),
            secondary: Icon(
              item.icons,
              color: Colors.white,
              size: MediaQuery.of(context).size.width / 12,
            ),
          ),
        )
        .toList();
    return Scaffold(
        body: Stack(
      children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white,
            fontFamily: 'Comfortaa',
            canvasColor: Colors.transparent,
          ),
          child: ListView(
            children: _listeTiles,
          ),
        ),
      ],
    ));
  }
}
