import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CardKamar extends StatelessWidget {
  final String no;
  final double progress;

  CardKamar({
    Key key,
    @required this.no,
    @required this.progress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
      child: SizedBox(
          height: 50,
          width: 76,
          child: LiquidLinearProgressIndicator(
            value: progress, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(
                Colors.green), // Defaults to the current Theme's accentColor.
            backgroundColor:
                Colors.red, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.transparent, //border color of the bar
            borderWidth: 5.0, //border width of the bar
            borderRadius: 12.0, //border radius
            direction: Axis.horizontal,
            // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
            center: Text(
              "$no",
              style: TextStyle(color: Colors.white),
            ), //text inside bar
          )),
    );
  }
}
