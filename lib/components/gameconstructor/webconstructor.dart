import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go/components/AppBar.dart';
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddChildRow(controller: _controller),
                            FlatButton(
                              onPressed: () {
                                // print('Денис пидор ${this.sectionId + 1}');
                                // print(this.calledDotId);
                                _controller?.evaluateJavascript('removeDot(${this.sectionId}, ${this.calledDotId})');
                                Navigator.pop(context);
                                print('#####################################################################');
                                if (this.sectionId == 0) {
                                  // Уведомление: Нельзя удалить корневой элемент
                                }
                              },
                              child: Text('Удалить точку'),
                            ),
                          ],
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
            name: 'Print',
            onMessageReceived: (JavascriptMessage msg) {
              print('Message ${msg.message}');
            },
          )
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
