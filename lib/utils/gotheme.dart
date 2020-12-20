import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import './variables/settings.dart' as settings;

// ignore: unused_element
class GoTheme with ChangeNotifier {
  Color _textColor = Colors.white;
  Color _backgroundColor = Color(0xff212121);
  Color _secondaryColor = Color(0xff313131);
  Color _thirdlyColor = Color(0xff3B3B3B);
  Color _subtitleColor = Color(0xff575757);
  Color _iconColor = Color(0xff575757);
  bool _isDarkTheme = true;

  List<BoxShadow> _boxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 8,
      spreadRadius: 1,
    ),
  ];

  List<BoxShadow> _redAccentBoxShadow = [
    BoxShadow(
      color: Colors.redAccent.withOpacity(0.5),
      blurRadius: 8,
      spreadRadius: 1,
    ),
  ];

  void applyDarkTheme() {
    _textColor = Colors.white;
    _backgroundColor = Color(0xff212121);
    _secondaryColor = Color(0xff313131);
    _thirdlyColor = Color(0xff3B3B3B);
    _subtitleColor = Color(0xff575757);
    _iconColor = Color(0xff575757);

    _isDarkTheme = true;

    _boxShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 8,
        spreadRadius: 1,
      ),
    ];

    notifyListeners();
  }

  void applyWhiteTheme() {
    _textColor = Color(0xFF5A5A5A);
    _backgroundColor = Colors.white;
    _secondaryColor = Color(0xFFF3F3F3);
    _thirdlyColor = Color(0xFFE1E1E1);
    _subtitleColor = Color(0xFFA3A3A3);
    _iconColor = Color(0xFF9D9D9D);

    _isDarkTheme = false;

    _boxShadow = null;

    notifyListeners();
  }

  bool get isDarkTheme => _isDarkTheme;
  Color get textColor => _textColor;
  List<BoxShadow> get boxShadow => _boxShadow;
  List<BoxShadow> get redAccentBoxShadow => _redAccentBoxShadow;
  double get margin => 8.0;
  double get padding => 16.0;
  double get borderRadius => 16;
  Color get backgroundColor => _backgroundColor;
  Color get secondaryColor => _secondaryColor;
  Color get thirdlyColor => _thirdlyColor;
  Color get subtitleColor => _subtitleColor;
  Color get iconColor => _iconColor;
  Color get linkColor => Colors.indigo;
}
