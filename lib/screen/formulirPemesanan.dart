import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/headertop.dart';

import 'package:saraswantiland/screen/kamar/kamar.dart';

class FormPemesanan extends StatefulWidget {
  FormPemesanan(
      {this.lantai,
      this.room,
      this.foto,
      this.deskripsi,
      this.luas,
      this.type,
        this.youtube,
        this.ft,
      this.wa});
  String lantai;
  String room;
  String foto;
  String deskripsi;
  String luas;
  String type;
  String wa;
  String youtube;
  List<String> ft;
  @override
  State<FormPemesanan> createState() => _FormPemesanan();
}

class _FormPemesanan extends State<FormPemesanan> {
  @override
  void initState() {
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
              height: 90,
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
                                  'DETAIL UNIT',
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
                child: Kamar(
                    lantai: widget.lantai,
                    room: widget.room,
                    foto: widget.foto,
                    luas: widget.luas,
                    type: widget.type,
                    deskripsi: widget.deskripsi,
                    youtube:widget.youtube,
                    ft : widget.ft,
                    wa: widget.wa),
              ),
            )
          ],
        ),
      ),
    );
  }
}
