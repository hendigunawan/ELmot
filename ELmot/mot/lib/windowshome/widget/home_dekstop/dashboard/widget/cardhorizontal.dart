import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/textsclae.dart';
import 'package:online_trading/helper/constant_style.dart';

class CardHorizontalDesktop extends StatelessWidget {
  final String? stockC;
  final int? bidPrice;
  final int? bidVolume;
  const CardHorizontalDesktop({
    super.key,
    this.stockC,
    this.bidPrice,
    this.bidVolume,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.01),
      width: size.width * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgabu,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.01,
          left: size.width * 0.005,
          right: size.width * 0.005,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stockC.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: ScaleSize.textScaleFactor(context) / 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              bidPrice.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: ScaleSize.textScaleFactor(context) / 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              bidVolume.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: ScaleSize.textScaleFactor(context) / 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
