import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';

class QuotesIndex extends StatelessWidget {
  final String indexCode;
  const QuotesIndex({super.key, required this.indexCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 175.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          width: 0.5.w,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: 7.h,
        left: 5.w,
        right: 5.w,
      ),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: StreamBuilder(
            stream: ObjectBoxDatabase.quoteIndexrealtim(indexCode),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snap.data!.isEmpty) {
                  return Container();
                } else {
                  var data = snap.data!.first;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                indexCode,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size13),
                              ),
                              Row(
                                children: [
                                  data.change! == 0
                                      ? Container()
                                      : data.change!.toInt() > 0.toInt()
                                          ? Text("+",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: FontSizes.size13))
                                          : Container(),
                                  Text(
                                    "${formatIndex4k(data.change!.toDouble())} (${formatIndex2k(data.changeR!.toDouble())}%)",
                                    style: TextStyle(
                                        color: data.change!.toInt() == 0
                                            ? Colors.white
                                            : data.change!.toInt() >= 0
                                                ? Colors.green
                                                : Colors.red,
                                        fontSize: FontSizes.size13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 1.sw,
                        height: 0.5.h,
                        color: putihop85,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Open",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      "${formatIndex4k(data.openI!.toDouble())}",
                                      style: TextStyle(
                                        color: Colorss(
                                          data.openI!.toInt(),
                                          data.prevI!.toInt(),
                                        ),
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "High",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      "${formatIndex4k(data.highI!.toDouble())}",
                                      style: TextStyle(
                                          fontSize: FontSizes.size12,
                                          color: Colorss(data.highI!.toInt(),
                                              data.prevI!.toInt())),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Low",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      "${formatIndex4k(data.lowI!.toDouble())}",
                                      style: TextStyle(
                                          fontSize: FontSizes.size12,
                                          color: Colorss(data.lowI!.toInt(),
                                              data.prevI!.toInt())),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Prev",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      "${formatIndex4k(data.prevI!.toDouble())}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Vol",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      formattaCurrun(data.volume!.toInt()),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size10,
                                      ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      formattaCurrun(data.up!.toInt()),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Down",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      formattaCurrun(data.down!.toInt()),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Freq",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      formattaCurrun(data.freq!.toInt()),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Unchange",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      formattaCurrun(data.unChange!.toInt()),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Val",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      formattaCurrun(data.value!.toInt()),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  );
                }
              }
            }),
      ),
    );
  }
}
