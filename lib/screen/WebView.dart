import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FlutterWebViewData extends StatefulWidget {
  const FlutterWebViewData({Key? key}) : super(key: key);

  @override
  _FlutterWebViewDataState createState() => _FlutterWebViewDataState();
}

class _FlutterWebViewDataState extends State<FlutterWebViewData> {
  WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ElevatedButton(
              child: Text('send to javascript'),
              onPressed: () {
                if (_controller != null) {
                  _controller!.evaluateJavascript(
                      'window.fromFlutter("this is title from Flutter")');
                }
              },
            )),
        body: WebView( // 여기부터 주목
          initialUrl: "https://www.wanted.co.kr/",
          //initialUrl: "https://kauth.kakao.com/oauth/authorize?client_id=7f8c9995a36f55554348032c83b16b96&redirect_uri=http://15.164.142.62:8080/login/oauth2/code/kakao&response_type=code",
          onWebViewCreated: (WebViewController webviewController) {
            _controller = webviewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'JavaScriptChannel',
                onMessageReceived: (JavascriptMessage message) {
                  print("됨?");
                  print(message.message);
                })
          ]),
        ));
  }
}