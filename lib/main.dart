import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MainColors.primary, // navigation bar color
    statusBarColor: MainColors.primary, // status bar color
  ));

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaraswatiLand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: MainColors.primary,
            displayColor: MainColors.primary,
            fontFamily: 'Poppins'),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
