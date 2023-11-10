// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';

class CardWidgetIndex extends StatelessWidget {
  final String? indexName;
  final int? prevI;
  final int? openI;
  final int? highI;
  final int? lowI;
  final int? valueI;
  final int? volumeI;
  final int? unchangeI;
  final int? upI;
  final int? downI;
  final int? change;
  final int? changeR;
  final int? freq;

  const CardWidgetIndex({
    Key? key,
    required this.indexName,
    this.prevI,
    this.openI,
    this.highI,
    this.lowI,
    this.change,
    this.changeR,
    this.freq,
    this.valueI,
    this.volumeI,
    this.upI,
    this.downI,
    this.unchangeI,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgabu,
      borderOnForeground: true,
      elevation: 10,
      child: Padding(
          padding: EdgeInsets.all(7.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        indexName.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size12,
                        ),
                      ),
                      Row(
                        children: [
                          change! == 0
                              ? Container()
                              : change!.toInt() > 0.toInt()
                                  ? Text(
                                      "+",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: FontSizes.size12,
                                      ),
                                    )
                                  : Container(),
                          Text(
                            "${formatIndex4k(change!.toDouble())}",
                            style: TextStyle(
                              color: change!.toInt() == 0
                                  ? Colors.white
                                  : change!.toInt() >= 0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: FontSizes.size12,
                            ),
                          ),
                          Text(
                            "(${formatIndex2k(changeR!.toDouble())}%)",
                            style: TextStyle(
                              color: change!.toInt() == 0
                                  ? Colors.white
                                  : change!.toInt() >= 0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: FontSizes.size12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Open",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                "${formatIndex4k(openI!.toDouble())}",
                                style: TextStyle(
                                    color: Colorss(openI, prevI),
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "High",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                "${formatIndex4k(highI!.toDouble())}",
                                style: TextStyle(
                                    color: Colorss(highI, prevI),
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Low",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                "${formatIndex4k(lowI!.toDouble())}",
                                style: TextStyle(
                                    color: Colorss(lowI, prevI),
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Prev",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                "${formatIndex4k(prevI!.toDouble())}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Vol",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                formattaCurrun(volumeI!.toInt()),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 9.2.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                formattaCurrun(upI!.toInt()),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Down",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                formattaCurrun(downI!.toInt()),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Freq",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                formattaCurrun(freq!.toInt()),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unchange",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                              Text(
                                formattaCurrun(unchangeI!.toInt()),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Val",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size10),
                              ),
                              Text(
                                formattaCurrun(valueI!.toInt()),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.2.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
