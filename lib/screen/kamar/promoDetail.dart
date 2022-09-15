import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:photo_view/photo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:saraswantiland/widget/headertop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:saraswantiland/screen/kamar/boxpromo.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/screen/kamar/cardiklan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PromoDetail extends StatefulWidget {
  var data;
  PromoDetail({this.data});
  @override
  _PromoDetail createState() => _PromoDetail();
}

class _PromoDetail extends State<PromoDetail> {
  FlutterToast flutterToast;

  @override
  void initState() {
    flutterToast = FlutterToast(context);
    super.initState();
  }
  _showToast() {
    // this will be our toast UI
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red[600],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.browser_not_supported,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text("Link Tidak Ditemukan", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  flutterToast.showToast(
  child: toast,
  gravity: ToastGravity.BOTTOM,
  toastDuration: Duration(milliseconds: 500),
  );
}

  @override
  Widget build(BuildContext context) {
    print(widget.data['id']);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: 120,
            child: Image.asset(
              "assets/images/logo2.png",
            ),
          ),
          GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) => ImageDialog(imView:widget.data['foto_promo'])
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: PinchZoomImage(
                image: CachedNetworkImage(
                  imageUrl: widget.data['foto_promo'],
                  placeholder: (context, url) => SceletonCard(),
                  errorWidget: (context, url, error) =>
                  new Icon(Icons.error),
                ),
                zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                hideStatusBarWhileZooming: true,
              ),
            ),

          ),

          Container(
              color: MainColors.whitesecond,
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['judul_promo'],
                            textAlign: TextAlign.left,
                            style: GoogleFonts.belleza(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 18,
                              color: Colors.black,),
                          ),

                          Text(
                            "Kode Promo : "+widget.data['kode_promo'],
                            textAlign: TextAlign.left,
                            style: GoogleFonts.belleza(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 17,
                              color: Colors.black,),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                          ),

                          Text(
                            "Deskripsi Promo",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.belleza(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 17,
                              color: Colors.black,),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                          ),

                          Text(
                            widget.data['deskripsi_promo'],
                            style: TextStyle(color: Colors.black38),
                          ),

                        ]),
                  ),

                ],
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*80/100,
              height: 60,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: RaisedButton.icon(
                onPressed: openPromo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'LINK PROMO',
                  style: TextStyle(color: Colors.white),
                ),
                icon: FaIcon(FontAwesomeIcons.firefoxBrowser),
                textColor: Colors.white,
                splashColor: MainColors.kLightGreen,
                color: MainColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openPromo() async {
    String yt = widget.data['link_promo'];
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return yt; // new line
      } else {
        // add the [https]
        return yt;
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      _showToast();
    }
  }






}



class ImageDialog extends StatelessWidget {
  ImageDialog({this.imView});
  String imView;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: new AppBar(backgroundColor: Color(0xFF0077FF),
          elevation: 0,),
        backgroundColor: Colors.white.withOpacity(0.85),
        body:
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new RotatedBox(
            quarterTurns: 1,
            child: PhotoView(
              imageProvider: NetworkImage(imView),
            ),
          ),
        ));
  }
}

