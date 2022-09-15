import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/cardMainProfil.dart';

class ListProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColors.primary,
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            child: Column(
              children: [
                Container(
                    width: width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 50.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo.png',
                          width: 150,
                        ),
                        Text(
                          'PROFIL PERUSAHAAN',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: MainColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * (80 / 100),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                decoration: BoxDecoration(
                    color: MainColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                    )),
                child: SingleChildScrollView(
                  child: CardMainProfil(),
                ),
              ))
        ],
      ),
    );
  }
}
