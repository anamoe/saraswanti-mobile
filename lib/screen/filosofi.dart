import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/headertop.dart';
import 'package:saraswantiland/widget/card.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:saraswantiland/screen/daftarlantai.dart';

class Filo {
  final String judul;
  final String deskripsi;
  final String tgjudul;
  final String tgdeskripsi;

  Filo({
    this.judul,
    this.deskripsi,
    this.tgjudul,
    this.tgdeskripsi,
  });

  factory Filo.fromJson(Map<String, dynamic> json) {
    return Filo(
      judul: json['filosofi']['judul'],
      deskripsi: json['filosofi']['deskripsi'],
      tgjudul: json['tagline']['judul'],
      tgdeskripsi: json['tagline']['deskripsi'],
    );
  }
}

class FilosofiTagline extends StatefulWidget {
  @override
  _FilosofiTagline createState() => _FilosofiTagline();
}

class _FilosofiTagline extends State<FilosofiTagline> {
  static const String url = DriverModel.url + "/filosofi";
  Future<Filo> fetchPerson;

  Future<Filo> getData() async {
    String myUrl = url;
    var response = await http.get(myUrl);
    Map<String, dynamic> responseJson = json.decode(response.body);
    return Filo.fromJson(responseJson);
  }

  @override
  void initState() {
    fetchPerson = getData();
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
              height: 110,
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
                                  'FILOSOFI DAN TAGLINE',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18.0,
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
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: fetchPerson,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Card(
                                  color: MainColors.primary,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5),
                                        child: Text(
                                          snapshot.data.judul,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: MainColors.white),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(snapshot.data.deskripsi,
                                                textAlign: TextAlign.justify,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: MainColors.white)),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Card(
                                  color: MainColors.primary,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5),
                                        child: Text(
                                          snapshot.data.tgjudul,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: MainColors.white),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                snapshot.data.tgdeskripsi,
                                                textAlign: TextAlign.justify,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: MainColors.white)),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return SceletonCard(
                          width: MediaQuery.of(context).size.width,
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
