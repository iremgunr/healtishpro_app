import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;

  RecipeView({@required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String finalUrl;

  @override
  void initState() {
    super.initState();
    finalUrl = widget.postUrl;
    if (widget.postUrl.contains('http://')) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
      print(finalUrl + "this is final url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  top: Platform.isIOS ? 60 : 60,
                  right: 24,
                  left: 24,
                  bottom: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Color(0xFF200087),
                    Color(0xff071930),
                  ],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft)),
              child: Row(
                mainAxisAlignment:
                    kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "HealthishPro",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Recipes",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFE0AD61),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                (Platform.isIOS ? 104 : 30),
            width: MediaQuery.of(context).size.width,
            child: WebView(
              onPageFinished: (val) {
                print(val);
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: finalUrl,
              onWebViewCreated: (WebViewController webViewController) {
                setState(() {
                  _controller.complete(webViewController);
                });
              },
            ),
          ),
        ],
      ),
    ));
  }
}
