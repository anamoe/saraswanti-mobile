import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:saraswantiland/widget/card.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/screen/daftarlantai.dart';
import 'package:saraswantiland/screen/listProfil.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:saraswantiland/screen/listInformasiBisnis.dart';
import 'package:saraswantiland/screen/alatpemasaran.dart';
import 'package:saraswantiland/screen/3dvt.dart';
import 'package:saraswantiland/widget/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


class CardMain extends StatefulWidget {
  @override
  _CardMain createState() => _CardMain();
}

class Person {
  final String imgAp;
  final String imgVt;
  final String imgDu;
  final String imgIb;
  final String imgPp;
  final String v3d;

  Person(
      {this.imgAp, this.imgVt, this.imgDu, this.imgIb, this.imgPp, this.v3d});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      imgAp: json['ap']['foto'],
      imgVt: json['vt']['foto'],
      imgDu: json['du']['foto'],
      imgIb: json['ib']['foto'],
      imgPp: json['pp']['foto'],
      v3d: json['url-vt'],
    );
  }
}

class _CardMain extends State<CardMain> {
  static const String url = DriverModel.url + "/getberanda";
  Future<Person> fetchPerson;

  Future<Person> getData() async {
    String myUrl = url;
    var response = await http.get(myUrl);
    Map<String, dynamic> responseJson = json.decode(response.body);
    return Person.fromJson(responseJson);
  }

  @override
  void initState() {
    fetchPerson = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPerson,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                     bukaweb(snapshot.data.v3d);
                    },
                    child: CardItem(
                      name: "3D VIRTUAL TOUR",
                      img: snapshot.data.imgVt,
                      width: MediaQuery.of(context).size.width,
                      color: MainColors.white,
                      fontsize: 18,
                      fontcolor: MainColors.asphalt,
                      imgheight: 200,
                    )),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListProfil()));
                          },
                          child: CardItem(
                            name: "PROFIL PERUSAHAAN",
                            img: snapshot.data.imgPp,
                            width: MediaQuery.of(context).size.width / 2,
                            color: MainColors.white,
                            fontsize: 11,
                            fontcolor: MainColors.asphalt,
                            imgheight: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AlatPemasaran()));
                          },
                          child: CardItem(
                            name: "ALAT PEMASARAN",
                            img: snapshot.data.imgAp,
                            width: MediaQuery.of(context).size.width / 2,
                            color: MainColors.white,
                            fontsize: 11,
                            fontcolor: MainColors.asphalt,
                            imgheight: 100,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DaftarLantai()));
                          },
                          child: CardItem(
                            name: "DAFTAR UNIT",
                            img: snapshot.data.imgDu,
                            width: MediaQuery.of(context).size.width / 2,
                            color: MainColors.white,
                            fontsize: 11,
                            fontcolor: MainColors.asphalt,
                            imgheight: 100,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListInformasiBisnis()));
                          },
                          child: CardItem(
                            name: "BERITA TERKINI",
                            img: snapshot.data.imgIb,
                            width: MediaQuery.of(context).size.width / 2,
                            color: MainColors.white,
                            fontsize: 11,
                            fontcolor: MainColors.asphalt,
                            imgheight: 100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FooterKu()
              ],
            );
          } else {
            return SceletonCard(
              width: MediaQuery.of(context).size.width,
            );
          }
        });
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
