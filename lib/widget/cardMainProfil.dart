import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:saraswantiland/screen/MediaSosial.dart';
import 'package:saraswantiland/widget/card.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/screen/profilperusahaan.dart';
import 'package:saraswantiland/screen/produkPerusahaan.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:saraswantiland/screen/viewWeb.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:saraswantiland/widget/footer.dart';
import 'package:saraswantiland/screen/filosofi.dart';



class CardMainProfil extends StatefulWidget {
  @override
  _CardMainProfil createState() => _CardMainProfil();
}

class DataKu {
  final String imgIp;
  final String imgWs;
  final String imgSm;
  final String imgFt;
  final String imgProduk;
  final String linkIg;
  final String linkWeb;
  final String linkFb;
  final String linkLk;

  DataKu(
      {this.imgIp,
      this.imgWs,
      this.imgSm,
      this.imgFt,
      this.imgProduk,
      this.linkIg,
      this.linkFb,
      this.linkLk,
      this.linkWeb});

  factory DataKu.fromJson(Map<String, dynamic> json) {
    return DataKu(
      imgIp: json['ip']['foto'],
      imgWs: json['ws']['foto'],
      imgSm: json['sm']['foto'],
      imgFt: json['ft']['foto'],
      imgProduk: json['produk']['foto'],
      linkIg: json['kontak']['Instagram'],
      linkWeb: json['kontak']['web'],
      linkFb: json['kontak']['fb'],
      linkLk: json['kontak']['linkedin'],
    );
  }
}

class _CardMainProfil extends State<CardMainProfil> {
  static const String url = DriverModel.url + "/getberanda";
  Future<DataKu> fetchDataKu;

  Future<DataKu> getData() async {
    String myUrl = url;
    var response = await http.get(myUrl);
    Map<String, dynamic> responseJson = json.decode(response.body);
    return DataKu.fromJson(responseJson);
  }

  @override
  void initState() {
    fetchDataKu = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDataKu,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilPerusahaan()));
                    },
                    child: CardItem(
                      name: "IKHTISAR PERUSAHAAN",
                      img: snapshot.data.imgIp,
                      width: MediaQuery.of(context).size.width,
                      color: MainColors.white,
                      fontsize: 18,
                      fontcolor: MainColors.asphalt,
                      imgheight: 180,
                    )),
                 GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FilosofiTagline()));
                                },
                                child: CardItem(
                                  name: "FILOSOFI DAN TAGLINE",
                                  img: snapshot.data.imgFt,
                                  width: MediaQuery.of(context).size.width,
                                  color: MainColors.white,
                                  fontsize: 18,
                                  fontcolor: MainColors.asphalt,
                                  imgheight: 160,
                                ),
                              ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProdukPerusahaan(
                                  foto: snapshot.data.imgProduk)));
                    },
                    child: CardItem(
                      name: "PRODUK PERUSAHAAN",
                      img: snapshot.data.imgProduk,
                      width: MediaQuery.of(context).size.width,
                      color: MainColors.white,
                      fontsize: 18,
                      fontcolor: MainColors.asphalt,
                      imgheight: 180,
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
                                    builder: (context) =>
                                        ViewWeb(url: snapshot.data.linkWeb)));
                          },
                          child: CardItem(
                            name: "WEBSITE",
                            img: snapshot.data.imgWs,
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
                                        MediaSosials(ig: snapshot.data.linkIg,fb: snapshot.data.linkFb,lk: snapshot.data.linkLk,web: snapshot.data.linkWeb)
                                        ));
                          },
                          child: CardItem(
                            name: "MEDIA SOSIAL",
                            img: snapshot.data.imgSm,
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

  void sosmed(String ig) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return ig; // new line
      } else {
        // add the [https]
        return ig; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
}
