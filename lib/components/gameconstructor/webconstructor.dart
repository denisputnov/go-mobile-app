import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go/components/AppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () {
                                print('Денис пидор ${this.sectionId + 1}');
                                print(this.calledDotId);
                                _controller?.evaluateJavascript('addDot(${this.sectionId + 1}, ${this.calledDotId})');
                                // Navigator.pop(context);
                              },
                              child: Text('Добавить точку'),
                            ),
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
              print('SectionId ${this.sectionId}');
            },
          ),
          JavascriptChannel(
            name: 'CalledDotId',
            onMessageReceived: (JavascriptMessage msg) {
              this.calledDotId = int.parse(msg.message);
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
