import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/models/driverModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class KeuntunganInvestasi extends StatefulWidget {
  KeuntunganInvestasi({this.foto});
  String foto;
  @override
  State<KeuntunganInvestasi> createState() => _KeuntunganInvestasi();
}

class _KeuntunganInvestasi extends State<KeuntunganInvestasi> {
  List dataku;

  String url = DriverModel.url + "/getkeuntunganinvestasi";
  Future ambildata() async {
    http.Response hasil =
        await http.get(url, headers: {"Accept": "application/json"});

    dataku = json.decode(hasil.body)['Investasi'];

    return dataku;
  }

  @override
  void initState() {
    this.ambildata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.white,
      appBar: AppBar(
        title: Text("Keuntungan Investasi"),
        backgroundColor: MainColors.primary,
      ),
      body: FutureBuilder(
          future: ambildata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 240.0,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            child: Image.network(
                              widget.foto,
                              height: 240.0,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Column(
                            children: <Widget>[
                              for (var item in dataku) ...[
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
                                            item["judul"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MainColors.white),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (20 / 100),
                                                child: CachedNetworkImage(
                                                  imageUrl: item["foto"],
                                                  placeholder: (context, url) =>
                                                      SceletonCard(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                ),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      (60 / 100),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        item["deskripsi"],
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: MainColors
                                                                .white)),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
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
    );
  }
}
