import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/footer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class MediaSosials extends StatefulWidget {
 MediaSosials
 ({this.ig, this.lk, this.web,this.fb});
  String ig;
  String lk;
  String web;
  String fb;
  @override
  State<MediaSosials> createState() => _MediaSosialsState();
}

class _MediaSosialsState extends State<MediaSosials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sosial Media'),
        backgroundColor: MainColors.primary,
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: 120,
                child: Image.asset(
                  "assets/images/logo2.png",
                ),
              ),
              	Container(
                  width: MediaQuery.of(context).size.width * 80/100,
                  height: 80.0,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child:RaisedButton.icon(
                                onPressed: (){ bukaweb(widget.web); },
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                label: Text('Website', 
                                      style: TextStyle(color: Colors.white)),
                                icon: FaIcon(FontAwesomeIcons.globe),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.purple,),
                  ),

                  Container(
                  width: MediaQuery.of(context).size.width * 80/100,
                  height: 80.0,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child:RaisedButton.icon(
                                onPressed: (){ bukaweb(widget.ig); },
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                label: Text('Instagram', 
                                      style: TextStyle(color: Colors.white)),
                                icon: FaIcon(FontAwesomeIcons.instagram),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.purple,),
                  ),

                  Container(
                  width: MediaQuery.of(context).size.width * 80/100,
                  height: 80.0,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child:RaisedButton.icon(
                                onPressed: (){ bukaweb(widget.fb); },
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                label: Text('Facebook', 
                                      style: TextStyle(color: Colors.white)),
                                icon: FaIcon(FontAwesomeIcons.facebook),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.purple,),
                  ),

                  Container(
                  width: MediaQuery.of(context).size.width * 80/100,
                  height: 80.0,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child:RaisedButton.icon(
                                onPressed: (){ bukaweb(widget.lk); },
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                label: Text('Linkedin', 
                                      style: TextStyle(color: Colors.white)),
                                icon: FaIcon(FontAwesomeIcons.linkedin),
                                textColor: Colors.white,
                                splashColor: Colors.red,
                                color: Colors.purple,),
                  ),
                  FooterKu()
            ],
          ),        );
      }),
    );
  }

 void bukaweb(String urlweb) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return urlweb; // new line
      } else {
        // add the [https]
        return urlweb; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

}
