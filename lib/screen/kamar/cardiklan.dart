import 'package:flutter/material.dart';

class CardIklan extends StatelessWidget {
  final String img;
  CardIklan({
    Key key,
    @required this.img,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage('$img'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
