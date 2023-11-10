import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/textsclae.dart';
import 'package:online_trading/helper/constant_style.dart';

import 'package:online_trading/windowshome/widget/home_dekstop/dashboard/horizontal_viewdesktop.dart';
import 'package:online_trading/windowshome/widget/home_dekstop/dashboard/widget/header.dart';

class MainHomeDesktop extends StatelessWidget {
  const MainHomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          const HeaderDesktop(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: size.height * 0.005,
                    left: size.width * 0.01,
                    right: size.width * 0.01),
                width: size.width * 0.73,
                height: size.height * 0.92,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "OrderBook",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor:
                              ScaleSize.textScaleFactor(context) / 1.4,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: size.width * 0.015,
                                right: size.width * 0.015),
                            width: size.width * 0.1,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Add New",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context) / 1.8,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const HorizontalDesktop()
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: size.width * 0.01),
                  height: size.height * 0.92,
                  width: double.minPositive,
                  decoration: BoxDecoration(
                      color: bgabu, borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ])
            // child: Row(
            //   children: [
            //     Container(
            //       color: Colors.black,
            //       width: size.width * 0.73,
            //       height: size.height * 1,
            //       child: Column(
            //         children: [],
            //       ),
            //     ),
            //     Flexible(
            //       child: Container(
            //         color: Colors.amber,
            //         height: size.height * 1,
            //       ),
            //     )
            //   ],
            // ),
            ));
  }
}
