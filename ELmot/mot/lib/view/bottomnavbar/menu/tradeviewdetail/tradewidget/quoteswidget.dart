import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'package:shimmer/shimmer.dart';

class QuotesView extends StatelessWidget {
  final String quotesName;
  final String board;
  final String subTitle;
  const QuotesView(
      {super.key,
      required this.quotesName,
      required this.subTitle,
      required this.board});
  @override
  Widget build(BuildContext context) {
    var query = ObjectBoxDatabase.stockList
        .query(
          PackageStockList_.stcokCode.equals(
            quotesName.toString(),
          ),
        )
        .build()
        .findFirst();
    StringBuffer getSpecialNotiver() {
      if (query != null) {
        String getSN = query.remake2.toString();
        if (getSN.length >= 19) {
          String specialNotiver = getSN.substring(19, 30);
          List<String> fragments = specialNotiver.split('-');
          final buffer = StringBuffer();

          for (String fragment in fragments) {
            if (fragment != "-") {
              buffer.write(fragment);
            }
          }
          return buffer;
        } else {
          return StringBuffer();
        }
      } else {
        return StringBuffer();
      }
    }

    return Container(
      padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
      child: StreamBuilder(
        stream: ObjectBoxDatabase.qoutesRealtimeWithQuery(quotesName, board),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Shimmer.fromColors(
                      baseColor: bgabu,
                      highlightColor: highlightShimmer,
                      enabled: true,
                      child: Container(
                          alignment: Alignment.topCenter,
                          width: 0.3.sw,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: foregroundwidget,
                            borderRadius: BorderRadius.circular(5.r),
                          )),
                    ),
                    const Spacer(),
                    getSpecialNotiver().toString() == ''
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              NotifikasiPopup.showINFO(
                                text: specialNotations(
                                  getSpecialNotiver(),
                                ).toString(),
                              );
                            },
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.lightBlue,
                              size: 18.sp,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 2.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: bgabu,
                      highlightColor: highlightShimmer,
                      enabled: true,
                      child: Container(
                          width: 0.25.sw,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: foregroundwidget,
                            borderRadius: BorderRadius.circular(5.r),
                          )),
                    ),
                    Column(
                      children: [
                        Text(
                          "PREV",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "AVG",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "OPEN",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: 0.1.sw,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: foregroundwidget,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "HIGH",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "LOW",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "VOL",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "FREQ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "MARKET CAP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "VALUE",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "IEP : ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "IEV : ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: bgabu,
                          highlightColor: highlightShimmer,
                          enabled: true,
                          child: Container(
                              alignment: Alignment.topCenter,
                              width: 0.1.sw,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.circular(5.r),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          } else if (snap.data == null || snap.data!.isEmpty) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 13.5.sp),
                    ),
                    const Spacer(),
                    getSpecialNotiver().toString() == ''
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              NotifikasiPopup.showINFO(
                                text: specialNotations(
                                  getSpecialNotiver(),
                                ).toString(),
                              );
                            },
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.lightBlue,
                              size: 18.sp,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 2.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "  ",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        Row(
                          children: [
                            Text(
                              '',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            Text(
                              '',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            Text(
                              '',
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "PREV",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "AVG",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          " ",
                          style: TextStyle(
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "OPEN",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "HIGH",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "LOW",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "VOL",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "FREQ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "MARKET CAP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size11,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "VALUE",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "IEP : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: FontSizes.size12,
                      ),
                    ),
                    Text(
                      "IEV : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: FontSizes.size12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      subTitle == '' ? query!.stockName! : subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 13.5.sp),
                    ),
                    const Spacer(),
                    getSpecialNotiver().toString() == ''
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              NotifikasiPopup.showINFO(
                                text: specialNotations(
                                  getSpecialNotiver(),
                                ).toString(),
                              );
                            },
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.lightBlue,
                              size: 18.sp,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 2.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          snap.data!.first.change!.toInt() == 0
                              ? CupertinoIcons.equal
                              : snap.data!.first.change!.toInt() > 0
                                  ? CupertinoIcons.arrowtriangle_up_fill
                                  : CupertinoIcons.arrowtriangle_down_fill,
                          color: Colorss(snap.data!.first.lastPrice!.toInt(),
                              snap.data!.first.prevPrice!.toInt()),
                          size: 18.w,
                        ),
                        Text(
                          " ${formattaCurrun(snap.data!.first.lastPrice!.toInt())}",
                          style: TextStyle(
                              color: Colorss(
                                snap.data!.first.lastPrice!.toInt(),
                                snap.data!.first.prevPrice!.toInt(),
                              ),
                              fontSize: 13.sp),
                        ),
                        Row(
                          children: [
                            Text(
                              snap.data!.first.change!.toInt() < 0
                                  ? " "
                                  : snap.data!.first.change!.toInt() == 0
                                      ? ' '
                                      : ' +',
                              style: TextStyle(
                                  color: snap.data!.first.change!.toInt() < 0
                                      ? Colors.red
                                      : snap.data!.first.change!.toInt() == 0
                                          ? Colors.white
                                          : Colors.green,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              formattaCurrun(snap.data!.first.change!.toInt()),
                              style: TextStyle(
                                  color: snap.data!.first.change!.toInt() < 0
                                      ? Colors.red
                                      : snap.data!.first.change!.toInt() == 0
                                          ? Colors.white
                                          : Colors.green,
                                  fontSize: 13.sp),
                            ),
                            Text(
                              ' (${formataCurrun(snap.data!.first.chgRate!.toInt())}%)',
                              style: TextStyle(
                                  color: snap.data!.first.chgRate!.toInt() < 0
                                      ? Colors.red
                                      : snap.data!.first.chgRate!.toInt() == 0
                                          ? Colors.white
                                          : Colors.green,
                                  fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "PREV",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(snap.data!.first.prevPrice!),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "AVG",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          "${snap.data!.first.avgPrice!.toInt() / 100}",
                          style: TextStyle(
                            color: ColorsAvg(
                              snap.data!.first.avgPrice!.toDouble() / 100,
                              snap.data!.first.prevPrice!.toDouble(),
                            ),
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "OPEN",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(snap.data!.first.openPrice!.toInt()),
                          style: TextStyle(
                            color: Colorss(
                              snap.data!.first.openPrice!.toInt(),
                              snap.data!.first.prevPrice!.toInt(),
                            ),
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "HIGH",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(snap.data!.first.hiPrice!.toInt()),
                          style: TextStyle(
                            color: Colorss(
                              snap.data!.first.hiPrice!.toInt(),
                              snap.data!.first.prevPrice!.toInt(),
                            ),
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "LOW",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(snap.data!.first.loPrice!.toInt()),
                          style: TextStyle(
                            color: Colorss(
                              snap.data!.first.loPrice!.toInt(),
                              snap.data!.first.prevPrice!.toInt(),
                            ),
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "VOL",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(
                              snap.data!.first.volume!.toInt() * 100),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: snap.data!.first.volume!.toInt() < 100000
                                ? FontSizes.size12
                                : FontSizes.size11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "FREQ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(snap.data!.first.freq!.toInt()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "MARKET CAP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formatMCap(snap.data!.first.marketCaps!.toInt()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                snap.data!.first.marketCaps!.toInt() < 1000000
                                    ? FontSizes.size12
                                    : FontSizes.size11,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "VALUE",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          formattaCurrun(snap.data!.first.value!.toInt()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: snap.data!.first.value!.toInt() < 1000000
                                ? FontSizes.size12
                                : FontSizes.size11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "IEP : ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          snap.data!.first.IEPrice != null
                              ? " ${formattaCurrun(snap.data!.first.IEPrice!.toInt())}"
                              : "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "IEV : ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Text(
                          " ${formattaCurrun(snap.data!.first.IEVolume == null ? 0 : snap.data!.first.IEVolume!.toInt())}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
