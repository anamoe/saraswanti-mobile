import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:saraswantiland/screen/kamar/cardkamar.dart';
import 'package:saraswantiland/screen/kamar/boxpromo.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/screen/kamar/cardiklan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saraswantiland/screen/unitLantai.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saraswantiland/widget/footer.dart';


class CardKamarLantai extends StatefulWidget {
  @override
  _CardKamarLantai createState() => _CardKamarLantai();
}

class _CardKamarLantai extends State<CardKamarLantai> {
  List datadariJSON;
  FlutterToast flutterToast;
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
            Icons.error,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text("Ruangan Kosong", style: TextStyle(color: Colors.white)),
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
      child: FutureBuilder(
          future: ambildata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                 Container(
                   padding: EdgeInsets.symmetric(vertical: 13),
                  width: 180,
                  child: Image.asset(
                    "assets/images/arjunatower.png",
                  ),
                 ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 5),
                  //   child: Text(
                  //     "UNIT TERSEDIA",
                  //     style: TextStyle(fontSize: 14, color: MainColors.primary),
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 0),
                  //   child: Text(
                  //     datadariJSON == null
                  //         ? '0'
                  //         : datadariJSON.length.toString(),
                  //     style: TextStyle(
                  //         fontSize: 34,
                  //         fontWeight: FontWeight.bold,
                  //         color: MainColors.primary),
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 5),
                  //   child: Text(
                  //     "DAFTAR LANTAI",
                  //     style: TextStyle(fontSize: 14, color: MainColors.primary),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      "Silahkan Gunakan Lantai yang diinginkan",
                      style: TextStyle(fontSize: 10, color: MainColors.primary),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: [
                      for (var item in datadariJSON) ...[
                        if (item["status_progress_open"] ==
                            "ruangan-kosong") ...[
                          GestureDetector(
                              onTap: () {
                                _showToast();
                              },
                              child: CardKamar(
                                  no: item["nomor_lantai"], progress: 0.00)),
                        ] else ...[
                          if (item["status"] == "sold") ...[
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DaftarUnitLantai(
                                                  id: item["id"].toString(),
                                                  view: item["foto_lantai"],
                                                  lantai:
                                                      item["nomor_lantai"])));
                                },
                                child: CardKamar(
                                    no: item["nomor_lantai"],
                                    progress: double.parse(
                                        item["status_progress_open"]))),
                          ] else ...[
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DaftarUnitLantai(
                                                  id: item["id"].toString(),
                                                  view: item["foto_lantai"],
                                                  lantai:
                                                      item["nomor_lantai"])));
                                },
                                child: CardKamar(
                                    no: item["nomor_lantai"],
                                    progress: double.parse(
                                        item["status_progress_open"]))),
                          ]
                        ],
                      ],
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.green,
                              child: Container(
                                width: 40,
                                height: 20,
                              ),
                            ),
                            Text("Open")
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.red,
                              child: Container(
                                width: 40,
                                height: 20,
                              ),
                            ),
                            Text("Sold")
                          ],
                        ),
                      ],
                    ),
                  ),
                        Container(margin: EdgeInsets.only(bottom: 25),),
                 
                      FooterKu()
                ],
              );
            } else {
              return SceletonCard(
                width: MediaQuery.of(context).size.width,
              );
            }
          }),
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
