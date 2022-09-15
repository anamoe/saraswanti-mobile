import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/screen/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MainColors.primary,
      backgroundColor: MainColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/icon/LOGO SID TBK004.png',
                  width: 350,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Text(
            //   "SARASWANTILAND",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 30,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void movingToNextScreen() {
    Timer(
        Duration(
          seconds: 3,
        ), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    movingToNextScreen();
  }
}
