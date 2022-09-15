import 'package:flutter/material.dart';
import 'package:saraswantiland/screen/kamar/promoDetail.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/headertop.dart';

import 'package:saraswantiland/screen/kamar/kamarUnit.dart';

class FiturPromoDetail extends StatefulWidget {
  FiturPromoDetail({this.data});
  var data;

  @override
  State<FiturPromoDetail> createState() => _FiturPromoDetail();
}

class _FiturPromoDetail extends State<FiturPromoDetail> {
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
                                  'PROMO',
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
                  child: PromoDetail(data: widget.data),
              ),
            )
          ],
        ),
      ),
    );
  }
}
