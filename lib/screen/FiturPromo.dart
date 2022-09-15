import 'package:flutter/material.dart';
import 'package:saraswantiland/screen/FiturPromoDetail.dart';
import 'package:saraswantiland/widget/maicolors.dart';
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

class FiturPromo extends StatefulWidget {
  @override
  _FiturPromo createState() => _FiturPromo();
}

class _FiturPromo extends State<FiturPromo> {
 List datadariJSON;
  List dataPromo;
  String kontak;
  String url = DriverModel.url + "/unit-lantai";
  Future ambildata() async {
    http.Response hasil =
        await http.get(url, headers: {"Accept": "application/json"});
    http.Response hasilPromo = await http.get(DriverModel.url + "/promo",
        headers: {"Accept": "application/json"});

    datadariJSON = json.decode(hasil.body)['Daftar Lantai'];
    kontak = json.decode(hasil.body)['kontak']['no_telp'];
    dataPromo = json.decode(hasilPromo.body)['promo'];
    return datadariJSON;
  }

  @override
  void initState() {
    this.ambildata();
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
        title: const Text('Promo'),
        backgroundColor: MainColors.primary,
      ),
      backgroundColor: MainColors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            
            Expanded(
              child: SingleChildScrollView(
                child: Container(
      child: FutureBuilder(
          future: ambildata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: 120,
                child: Image.asset(
                  "assets/images/logo2.png",
                ),
              ),
                   Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      "FEATURED PROMO",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CarouselSlider(
                      options: CarouselOptions(height: 150.0),
                      items: dataPromo.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CardIklan(img: i["foto_promo"]);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                 
                 
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      "PROMO LAINNYA",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        children: <Widget>[
                          for (var p in dataPromo) ...[
                            GestureDetector(
                                onTap: () {
                                  // bookingNow(
                                  //     judul: p["judul_promo"],
                                  //     kode: p["kode_promo"],
                                  //     wa: kontak);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FiturPromoDetail(data: p)
                                             ));
                                },
                                child: BoxPromoKamar(
                                  kode: p["kode_promo"],
                                  judul: p["judul_promo"],
                                ))
                          ]
                        ],
                      )),
                ],
              );
            } else {
              return SceletonCard(
                width: MediaQuery.of(context).size.width,
              );
            }
          }),
    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void bookingNow({String wa, String judul, String kode}) async {
    String phone = wa;
    String pesan =
        "Hi Admin, Apakah promo $judul dengan kode $kode masih tersedia dan berlaku?";
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
}
