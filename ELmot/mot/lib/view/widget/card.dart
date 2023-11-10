import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.width,
    this.height,
    this.widget,
    this.elevation = 20,
  });
  final double? width;
  final double? height;
  final double? elevation;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: elevation, // the size of the shadow
        shadowColor: Colors.black, // shadow color
        color: Colors.lightGreen,
        child: widget,
      ),
    );
  }
}
