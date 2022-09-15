import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/headertop.dart';
import 'package:saraswantiland/widget/cardmain.dart';

class HomePage extends StatelessWidget {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: MainColors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
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
              height: 200,
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
                                    'assets/icon/LOGO SID TBK004.png',
                                    width: 250,
                                  ),
                                ],
                              ),
                              // Container(
                              //   child: Text(
                              //     'SARASWANTI',
                              //     textAlign: TextAlign.start,
                              //     style: TextStyle(
                              //       fontSize: 22.0,
                              //       color: MainColors.white,
                              //       fontWeight: FontWeight.w800,
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   child: Text(
                              //     'PT SARASWANTI INDOLAND DEVELOPMENT',
                              //     textAlign: TextAlign.start,
                              //     style: TextStyle(
                              //       fontSize: 12.0,
                              //       color: MainColors.white,
                              //       fontWeight: FontWeight.w400,
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CardMain(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
