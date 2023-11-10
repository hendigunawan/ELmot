import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';

RxBool isSearchq = false.obs;

// ignore: must_be_immutable
class DetailCheckOut extends StatelessWidget {
  final String title;
  final String? board;
  final Widget boardWidget;
  final String? typeCheckout;
  const DetailCheckOut(
      {super.key,
      required this.title,
      this.board,
      required this.boardWidget,
      this.typeCheckout});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300));
    return Container(
      width: 0.9.sw,
      height: 0.41.sw,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(7.r),
          border:
              Border.all(width: 0.5.w, color: Colors.grey.withOpacity(0.5))),
      margin: EdgeInsets.only(
        bottom: 7.h,
      ),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: StreamBuilder(
          stream: ObjectBoxDatabase.qoutesRealtimeWithQuery(
            title,
            Get.find<ControllerBoard>().boards.value,
          ),
          builder: (context, snap) {
            if (snap.data == null) {
              return Container();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 0.50.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isSearchq.toggle();
                                    isSearchq.refresh();
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: 130.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 4.w,
                                      right: 4.w,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 101.w,
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(
                                                0.9,
                                              ),
                                              fontSize: FontSizes.size13,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Icon(
                                          Icons.search,
                                          size: 20.sp,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                boardWidget,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 0.5.sw,
                            child: Text(
                              ObjectBoxDatabase.stockList
                                  .query(
                                      PackageStockList_.stcokCode.equals(title))
                                  .build()
                                  .findFirst()!
                                  .stockName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            snap.data!.isEmpty
                                ? '0'
                                : formattaCurrun(
                                    snap.data!.first.lastPrice!.toInt()),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSizes.size13,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                snap.data!.isEmpty
                                    ? '0'
                                    : " ${formattaCurrun(snap.data!.first.change!.toInt())}",
                                style: TextStyle(
                                  fontSize: FontSizes.size13,
                                  color: snap.data!.isEmpty
                                      ? Colors.white
                                      : snap.data!.first.change!.toInt() < 0
                                          ? Colors.red
                                          : snap.data!.first.change!.toInt() ==
                                                  0
                                              ? Colors.white
                                              : Colors.green,
                                ),
                              ),
                              Text(
                                snap.data!.isEmpty
                                    ? '0'
                                    : " (${snap.data!.first.chgRate!.toInt().toDouble() / 100}%)",
                                style: TextStyle(
                                  fontSize: FontSizes.size13,
                                  color: snap.data == null || snap.data!.isEmpty
                                      ? Colors.white
                                      : snap.data!.first.chgRate!.toInt() < 0
                                          ? Colors.red
                                          : snap.data!.first.chgRate!.toInt() ==
                                                  0
                                              ? Colors.white
                                              : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    height: 6.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.hiPrice!.toInt()),
                                  style: TextStyle(
                                    color: snap.data!.isEmpty
                                        ? Colors.white
                                        : Colorss(
                                            snap.data!.first.hiPrice,
                                            snap.data!.first.prevPrice,
                                          ),
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.loPrice!.toInt()),
                                  style: TextStyle(
                                    color: snap.data!.isEmpty
                                        ? Colors.white
                                        : Colorss(
                                            snap.data!.first.loPrice,
                                            snap.data!.first.prevPrice,
                                          ),
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.openPrice!.toInt()),
                                  style: TextStyle(
                                    color: snap.data!.isEmpty
                                        ? Colors.white
                                        : Colorss(
                                            snap.data!.first.openPrice,
                                            snap.data!.first.prevPrice,
                                          ),
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.prevPrice!.toInt()),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Avg",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurruns(
                                          snap.data!.first.avgPrice!.toInt() /
                                              100),
                                  style: TextStyle(
                                    color: snap.data!.isEmpty
                                        ? Colors.white
                                        : Colorss(
                                            snap.data!.first.avgPrice,
                                            snap.data!.first.prevPrice,
                                          ),
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Val",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.value! ~/ 100,
                                        ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vol",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.volume! * 100,
                                        ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  snap.data!.isEmpty
                                      ? '0'
                                      : formattaCurrun(
                                          snap.data!.first.freq!,
                                        ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
