import 'dart:convert';
import 'dart:io';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go/components/AppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';
import 'package:go/utils/variables/webconstructor.dart' as wcvar;

class WebConstructor extends StatefulWidget {
  @override
  _WebConstructorState createState() => _WebConstructorState();
}

class _WebConstructorState extends State<WebConstructor> {
  int calledDotId;
  int sectionId;
  String dotType;

  WebViewController _controller;

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/webconstructor/webconstructor.html');
    _controller.loadUrl(
      Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<GoTheme>().secondaryColor,
      appBar: DefaultAppBar(
        title: 'Конктруктор',
        backgroundColor: context.watch<GoTheme>().backgroundColor,
      ),
      body: WebView(
        debuggingEnabled: true,
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController c) {
          _controller = c;
          _loadHtmlFromAssets();
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
            name: 'Controller',
            onMessageReceived: (JavascriptMessage msg) {
              switch (msg.message) {
                case 'openBottomSheet':
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 4,
                                margin: EdgeInsets.only(
                                  top: 10,
                                  left: (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.15) /
                                      2,
                                ),
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: context.watch<GoTheme>().thirdlyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              AddChildRow(controller: _controller),
                              wcvar.dotsWithImage.contains(wcvar.dotType)
                                  ? PickImageForDot(controller: _controller)
                                  : Container(),
                              wcvar.dotsWithText.contains(wcvar.dotType)
                                  ? TextAreaForDot(controller: _controller)
                                  : Container(),
                              wcvar.dotsWithAnswers.contains(wcvar.dotType)
                                  ? EditAnswersForDot(controller: _controller)
                                  : Container(),
                              DeleteDot(controller: _controller),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  break;
              }
            },
          ),
          JavascriptChannel(
            name: 'SectionId',
            onMessageReceived: (JavascriptMessage msg) {
              this.sectionId = int.parse(msg.message);
              wcvar.sectionId = int.parse(msg.message);
              print('SectionId ${this.sectionId}');
            },
          ),
          JavascriptChannel(
            name: 'CalledDotId',
            onMessageReceived: (JavascriptMessage msg) {
              this.calledDotId = int.parse(msg.message);
              wcvar.calledDotId = int.parse(msg.message);
              print('calledDotId ${this.calledDotId}');
            },
          ),
          JavascriptChannel(
            name: 'DotType',
            onMessageReceived: (JavascriptMessage msg) {
              this.dotType = msg.message;
              wcvar.dotType = msg.message;
              print('dotType ${this.dotType}');
            },
          ),
          JavascriptChannel(
            name: 'ImageUrl',
            onMessageReceived: (JavascriptMessage msg) {
              print('################################################################ ${msg.message.runtimeType}');
              wcvar.imageUrl = msg.message == 'empty'
                  ? 'http://i.piccy.info/i9/dfa32a51a676ffadaa332c146b23a13d/1608398573/36540/1410293/click_min.jpg'
                  : msg.message;
              // print('ImageUrl now is: ${wcvar.imageUrl}');
            },
          ),
          JavascriptChannel(
            name: 'AmountOfChildrens',
            onMessageReceived: (JavascriptMessage msg) {
              wcvar.amountOfChildren = int.parse(msg.message);
              print('AmountOfChildrens ${msg.message}');
            },
          ),
          JavascriptChannel(
            name: 'GetAnswers',
            onMessageReceived: (JavascriptMessage msg) {
              wcvar.answers = List.from(jsonDecode(msg.message));
              // print('тот принт что мне нужен ${msg.message}');
              // print(List.from(jsonDecode(msg.message)));
            },
          ),
          JavascriptChannel(
            name: 'DotText',
            onMessageReceived: (JavascriptMessage msg) {
              wcvar.text = msg.message;
              print('text ${this.sectionId}');
            },
          ),
          JavascriptChannel(
            name: 'Print',
            onMessageReceived: (JavascriptMessage msg) {
              print('Message ${msg.message}');
            },
          ),
        ].toSet(),
      ),
    );
  }
}

class AddChildRow extends StatelessWidget {
  WebViewController controller;

  AddChildRow({this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: context.watch<GoTheme>().margin, top: context.watch<GoTheme>().margin * 2),
          child: Text(
            'Добавить следующий шаг:',
            style: TextStyle(
              color: context.watch<GoTheme>().textColor.withOpacity(0.8),
              fontSize: MediaQuery.of(context).size.width / 25,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.only(
              // top: context.watch<GoTheme>().margin * 2,
              bottom: context.watch<GoTheme>().margin,
              // left: context.watch<GoTheme>().margin,
              // right: context.watch<GoTheme>().margin,
            ),
            child: Row(
              children: [
                ChildDotType(
                  image:
                      'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  label: "Single Choose Dot",
                  startColor: Colors.black.withOpacity(0.6),
                  endColor: Colors.black.withOpacity(0),
                  jsfunc: () {
                    controller
                        ?.evaluateJavascript('addDot(${wcvar.sectionId + 1}, ${wcvar.calledDotId}, SingleChooseDot)');
                  },
                ),
                ChildDotType(
                  image:
                      'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  label: "Multi Choose Dot",
                  startColor: Colors.black.withOpacity(0.6),
                  endColor: Colors.black.withOpacity(0),
                  jsfunc: () {
                    controller
                        ?.evaluateJavascript('addDot(${wcvar.sectionId + 1}, ${wcvar.calledDotId}, MultiChooseDot)');
                  },
                ),
                ChildDotType(
                  image:
                      'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  label: "Text Dot",
                  startColor: Colors.black.withOpacity(0.6),
                  endColor: Colors.black.withOpacity(0),
                  jsfunc: () {
                    controller?.evaluateJavascript('addDot(${wcvar.sectionId + 1}, ${wcvar.calledDotId}, TextDot)');
                  },
                ),
                ChildDotType(
                  image:
                      'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  label: "Skip Dot",
                  startColor: Colors.black.withOpacity(0.6),
                  endColor: Colors.black.withOpacity(0),
                  jsfunc: () {
                    controller?.evaluateJavascript('addDot(${wcvar.sectionId + 1}, ${wcvar.calledDotId}, SkipDot)');
                  },
                ),
                ChildDotType(
                  image:
                      'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  label: "End Dot",
                  startColor: Colors.black.withOpacity(0.6),
                  endColor: Colors.black.withOpacity(0),
                  jsfunc: () {
                    controller?.evaluateJavascript('addDot(${wcvar.sectionId + 1}, ${wcvar.calledDotId}, EndDot)');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChildDotType extends StatelessWidget {
  String image;
  String label;
  Color startColor;
  Color endColor;
  Function jsfunc;

  ChildDotType({this.image, this.label, this.startColor, this.endColor, this.jsfunc});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3;
    double cardHeight = cardWidth * 2 / 3;
    return GestureDetector(
      onTap: () {
        jsfunc();
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.all(context.watch<GoTheme>().margin),
        padding: EdgeInsets.all(context.watch<GoTheme>().padding / 2),
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          color: context.watch<GoTheme>().thirdlyColor,
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            alignment: Alignment.center,
          ),
          boxShadow: context.watch<GoTheme>().boxShadow,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteDot extends StatelessWidget {
  WebViewController controller;
  DeleteDot({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              // Navigator.pop(context);
              if (wcvar.sectionId > 0) {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      body: Theme(
                        data: context.watch<GoTheme>().isDarkTheme ? ThemeData.dark() : ThemeData.light(),
                        child: CupertinoAlertDialog(
                          title: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text('Удаление точки'),
                          ),
                          content: Text("Вы уверены, что хотите удалить этот элемент?"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Отмена'),
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('Удалить', style: TextStyle(color: Colors.redAccent)),
                              onPressed: () {
                                Navigator.pop(context);
                                controller?.evaluateJavascript('removeDot(${wcvar.sectionId}, ${wcvar.calledDotId})');
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      body: Theme(
                        data: context.watch<GoTheme>().isDarkTheme ? ThemeData.dark() : ThemeData.light(),
                        child: CupertinoAlertDialog(
                          content: Text("Удалять корневой элемент нельзя."),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Понятно'),
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class PickImageForDot extends StatefulWidget {
  WebViewController controller;
  PickImageForDot({this.controller});
  @override
  _PickImageForDotState createState() => _PickImageForDotState();
}

class _PickImageForDotState extends State<PickImageForDot> {
  final _storage = FirebaseStorage.instance;
  File _imageFile;
  dynamic image = Image.network(
    wcvar.imageUrl,
    repeat: ImageRepeat.noRepeat,
    fit: BoxFit.cover,
  ).image;
  String downloadUrl;
  dynamic snapshot;
  bool showProgressIndicator = false;
  final picker = ImagePicker();

  void reloadImage(dynamic img) {
    setState(() {
      image = img;
      showProgressIndicator = false;
    });
  }

  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        showProgressIndicator = true;
      });
      _imageFile = File(pickedFile.path);

      snapshot = await _storage
          .ref()
          .child(
              'images/${wcvar.calledDotId}-${wcvar.sectionId}-${wcvar.dotType}-${new DateTime.now().millisecondsSinceEpoch}')
          .putFile(_imageFile);
      downloadUrl = await snapshot.ref.getDownloadURL();
      widget.controller?.evaluateJavascript('_setNewDotImageUrl(${wcvar.calledDotId}, "$downloadUrl")');
    }
    setState(() {
      if (pickedFile != null) {
        reloadImage(Image.network(
          downloadUrl,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover,
          // width: cardWidth,
          // height: cardHeight,
        ).image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width - context.watch<GoTheme>().margin * 2;
    double cardHeight = cardWidth * 9 / 16;
    return GestureDetector(
      onTap: () {
        getImage(ImageSource.gallery);
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: EdgeInsets.all(context.watch<GoTheme>().margin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          color: context.watch<GoTheme>().thirdlyColor,
          boxShadow: context.watch<GoTheme>().boxShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          child: showProgressIndicator
              ? Theme(
                  data: ThemeData(accentColor: context.watch<GoTheme>().textColor.withOpacity(0.8)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: context.watch<GoTheme>().textColor.withOpacity(0.3),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Загрузка на сервер',
                          style: TextStyle(
                            color: context.watch<GoTheme>().textColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Image(
                  image: image,
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}

class TextAreaForDot extends StatefulWidget {
  WebViewController controller;
  TextAreaForDot({@required this.controller});

  @override
  _TextAreaForDotState createState() => _TextAreaForDotState();
}

class _TextAreaForDotState extends State<TextAreaForDot> {
  bool isSaved = true;
  TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: wcvar.text);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void setNoSaved() {
    setState(() {
      isSaved = false;
    });
  }

  void setSaved() {
    setState(() {
      isSaved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // _textController.text = wcvar.text;
    return Container(
      margin: EdgeInsets.all(context.watch<GoTheme>().margin),
      decoration: BoxDecoration(
        boxShadow: context.watch<GoTheme>().boxShadow,
        color: context.watch<GoTheme>().thirdlyColor,
        borderRadius: BorderRadius.circular(
          context.watch<GoTheme>().borderRadius,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return Scaffold(
                    body: Theme(
                      data: context.watch<GoTheme>().isDarkTheme ? ThemeData.dark() : ThemeData.light(),
                      child: CupertinoAlertDialog(
                        title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Text(
                                wcvar.dotsWithAnswers.contains(wcvar.dotType) ? 'Изменить вопрос' : 'Изменить текст',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 20,
                                  color: context.watch<GoTheme>().textColor,
                                ),
                              ),
                              DelayedDisplay(
                                child: Text(
                                  isSaved ? "Сохранено" : "Не сохранено",
                                  style: TextStyle(
                                    color: isSaved ? Colors.green.withOpacity(0.8) : Colors.redAccent.withOpacity(0.8),
                                    fontSize: MediaQuery.of(context).size.width / 30,
                                  ),
                                ),
                                delay: new Duration(microseconds: 500),
                                slidingCurve: Curves.easeIn,
                                slidingBeginOffset: const Offset(0, -0.2),
                              )
                            ],
                          ),
                        ),
                        content: TextField(
                          onChanged: (text) {
                            setState(() {
                              setNoSaved();
                            });
                          },
                          controller: _textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(color: context.watch<GoTheme>().textColor),
                          cursorColor: context.watch<GoTheme>().textColor.withOpacity(0.8),
                          decoration: InputDecoration(
                            hintText:
                                wcvar.dotsWithAnswers.contains(wcvar.dotType) ? 'Ваш вопрос здесь' : 'Ваш текст здесь',
                            hintStyle: TextStyle(
                              color: context.watch<GoTheme>().textColor.withOpacity(0.5),
                              fontStyle: FontStyle.italic,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Сохранить и выйти'),
                            isDefaultAction: true,
                            onPressed: () {
                              wcvar.text = _textController.text;
                              widget.controller?.evaluateJavascript(
                                  '_setNewTextForDot(${wcvar.calledDotId}, "${_textController.text}")');
                              setSaved();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(context.watch<GoTheme>().padding / 2),
          width: double.infinity,
          child: Text(
            wcvar.dotsWithAnswers.contains(wcvar.dotType) ? 'Изменить вопрос' : 'Изменить текст',
            style: TextStyle(
              color: context.watch<GoTheme>().textColor.withOpacity(0.8),
              fontSize: MediaQuery.of(context).size.width / 22,
            ),
          ),
        ),
      ),
    );
  }
}

class EditAnswersForDot extends StatefulWidget {
  WebViewController controller;

  EditAnswersForDot({@required this.controller});

  @override
  _EditAnswersForDotState createState() => _EditAnswersForDotState();
}

class _EditAnswersForDotState extends State<EditAnswersForDot> {
  bool isSaved = true;

  void setNoSaved() {
    setState(() {
      isSaved = false;
    });
  }

  void setSaved() {
    setState(() {
      isSaved = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.watch<GoTheme>().margin),
      decoration: BoxDecoration(
        boxShadow: context.watch<GoTheme>().boxShadow,
        color: context.watch<GoTheme>().thirdlyColor,
        borderRadius: BorderRadius.circular(
          context.watch<GoTheme>().borderRadius,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return Scaffold(
                    body: Theme(
                      data: context.watch<GoTheme>().isDarkTheme ? ThemeData.dark() : ThemeData.light(),
                      child: CupertinoAlertDialog(
                        title: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Text(
                                'Редактировать вопросы',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 20,
                                  color: context.watch<GoTheme>().textColor,
                                ),
                              ),
                              DelayedDisplay(
                                child: Text(
                                  isSaved ? "Сохранено" : "Не сохранено",
                                  style: TextStyle(
                                    color: isSaved ? Colors.green.withOpacity(0.8) : Colors.redAccent.withOpacity(0.8),
                                    fontSize: MediaQuery.of(context).size.width / 30,
                                  ),
                                ),
                                delay: new Duration(microseconds: 500),
                                slidingCurve: Curves.easeIn,
                                slidingBeginOffset: const Offset(0, -0.2),
                              )
                            ],
                          ),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: wcvar.amountOfChildren > 1
                              ? [
                                  _AnswersField(
                                    0,
                                    questionText: wcvar.answers[0],
                                    noSavedCallback: setNoSaved,
                                    savedCallback: setSaved,
                                    higherSetState: setState,
                                    controller: widget.controller,
                                  ),
                                  _AnswersField(
                                    1,
                                    questionText: wcvar.answers[1],
                                    noSavedCallback: setNoSaved,
                                    savedCallback: setSaved,
                                    higherSetState: setState,
                                    controller: widget.controller,
                                  ),
                                  wcvar.dotType == 'multi-choose-dot' && wcvar.amountOfChildren > 2
                                      ? _AnswersField(
                                          2,
                                          questionText: wcvar.answers[2],
                                          noSavedCallback: setNoSaved,
                                          savedCallback: setSaved,
                                          higherSetState: setState,
                                          controller: widget.controller,
                                        )
                                      : Container(),
                                  wcvar.dotType == 'multi-choose-dot' && wcvar.amountOfChildren > 3
                                      ? _AnswersField(
                                          3,
                                          questionText: wcvar.answers[3],
                                          noSavedCallback: setNoSaved,
                                          savedCallback: setSaved,
                                          higherSetState: setState,
                                          controller: widget.controller,
                                        )
                                      : Container(),
                                ]
                              : [
                                  Container(
                                    child: Text(
                                      'Вы не можете добавить вопрос, необходимо создать не менее двух листьев для дерева.',
                                      style: TextStyle(
                                        color: context.watch<GoTheme>().textColor,
                                      ),
                                    ),
                                  )
                                ],
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Сохранить и выйти'),
                            isDefaultAction: true,
                            onPressed: () {
                              setSaved();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(context.watch<GoTheme>().padding / 2),
          width: double.infinity,
          child: Text(
            'Добавить ответы',
            style: TextStyle(
              color: context.watch<GoTheme>().textColor.withOpacity(0.8),
              fontSize: MediaQuery.of(context).size.width / 22,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswersField extends StatefulWidget {
  String questionText;
  int index;
  Function noSavedCallback;
  Function savedCallback;
  Function higherSetState;
  WebViewController controller;

  _AnswersField(this.index,
      {this.questionText, this.noSavedCallback, this.savedCallback, this.higherSetState, this.controller});
  @override
  __AnswersFieldState createState() => __AnswersFieldState();
}

class __AnswersFieldState extends State<_AnswersField> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController(text: widget.questionText);
    _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));

    return Container(
      width: double.infinity,
      child: TextField(
        onTap: () async {
          // Future.delayed(const Duration(seconds: 1),
          //     () => );
          // _controller.value = _controller.value.copyWith(text: newText, selection: newSelection)
        },
        onChanged: (newString) {
          print(newString);
          // print(_questions);
          // _controller.text = newString;
          // _textController = newString;
          // setState(() {
          //   setNoSaved();
          // });
          // widget.higherSetState(() {
          //   widget.noSavedCallback();
          // });
          // _textController.text = newString;
          // _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
          widget.questionText = newString;
          wcvar.answers[widget.index] = newString;

          for (var i = 0; i < 4; i++) {
            widget.controller
                ?.evaluateJavascript('_changeDotQuestions(${wcvar.calledDotId}, "${wcvar.answers[i]}", $i)');
          }
          print(wcvar.answers);
          print(wcvar.answers.runtimeType);
        },
        controller: _textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(color: context.watch<GoTheme>().textColor),
        cursorColor: context.watch<GoTheme>().textColor.withOpacity(0.8),
        decoration: InputDecoration(
          hintText: 'Ваш ${widget.index + 1} ответ',
          hintStyle: TextStyle(
            color: context.watch<GoTheme>().textColor.withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
