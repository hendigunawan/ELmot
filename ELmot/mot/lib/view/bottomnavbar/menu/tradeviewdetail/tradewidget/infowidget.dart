import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class InfoWidget extends StatelessWidget {
  final String stockC;
  final String stockN;
  const InfoWidget({super.key, required this.stockC, required this.stockN});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
              width: 1.sw,
              child: Card(
                color: bgabu,
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pemegang Saham",
                        style: TextStyle(
                            color: Colors.white, fontSize: FontSizes.size13),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        " ",
                        style: TextStyle(
                            color: Colors.white, fontSize: FontSizes.size13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 80.h,
                width: 1.sw,
                child: Card(
                  color: bgabu,
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pemegang Saham",
                          style: TextStyle(
                              color: Colors.white, fontSize: FontSizes.size13),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          " ",
                          style: TextStyle(
                              color: Colors.white, fontSize: FontSizes.size13),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
