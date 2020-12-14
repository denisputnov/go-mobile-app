import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

import 'package:go/components/AppBar.dart';
import 'package:go/components/games/GameCard.dart';

import 'package:go/components/gameconstructor/TextFieldWithOwnController.dart';

import 'package:go/utils/gotheme.dart';
import 'package:go/utils/variables/userdata.dart' as userdata;
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:go/components/gameconstructor/webconstructor.dart';

bool confirmed = false;

class GameConstrucor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Конструктор"),
      backgroundColor: context.watch<GoTheme>().backgroundColor,
      body: userdata.isAuthorized && userdata.canAddGames ? CanAddGames() : CanNotAddGames(),
      floatingActionButton: userdata.isAuthorized && userdata.canAddGames ? FAB() : null,
    );
  }
}

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (confirmed) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, anotrerAnimation) {
                return WebConstructor();
              },
              transitionDuration: Duration(milliseconds: 300),
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
        } else {
          print(confirmed);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Заполнены не все обязательные поля",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
              ),
              elevation: 5,
              action: SnackBarAction(
                label: "Закрыть",
                onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
              ),
            ),
          );
        }
      },
      backgroundColor: context.watch<GoTheme>().secondaryColor,
      elevation: 3,
      label: Text("Пройти далее"),
      icon: Icon(Icons.watch_later),
    );
  }
}

class CanAddGames extends StatefulWidget {
  @override
  _CanAddGamesState createState() => _CanAddGamesState();
}

class _CanAddGamesState extends State<CanAddGames> {
  dynamic image = 'http://i.piccy.info/i9/c3fd1388384dc1da73d3516934875cf4/1606301020/131593/1391381/Frame_8.jpg';
  Color startColor = Colors.black.withOpacity(0.6);
  Color endColor = Colors.black.withOpacity(0);
  double startGradientPos = 0.0;
  double endGradientPos = 1.0;
  Color contentColor = Colors.white;
  String category = "Категория";
  double categoryFontSize = 14;
  IconData icon = Icons.add;
  String title = "Название";
  double titleFontSize;
  bool isBoldTitle = true;

  TextEditingController _titleController;

  List _categories = [
    ["Подписаться в соцсетях", Icons.group_add],
    ["Пройти опрос", Icons.insert_chart],
    ["Найти...", Icons.search],
    ["Перейти на сайт", Icons.laptop_mac],
    ["Пригласить друга", Icons.group],
    ["Другое", Icons.sentiment_very_satisfied],
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    confirmed = false;
  }

  void checkForm() {
    if (image != 'http://i.piccy.info/i9/c3fd1388384dc1da73d3516934875cf4/1606301020/131593/1391381/Frame_8.jpg' &&
        category != "Категория" &&
        icon != Icons.add &&
        title != "Название") confirmed = true;
  }

  void changeTitle(String value) {
    setState(() => title = value);
    checkForm();
  }

  void changeStartColor(Color color, double opacity) {
    setState(() => startColor = color.withOpacity(opacity));
  }

  void changeEndColor(Color color, double opacity) {
    setState(() => endColor = color.withOpacity(opacity));
  }

  void changeCategory(int index) {
    setState(() {
      category = _categories[index][0];
      icon = _categories[index][1];
    });
    checkForm();
  }

  void changeImage(dynamic img) {
    setState(() => image = img);
    checkForm();
  }

  @override
  Widget build(BuildContext context) {
    titleFontSize = MediaQuery.of(context).size.width / 15;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          GameCard(
            image: image,
            startColor: startColor,
            endColor: endColor,
            startGradientPos: startGradientPos,
            endGradientPos: endGradientPos,
            contentColor: contentColor,
            category: category,
            categoryFontSize: categoryFontSize,
            icon: icon,
            title: title,
            titleFontSize: titleFontSize,
            isBoldTitle: isBoldTitle,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ColorPicker(
                    label: "Начальный\nцвет",
                    color: startColor,
                    callback: changeStartColor,
                  ),
                  ColorPicker(
                    label: "Конечный\nцвет",
                    color: endColor,
                    callback: changeEndColor,
                  ),
                ],
              ),
              TextFieldWithOwnController(
                controller: _titleController,
                variable: title,
                hint: "Название",
                callback: changeTitle,
              ),
              BottomSelector(
                items: _categories,
                callback: changeCategory,
                now: category,
                title: "Выбрать категорю:",
              ),
              GalleryImagePicker(callback: changeImage, title: "Выбрать фото"),
            ],
          ),
        ],
      ),
    );
  }
}

class CanNotAddGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.watch<GoTheme>().padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "У вас нет возможности добавлять свои игры. Чтобы получить доступ к конструктору необходимо активировать аккаунт.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          FlatButton(
            onPressed: () {},
            padding: EdgeInsets.all(context.watch<GoTheme>().padding),
            color: context.watch<GoTheme>().secondaryColor,
            splashColor: context.watch<GoTheme>().thirdlyColor,
            textColor: Colors.white,
            child: Text('Узнать подробнее'),
          )
        ],
      ),
    );
  }
}

class GalleryImagePicker extends StatefulWidget {
  Function callback;
  String title;

  GalleryImagePicker({@required this.callback, @required this.title});

  @override
  _GalleryImagePickerState createState() => _GalleryImagePickerState();
}

class _GalleryImagePickerState extends State<GalleryImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future getImage(source) async {
    double screenWidth = MediaQuery.of(context).size.width;

    double cardWidth = screenWidth - context.watch<GoTheme>().margin * 2;
    double cardHeight = cardWidth * 9 / 16;

    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.callback(Image.file(
          _image,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover,
          width: cardWidth,
          height: cardHeight,
        ));
      }
    });
  }

  TextStyle modalItemTextStyle = TextStyle(color: Colors.white.withOpacity(0.8));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: context.watch<GoTheme>().boxShadow,
              color: context.watch<GoTheme>().secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  context.watch<GoTheme>().borderRadius,
                ),
                topRight: Radius.circular(
                  context.watch<GoTheme>().borderRadius,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: context.watch<GoTheme>().thirdlyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Wrap(
                  children: [
                    FlatButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        child: Text('Выбрать на устройстве', style: modalItemTextStyle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      child: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.all(context.watch<GoTheme>().margin),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          color: context.watch<GoTheme>().secondaryColor,
          boxShadow: context.watch<GoTheme>().boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Icon(Icons.add_a_photo, color: Colors.white.withOpacity(0.5)),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

class BottomSelector extends StatefulWidget {
  List items;
  Function callback;
  String now;
  String title;

  BottomSelector({@required this.items, @required this.callback, @required this.now, @required this.title});

  @override
  _BottomSelectorState createState() => _BottomSelectorState();
}

class _BottomSelectorState extends State<BottomSelector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: context.watch<GoTheme>().boxShadow,
              color: context.watch<GoTheme>().secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  context.watch<GoTheme>().borderRadius,
                ),
                topRight: Radius.circular(
                  context.watch<GoTheme>().borderRadius,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: context.watch<GoTheme>().thirdlyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Wrap(
                  children: List<FlatButton>.generate(
                    widget.items.length,
                    (index) {
                      return FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          return widget.callback(index);
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            widget.items[index][0],
                            style: TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      child: Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.all(context.watch<GoTheme>().margin),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: context.watch<GoTheme>().secondaryColor,
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          boxShadow: context.watch<GoTheme>().boxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${widget.title}", style: TextStyle(color: Colors.white.withOpacity(0.5))),
            Text("${widget.now}", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  String label;
  Color color;
  Function callback;

  ColorPicker({this.label, this.color, this.callback});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    double opacity = widget.color.opacity;
    double _size = MediaQuery.of(context).size.width / 1.8;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          return showDialog(
            context: context,
            builder: (BuildContext context) => Theme(
              data: ThemeData.dark(),
              child: CupertinoAlertDialog(
                content: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleColorPicker(
                        textStyle: TextStyle(fontSize: 0),
                        initialColor: widget.color,
                        onChanged: (color) => widget.callback(color, opacity),
                        size: Size(_size, _size),
                        strokeWidth: 4,
                        thumbSize: 30,
                      ),
                      StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return CupertinoSlider(
                            thumbColor: Color(0xff888888),
                            activeColor: context.watch<GoTheme>().linkColor,
                            value: opacity,
                            onChanged: (newOpacity) {
                              setState(() {
                                opacity = newOpacity;
                              });
                              widget.callback(widget.color, newOpacity);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(context.watch<GoTheme>().margin),
          padding: EdgeInsets.all(context.watch<GoTheme>().padding),
          height: 60,
          decoration: BoxDecoration(
            color: context.watch<GoTheme>().secondaryColor,
            borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
            boxShadow: context.watch<GoTheme>().boxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width / 30),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(1),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Default.getDefaultThirdlyColor(), width: 4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
