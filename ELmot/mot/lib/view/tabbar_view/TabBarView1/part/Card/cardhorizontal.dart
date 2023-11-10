// ignore_for_file: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/mainchechout_view.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:shimmer/shimmer.dart';

class MyItem {
  final String value;
  final String label;

  MyItem(this.value, this.label);
}

class CardHorizontal extends StatelessWidget {
  final String title;
  final String? isi;
  final VoidCallback? onPressed;
  final String? spesialnotasi;
  final String? detailspesialnotasi;

  const CardHorizontal({
    required this.title,
    this.isi,
    this.onPressed,
    this.spesialnotasi,
    this.detailspesialnotasi,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final buildRG = Get.put(ControllerBoard());
    // buildRG;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
          margin: EdgeInsets.symmetric(horizontal: 3.5.w),
          width: 150.w,
          height: 160.h,
          decoration: BoxDecoration(
            color: bgabu,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundwidget,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: ObjectBoxDatabase.qoutesRealtimeWithQueryContainer(
                    title,
                  ),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Shimmer.fromColors(
                              period: const Duration(milliseconds: 1120),
                              baseColor: bgabu,
                              highlightColor: Colors.grey,
                              enabled: true,
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  width: 0.13.sw,
                                  height: 13.h,
                                  decoration: BoxDecoration(
                                    color: foregroundwidget,
                                    borderRadius: BorderRadius.circular(5.r),
                                  )),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Shimmer.fromColors(
                              period: const Duration(milliseconds: 1500),
                              baseColor: bgabu,
                              highlightColor: Colors.grey,
                              enabled: true,
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  width: 0.16.sw,
                                  height: 13.h,
                                  decoration: BoxDecoration(
                                    color: foregroundwidget,
                                    borderRadius: BorderRadius.circular(5.r),
                                  )),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1300),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.10.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 800),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.10.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1700),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.10.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1100),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.10.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1500),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.10.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1300),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.10.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1250),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.11.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 1500),
                                  baseColor: bgabu,
                                  highlightColor: Colors.grey,
                                  enabled: true,
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 0.15.sw,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: foregroundwidget,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      var data = snap.data;
                      getDataList.getDataNol(8, data!);
                      return Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${data.isEmpty ? '' : formattaCurrun(getDataList.dataQoutes.first.lastPrice!.toInt())} ",
                                  style: TextStyle(
                                    color: Colorss(
                                      getDataList.dataQoutes.first.lastPrice!,
                                      getDataList.dataQoutes.first.prevPrice!,
                                    ),
                                    fontSize: FontSizes.size15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                data.isEmpty
                                    ? Container()
                                    : Icon(
                                        snap.data!.first.change!.toInt() == 0
                                            ? CupertinoIcons.equal
                                            : snap.data!.first.change!.toInt() >
                                                    0
                                                ? CupertinoIcons
                                                    .arrowtriangle_up_fill
                                                : CupertinoIcons
                                                    .arrowtriangle_down_fill,
                                        color: Colorss(
                                          snap.data!.first.lastPrice!.toInt(),
                                          snap.data!.first.prevPrice!.toInt(),
                                        ),
                                        size: 16.sp,
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Center(
                              child: Text(
                                getDataList.dataQoutes.first.change! > 0 ||
                                        getDataList.dataQoutes.first.chgRate! >
                                            0
                                    ? '+${getDataList.dataQoutes.first.change} (+${getDataList.dataQoutes.first.chgRate!.toDouble() / 100}%)'
                                    : '${getDataList.dataQoutes.first.change} (${getDataList.dataQoutes.first.chgRate!.toDouble() / 100}%)',
                                style: TextStyle(
                                    color: snap.data!.isEmpty
                                        ? Colors.white
                                        : Colorss(
                                            getDataList
                                                .dataQoutes.first.lastPrice!,
                                            getDataList
                                                .dataQoutes.first.prevPrice!,
                                          ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizes.size12),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snap.data!.isEmpty ? "" : "High",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: FontSizes.size12),
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? ""
                                      : formattaCurrun(
                                          data.first.hiPrice!.toInt()),
                                  style: TextStyle(
                                      color: snap.data!.isEmpty
                                          ? Colors.white
                                          : Colorss(
                                              data.first.hiPrice,
                                              data.first.prevPrice,
                                            ),
                                      fontSize: FontSizes.size12),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snap.data!.isEmpty ? "" : "Low",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12),
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? ""
                                      : formattaCurrun(
                                          data.first.loPrice!.toInt()),
                                  style: TextStyle(
                                      color: snap.data!.isEmpty
                                          ? Colors.white
                                          : Colorss(
                                              data.first.loPrice,
                                              data.first.prevPrice,
                                            ),
                                      fontSize: FontSizes.size12),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snap.data!.isEmpty ? "" : "Avg",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12),
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? ""
                                      : data.first.avgPrice!.toDouble() == 0
                                          ? "0"
                                          : formattaCurrunAverage(
                                              data.first.avgPrice!.toInt(),
                                            ),
                                  style: TextStyle(
                                      color: snap.data!.isEmpty
                                          ? Colors.white
                                          : ColorsAvg(
                                              snap.data!.first.avgPrice!
                                                      .toDouble() /
                                                  100,
                                              snap.data!.first.prevPrice!
                                                  .toDouble(),
                                            ),
                                      fontSize: FontSizes.size12),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snap.data!.isEmpty ? "" : "Vol",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12),
                                ),
                                Text(
                                  snap.data!.isEmpty
                                      ? ""
                                      : formattaCurrun(
                                          data.first.volume!.toInt(),
                                        ),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          width: 150.w,
          height: 90.h,
          decoration: BoxDecoration(
            color: bgabu,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size12),
                  ),
                  Text(
                    spesialnotasi!.isEmpty
                        ? ""
                        : " [ ${spesialnotasi.toString()} ]",
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size12),
                  ),
                  const Spacer(),
                  detailspesialnotasi!.isEmpty
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            NotifikasiPopup.showINFO(
                                text: detailspesialnotasi.toString());
                          },
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.lightBlue,
                            size: 15.sp,
                          ),
                        ),
                ],
              ),
              SizedBox(height: 2.h),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  isi.toString(),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: putihop85, fontSize: FontSizes.size12),
                ),
              ),
              SizedBox(height: 10.h),
              PopupMenuButton(
                constraints: BoxConstraints.tightFor(
                  height: 100.h,
                  width: 75.w,
                ),
                color: foregroundwidget,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    height: 40.h,
                    value: "BUY",
                    child: Center(
                      child: Text(
                        'BUY',
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size12),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    height: 40.h,
                    value: "SELL",
                    child: Center(
                      child: Text(
                        'SELL',
                        style: TextStyle(
                          color: putihop85,
                          fontSize: FontSizes.size12,
                        ),
                      ),
                    ),
                  ),
                ],
                onSelected: (value) {
                  var query = ObjectBoxDatabase.quotesBox
                      .query(
                        Quotes_.stockCode.equals(title) &
                            Quotes_.board.equals(
                              Get.find<ControllerBoard>().boards.value,
                            ),
                      )
                      .build()
                      .findFirst();

                  if (value == "BUY") {
                    indexTabNewOrder.value = 0;
                    Navigator.pushNamed(
                      context,
                      '/goCheckoutview',
                      arguments: <String, String>{
                        'prevP': "${query!.prevPrice}",
                        'title': title,
                        'subtitle': isi.toString(),
                        'board': Get.find<ControllerBoard>().boards.value,
                        'typeCheckout': "BUY",
                      },
                    );
                  } else {
                    indexTabNewOrder.value = 1;
                    Navigator.pushNamed(
                      context,
                      '/goCheckoutview',
                      arguments: <String, String>{
                        'prevP': "${query!.prevPrice}",
                        'title': title,
                        'subtitle': isi.toString(),
                        'board': Get.find<ControllerBoard>().boards.value,
                        'typeCheckout': "SELL",
                      },
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: ConstantStyle.oren,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                      color: putihop85,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizes.size11,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class getDataList {
  static late List<Quotes> dataQoutes;

  static Future<void> getDataNol(int lenght, List<Quotes> data) async {
    Future.sync(() {
      return dataQoutes = List.generate(
        lenght,
        (index) {
          if (index < data.length) {
            return data[index];
          } else {
            return Quotes()
              ..prevPrice = 0
              ..lastPrice = 0
              ..volume = 0
              ..value = 0
              ..freq = 0
              ..change = 0
              ..chgRate = 0;
          }
        },
      );
    });
  }
}
