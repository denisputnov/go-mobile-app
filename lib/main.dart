import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go/pages/menu.dart';
import 'package:provider/provider.dart';

import 'utils/gotheme.dart';

void main() => runApp(Go());

class Go extends StatelessWidget {
  // const Go();
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return ChangeNotifierProvider<GoTheme>(
      create: (context) => GoTheme(),
      child: Builder(
        builder: (BuildContext context) => MaterialApp(
          title: 'Go',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Comfortaa',
            backgroundColor: context.watch<GoTheme>().backgroundColor,
            canvasColor: Colors.transparent,
          ),
          home: Menu(),
        ),
      ),
    );
  }
}

mixin PortraitModeMixin on StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return null;
  }
}

mixin PortraitStatefulModeMixin<T extends StatefulWidget> on State<T> {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return null;
  }

  @override
  void dispose() {
    _enableRotation();
  }
}

/// blocks rotation; sets orientation to: portrait
void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void _enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}
