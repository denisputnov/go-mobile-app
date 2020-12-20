import 'package:flutter/material.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

class TextFieldWithOwnController extends StatefulWidget {
  dynamic variable;
  TextEditingController controller;
  final Function callback;
  String hint;

  TextFieldWithOwnController({this.variable, this.controller, this.callback, this.hint});
  @override
  _TextFieldWithOwnControllerState createState() => _TextFieldWithOwnControllerState();
}

class _TextFieldWithOwnControllerState extends State<TextFieldWithOwnController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.watch<GoTheme>().secondaryColor,
        borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
        boxShadow: widget.variable.length > 44
            ? context.watch<GoTheme>().redAccentBoxShadow
            : context.watch<GoTheme>().boxShadow,
      ),
      margin: EdgeInsets.all(context.watch<GoTheme>().margin),
      child: TextField(
        style: TextStyle(color: context.watch<GoTheme>().textColor.withOpacity(0.8), decoration: TextDecoration.none),
        controller: widget.controller,
        onChanged: (String value) async {
          widget.callback(value);
          if (value.length == 45) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Превышен лимит символов."),
                elevation: 5,
                action: SnackBarAction(
                  label: "Закрыть",
                  onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
                ),
              ),
            );
          }
        },
        onTap: () => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: context.watch<GoTheme>().textColor.withOpacity(0.5)),
          counterStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: context.watch<GoTheme>().secondaryColor,
        ),
      ),
    );
  }
}
