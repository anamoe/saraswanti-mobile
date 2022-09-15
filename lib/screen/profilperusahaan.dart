import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:saraswantiland/widget/maicolors.dart';

class ProfilPerusahaan extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.white,
      appBar: AppBar(
        title: Text("Ikhtisar Perusahaan"),
        backgroundColor: MainColors.primary,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://app.saraswantiland.com/maps',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        );
      }),
    );
  }
}
