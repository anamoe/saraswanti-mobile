import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saraswantiland/widget/sceleton.dart';

class CardItem extends StatelessWidget {
  final String name;
  final String img;
  final Color color;
  final double width;
  final double fontsize;
  final Color fontcolor;
  final double imgheight;

  CardItem({
    Key key,
    this.name,
    @required this.img,
    @required this.width,
    @required this.color,
    this.fontsize,
    this.fontcolor,
    @required this.imgheight,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
      child: Card(
        color: color,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          child: Column(
            children: [
              Container(
                height: imgheight,
                child: CachedNetworkImage(
                  imageUrl: '$img',
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: (context, url) => SceletonCard(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              if (name != null) ...[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Text(
                    "$name",
                    style: TextStyle(
                        color: fontcolor,
                        fontSize: fontsize,
                        fontFamily: "Montserrat"),
                        textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
