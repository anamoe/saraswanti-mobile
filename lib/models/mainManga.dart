import 'package:flutter/material.dart';
import 'package:saraswantiland/models/manga.dart';
import 'package:saraswantiland/models/helper.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:saraswantiland/widget/headertop.dart';
import 'package:saraswantiland/screen/kamar/cardiklan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saraswantiland/models/driverModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:saraswantiland/screen/viewWeb.dart';

class MangaMain extends StatefulWidget {
  @override
  _MangaMainState createState() => _MangaMainState();
}

class _MangaMainState extends State<MangaMain> {
  Helper _helper = Helper();
  List datadariJSON;
  String url = DriverModel.url + "/getbisnisproperti";
  Future ambildata() async {
    http.Response hasil =
        await http.get(url, headers: {"Accept": "application/json"});

    datadariJSON = json.decode(hasil.body)['Bisnis Properti'];
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
        body: Column(
      children: [
        TopContainer(
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
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
                              'BISNIS PROPERTI',
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
        FutureBuilder(
            future: ambildata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CarouselSlider(
                    options: CarouselOptions(height: 150.0),
                    items: datadariJSON.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return CardIklan(img: i["foto"]);
                        },
                      );
                    }).toList(),
                  ),
                );
              } else {
                return SceletonCard(
                  width: MediaQuery.of(context).size.width,
                );
              }
            }),
        Expanded(
          child: FutureBuilder<List<Manga>>(
            initialData: List<Manga>(),
            future: _helper.getAllManga(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Manga>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                    child: RefreshProgressIndicator(),
                  );
                case ConnectionState.none:
                  return Center(
                    child: Text('Tidak ada koneksi'),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Data yang diterima salah'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // return ListTile(
                      //     // leading: Icon(Icons.book),
                      //     // title: Text(snapshot.data[index].title),
                      //     // onTap: () {
                      //     //   Navigator.push(
                      //     //       context,
                      //     //       MaterialPageRoute(
                      //     //           builder: (context) => ViewWeb(
                      //     //                 url: snapshot.data[index].url.toString(),
                      //     //               )));
                      //     // },

                      //     );
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewWeb(
                                              url: snapshot.data[index].url
                                                  .toString(),
                                            )));
                              },
                              child: Card(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          (25 / 100),
                                      child: Image.network(
                                          snapshot.data[index].img),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (70 / 100),
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              snapshot.data[index].date,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 9),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              )));
                    },
                  );
              }
            },
          ),
        )
      ],
    ));
  }
}
