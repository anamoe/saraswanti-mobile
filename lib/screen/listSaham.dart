import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/headertop.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';




class ListSaham extends StatefulWidget {
  ListSaham({this.judul,this.url});
  String url;
  String judul;
  @override
  _ListSaham createState() => _ListSaham();
}

class _ListSaham extends State<ListSaham> {

final Completer<WebViewController> _controller =
      Completer<WebViewController>();
      bool isLoading=true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 100,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 110,
                                  ),
                                ],
                              ),
                              Container(
                                child: Text(
                                  widget.judul,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: MainColors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical,
                child:  WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
