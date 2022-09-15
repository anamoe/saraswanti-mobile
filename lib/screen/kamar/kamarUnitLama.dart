import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';
import 'package:saraswantiland/screen/kamar/cardRoom.dart';
import 'package:saraswantiland/screen/formulirPemesanan.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class KamarUnit extends StatefulWidget {
  KamarUnit({this.id, this.lantai, this.view});
  String id;
  String lantai;
  String view;
  @override
  State<KamarUnit> createState() => _KamarUnit();
}

class _KamarUnit extends State<KamarUnit> {
  List datadariJSON;
  String noWa;
  String url = DriverModel.url + "/unit-ruangan/";
  Future ambildata() async {
    http.Response hasil = await http
        .get(url + widget.id, headers: {"Accept": "application/json"});

    datadariJSON = json.decode(hasil.body)['Daftar Ruangan'];
    noWa = json.decode(hasil.body)['kontak']['no_telp'];
    return datadariJSON;
  }

  @override
  void initState() {
    this.ambildata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Container(
              child: TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'View'),
                  Tab(text: 'Room'),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height /
                    1.4, //height of TabBarView
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5))),
                child: TabBarView(children: <Widget>[
                  Container(
                    child: Center(
                        child: Container(
                      margin: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      child: PinchZoomImage(
                  image: CachedNetworkImage(
                        imageUrl: widget.view,
                        fit: BoxFit.fill,
                        height: double.infinity,
                        width: double.infinity,
                        placeholder: (context, url) => SceletonCard(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                  zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                  hideStatusBarWhileZooming: true,
                ),
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: FutureBuilder(
                        future: ambildata(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                for (var item in datadariJSON) ...[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FormPemesanan(
                                                      lantai: widget.lantai,
                                                      room:
                                                          item["nomor_ruangan"],
                                                      foto:
                                                          item["foto_ruangan"],
                                                      deskripsi:
                                                          item["deskripsi"],
                                                      type: item["type"],
                                                      luas: item["luas"],
                                                      youtube: item["link_youtube"],
                                                      wa: noWa)));
                                    },
                                    child: CardRoom(
                                        no: item["nomor_ruangan"],
                                        status: item["status"]),
                                  ),
                                ]
                              ],
                            );
                          } else {
                            return SceletonCard(
                              width: MediaQuery.of(context).size.width,
                            );
                          }
                        }),
                  ),
                ]))
          ]),
        ));
  }
}
