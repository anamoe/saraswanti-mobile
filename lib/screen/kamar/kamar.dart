import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:saraswantiland/screen/galery/SarasGalery.dart';

class Kamar extends StatefulWidget {
  @override
  Kamar(
      {this.lantai,
      this.room,
      this.foto,
      this.deskripsi,
      this.luas,
      this.type,
        this.youtube,
        this.ft,
      this.wa});
  String lantai;
  String room;
  String foto;
  String deskripsi;
  String luas;
  String type;
  String youtube;
  String wa;
  List<String> ft;
  State<Kamar> createState() => _Kamar();
}

class _Kamar extends State<Kamar> {
  String text = '';
  FlutterToast flutterToast;
  int _currentIndex=0;
  String _currentImage="";

  @override
  void initState() {
    _currentImage = widget.ft[_currentIndex];
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
            Icons.videocam,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text("Video Tidak Ditemukan", style: TextStyle(color: Colors.white)),
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
          Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 5,right: 5),
                  child: GestureDetector(
                     onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SarasGallery(imagePaths: widget.ft, currentIndex: _currentIndex)));
                          },
                          child:PinchZoomImage(
                      image:CachedNetworkImage(
                  imageUrl:  _currentImage,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: (context, url) => SceletonCard(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                  hideStatusBarWhileZooming: true,
                ),),
                  ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for(int i=0;i<widget.ft.length;i++)...[
                  GestureDetector(
                                        onTap: () {
                                         _changeImage(i);
                                        },
                                        child:
                  Container(
                    height: 45,
                    width: 70,
                    padding: EdgeInsets.only(left: 3,right: 3),
                  child: CachedNetworkImage(
                  imageUrl: widget.ft[i],
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: (context, url) => SceletonCard(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                  ))
                ]
              ],
            )
            )
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
                            "Unit No : " + widget.room,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.belleza(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 18,
              color: Colors.black,),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          
                          Text(
                            "Type : " + widget.type,
                            style: TextStyle(color: Colors.black38),
                          ),
                          Text(
                            "Luas : " + widget.luas,
                            style: TextStyle(color: Colors.black38),
                          ),
                           Container(
                            margin: EdgeInsets.only(bottom: 7),
                          ),
                          
                           Text(
                            "Detail Unit Fasilitas",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.belleza(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 18,
              color: Colors.black,),
                          ),
                           Container(
                            margin: EdgeInsets.only(bottom: 5),
                          ),

                          Text(
                            widget.deskripsi,
                            style: TextStyle(color: Colors.black38),
                          ),

                          if(widget.youtube != null)...[
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                child: RaisedButton.icon(
                                  onPressed:() {
                                    youtubeLink();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  label: Text(
                                    'Youtube',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: Icon(
                                    Icons.videocam,
                                    color: Colors.white,
                                  ),
                                  textColor: Colors.white,
                                  splashColor: MainColors.kLightGreen,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],


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
                onPressed: openAlertBox,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'BOOKING NOW',
                  style: TextStyle(color: Colors.white),
                ),
                icon: FaIcon(FontAwesomeIcons.whatsapp),
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

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Form Booking",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Masukan Nama Anda",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                      onChanged: (String value) {
                        sendTextFieldValue(value);
                      },
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      decoration: BoxDecoration(
                        color: MainColors.primary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          bookingNow();
                        },
                        color: Colors.transparent,
                        child: Text(
                          'Booking Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  sendTextFieldValue(value) {
    setState(() {
      text = value;
    });
  }

  void _changeImage(int i) {
    setState(() {
    _currentImage = widget.ft[i];
    _currentIndex = i;
    });
  }

  void bookingNow() async {
    String phone = widget.wa;
    String pesan = "Hi saya " +
        text +
        " tertarik untuk memesan properti dengan nomor Room " +
        widget.room +
        " Lantai " +
        widget.lantai +
        " Bisakah Saya diskusi Lebih Lanjut untuk pemesanan ?";
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=" + pesan; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=" +
            pesan; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }


  void youtubeLink() async {
    String yt = widget.youtube;
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
