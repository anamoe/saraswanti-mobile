import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/models/driverModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProdukPerusahaan extends StatefulWidget {
  ProdukPerusahaan({this.foto});
  String foto;
  @override
  State<ProdukPerusahaan> createState() => _ProdukPerusahaan();
}

class _ProdukPerusahaan extends State<ProdukPerusahaan> {
  List datadariJSON;
  String url = DriverModel.url + "/produk-perusahaan";
  Future ambildata() async {
    http.Response hasil =
        await http.get(url, headers: {"Accept": "application/json"});

    datadariJSON = json.decode(hasil.body)['produk'];
    return datadariJSON;
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
        title: Text("Produk Perusahaan"),
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
                              for (var item in datadariJSON) ...[
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
                                            item["nama_produk_perusahaan"],
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
                                                        item["fasilitas"],
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
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 5),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(item["deskripsi"],
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
