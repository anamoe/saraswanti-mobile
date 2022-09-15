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
import 'package:saraswantiland/screen/keuntunganInvestasi.dart';
import 'package:saraswantiland/screen/FiturPromo.dart';
import 'package:saraswantiland/widget/footer.dart';
import 'package:saraswantiland/screen/galery/SarasGalery.dart';
import 'package:saraswantiland/screen/tipeUnit.dart';

class Pemasar {
  final String imgPromo;
  final String imgTu;
  final String imgFt;
  final String imgKi;
  final String imgPp;
  final List mtg;
  final List tipeunit;

  Pemasar({
    this.imgPromo,
    this.imgTu,
    this.imgFt,
    this.imgKi,
    this.imgPp,
    this.mtg,
    this.tipeunit,
  });

  factory Pemasar.fromJson(Map<String, dynamic> json) {
    return Pemasar(
      imgPromo: json['promo']['foto'],
      imgTu: json['tu']['foto'],
      imgFt: json['ft']['foto'],
      imgKi: json['ki']['foto'],
      imgPp: json['pp']['foto'],
      mtg: json['mtg'],
      tipeunit: json['unit'],
    );
  }
}

class AlatPemasaran extends StatefulWidget {
  @override
  _AlatPemasaran createState() => _AlatPemasaran();
}

class _AlatPemasaran extends State<AlatPemasaran> {
  static const String url = DriverModel.url + "/getberanda";
  Future<Pemasar> fetchPerson;
  List<String> imgList;

  Future<Pemasar> getData() async {
    String myUrl = url;
    http.Response hasilGalery = await http.get(myUrl,
        headers: {"Accept": "application/json"});
    var imgListJson = json.decode(hasilGalery.body)['mtg'];
    imgList = List<String>.from(imgListJson);

    var response = await http.get(myUrl);
    Map<String, dynamic> responseJson = json.decode(response.body);
    return Pemasar.fromJson(responseJson);
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
                                  'ALAT PEMASARAN',
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
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FiturPromo()));
                                        },
                                        child: CardItem(
                                          name: "PROMO",
                                          img: snapshot.data.imgPromo,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          color: MainColors.white,
                                          fontsize: 14,
                                          fontcolor: MainColors.asphalt,
                                          imgheight: 100,
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TipeUnit(listUnit: List<String>.from(snapshot.data.tipeunit))));
                                        },
                                        child: CardItem(
                                          name: "TIPE UNIT",
                                          img: snapshot.data.imgTu,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          color: MainColors.white,
                                          fontsize: 14,
                                          fontcolor: MainColors.asphalt,
                                          imgheight: 100,
                                        )),
                                  ],
                                ),
                              ),
                             
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KeuntunganInvestasi(
                                                foto: snapshot.data.imgKi,
                                              )));
                                },
                                child: CardItem(
                                  name: "KEUNTUNGAN DAN INVESTASI",
                                  img: snapshot.data.imgKi,
                                  width: MediaQuery.of(context).size.width,
                                  color: MainColors.white,
                                  fontsize: 18,
                                  fontcolor: MainColors.asphalt,
                                  imgheight: 160,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    color: MainColors.primary,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "GALLERY",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MainColors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        for (var i=0;i<imgList.length;i++) ...[
                                              GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SarasGallery(imagePaths: imgList, currentIndex: i)));
                          },
                          child: CardItem(
                                            img: imgList[i],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.1,
                                            color: MainColors.white,
                                            fontsize: 18,
                                            fontcolor: MainColors.asphalt,
                                            imgheight: 160,
                                          ),
                                              )
                                         
                                        ]
                                      ],
                                    ),
                                  )),
                                  FooterKu()
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
