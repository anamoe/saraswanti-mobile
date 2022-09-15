import 'package:flutter/material.dart';
import 'package:saraswantiland/widget/maicolors.dart';

class BoxPromoKamar extends StatelessWidget {
  String kode;
  String judul;

  BoxPromoKamar({
    Key key,
    @required this.kode,
    @required this.judul,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: MainColors.kLightGreen,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Column(
                children: <Widget>[Image.asset("assets/images/boxicon.png")],
              ),
            ),
            Container(
              width: 190,
              child: Column(
                children: [
                  Text(
                    "$judul",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    "Tukarkan Kode Ini Saat Anda Memesan Unit",
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Card(
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Text(
                      "$kode",
                      style: TextStyle(color: MainColors.kLightGreen),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
