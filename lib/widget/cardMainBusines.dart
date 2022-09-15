import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:saraswantiland/widget/card.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:saraswantiland/models/mainManga.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saraswantiland/screen/viewWeb.dart';
import 'package:saraswantiland/screen/listSaham.dart';
import 'package:saraswantiland/widget/footer.dart';


class CardMainBisnis extends StatefulWidget {
  @override
  _CardMainBisnis createState() => _CardMainBisnis();
}

class DataKu {
  final String imgIp;
  final String imgWs;
  final String imgSm;
  final String imgProduk;
  final String imgDp;
  final String imgCr;
  final String imgFx;

  DataKu({this.imgIp, this.imgWs, this.imgSm, this.imgProduk,this.imgDp,this.imgCr,this.imgFx});

  factory DataKu.fromJson(Map<String, dynamic> json) {
    return DataKu(
      imgIp: json['bp']['foto'],
      imgSm: json['isaham']['foto'],
      imgDp: json['dp']['foto'],
      imgWs: json['ws']['foto'],
      imgCr: json['cr']['foto'],
      imgFx: json['fx']['foto'],
      imgProduk: json['produk']['foto'],
    );
  }
}

class _CardMainBisnis extends State<CardMainBisnis> {
  static const String url = DriverModel.url + "/getberanda";
  Future<DataKu> fetchDataKu;
  FlutterToast flutterToast;

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
    flutterToast = FlutterToast(context);
  }

  _showToast() {
    // this will be our toast UI
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: MainColors.primary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text("Masih Tahap Pengembangan",
              style: TextStyle(color: Colors.white)),
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
    return FutureBuilder(
        future: fetchDataKu,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MangaMain()));
                    },
                    child: CardItem(
                      name: "BISNIS DAN PROPERTI \n (BUSINESS AND PROPERTY)",
                      img: snapshot.data.imgIp,
                      width: MediaQuery.of(context).size.width,
                      color: MainColors.white,
                      fontsize: 18,
                      fontcolor: MainColors.asphalt,
                      imgheight: 190,
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
                            builder: (context) => ListSaham(judul: "PASAR SAHAM ",url: "https://app.saraswantiland.com/listsaham") ));
                  },
                  child: CardItem(
                    name: "PASAR SAHAM (STOCK MARKET)",
                    img: snapshot.data.imgSm,
                    width: MediaQuery.of(context).size.width/2,
                    color: MainColors.white,
                    fontsize: 11,
                    fontcolor: MainColors.asphalt,
                    imgheight: 130,
                  ),
                ),
                 GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ViewWeb(url: "https://pusatdata.kontan.co.id/bungadeposito",) ));
                  },
                  child: CardItem(
                    name: "DEPOSITO (DEPOSIT)",
                    img: snapshot.data.imgDp,
                    width: MediaQuery.of(context).size.width/2,
                    color: MainColors.white,
                    fontsize: 11,
                    fontcolor: MainColors.asphalt,
                    imgheight: 130,
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
                            builder: (context) => ListSaham(judul: "PASAR VALUTA ASING",url: "https://app.saraswantiland.com/forex") ));
                            },
                          child: CardItem(
                            name: "PASAR VALUTA ASING \n (FOREIGN EXCHANGE MARKET)",
                            img: snapshot.data.imgFx,
                            width: MediaQuery.of(context).size.width / 2,
                            color: MainColors.white,
                            fontsize: 11,
                            fontcolor: MainColors.asphalt,
                            imgheight: 130,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListSaham(judul: "MATA UANG CRYPTO (CRYPTOCURRENCY) ",url: "https://app.saraswantiland.com/crypto") ));
                                },
                            child: CardItem(
                              name: "MATA UANG CRYPTO (CRYPTOCURRENCY)",
                              img: snapshot.data.imgCr,
                              width: MediaQuery.of(context).size.width / 2,
                              color: MainColors.white,
                              fontsize: 11,
                              fontcolor: MainColors.asphalt,
                              imgheight: 130,
                            )),
                      ],
                    ),
                  ],
                ),
                FooterKu(),
              ],
            );
          } else {
            return SceletonCard(
              width: MediaQuery.of(context).size.width,
            );
          }
        });
  }
}
