import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SceletonCard extends StatelessWidget {
  final double width;
  SceletonCard({this.width});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.white,
        child: box(),
      ),
    );
  }

  Widget box() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
      child: Container(
          child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 150,
          width: width,
          color: Colors.grey,
        ),
      )),
    );
  }
}
