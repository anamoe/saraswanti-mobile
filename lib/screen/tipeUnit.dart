import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/footer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saraswantiland/widget/maicolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saraswantiland/widget/sceleton.dart';
import 'package:saraswantiland/screen/galery/SarasGalery.dart';
import 'package:saraswantiland/widget/footer.dart';


class TipeUnit extends StatefulWidget {
  TipeUnit({this.listUnit});
  List<String> listUnit;
  @override
  State<TipeUnit> createState() => _TipeUnitState();
}

class _TipeUnitState extends State<TipeUnit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipe Unit'),
        backgroundColor: MainColors.primary,
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
          child : Column(
            children: [
              Container(
                   padding: EdgeInsets.symmetric(vertical: 13),
                  width: 180,
                  child: Image.asset(
                    "assets/images/arjunatower.png",
                  ),
                 ),
              for(int i =0;i<widget.listUnit.length;i++)...[
                Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SarasGallery(imagePaths: widget.listUnit, currentIndex: i)));
                          },
          child: 
              Container(
                width: MediaQuery.of(context).size.width,
                height: 210,
                child: CachedNetworkImage(
                  imageUrl: widget.listUnit[i],
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: (context, url) => SceletonCard(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
        ),
      ),
    )
              ],
              FooterKu()
            ],
          ),        ));
      }),
    );
  }


}
