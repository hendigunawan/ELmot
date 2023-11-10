import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolio.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/helper/getSpesialnotifier.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/special_notations.dart';

class PortopolioWidget extends StatelessWidget {
  PortopolioWidget({super.key});
  final RxBool _tableStocktype = true.obs;
  final RxBool _showSettlement = true.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5.w),
          alignment: Alignment.center,
          width: 1.sw,
          height: 30.h,
          decoration: BoxDecoration(
            color: bgabu,
          ),
          child: Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Portopolio Summary",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
            ),
          ),
        ),
        Obx(() {
          if (listPortopolio!.isEmpty) {
            return Container(
                padding: EdgeInsets.all(5.w),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cash",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Cash T+2",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Trading Limit",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Interest",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Current Ratio",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Market Ratio",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                      ],
                    )
                  ],
                ));
          } else {
            return Container(
                padding: EdgeInsets.all(5.w),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cash",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          formattaCurrun(listPortopolio!.first.currentCash!),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Cash T+2",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          formattaCurrun(listPortopolio!.first.cashOnTPlus3!),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Trading Limit",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          formattaCurrun(
                              listPortopolio!.first.remainTradingLimit!),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Interest",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          formattaCurrun(listPortopolio!.first.interest!),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Current Ratio",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          formatIndex2k(listPortopolio!.first.currentRatio!
                                  .toDouble())
                              .toString(),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
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
                          "Market Ratio",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                        Text(
                          formatIndex2k(
                                  listPortopolio!.first.marketRatio!.toDouble())
                              .toString(),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                      ],
                    )
                  ],
                ));
          }
        }),
        Container(
          margin: EdgeInsets.only(bottom: 3.h),
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 3.h),
          alignment: Alignment.center,
          width: 1.sw,
          height: 30.h,
          decoration: BoxDecoration(
            color: bgabu,
          ),
          child: Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Stock",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
                  ),
                  GestureDetector(onTap: () {
                    if (listPortopolio!.isEmpty) {
                      NotifikasiPopup.showWarning("Please insert PIN");
                    } else {
                      _tableStocktype.value = !_tableStocktype.value;
                    }
                  }, child: Obx(() {
                    return FittedBox(
                      child: Icon(
                        Icons.change_circle,
                        color:
                            _tableStocktype.value ? Colors.blue : Colors.white,
                        size: 19.sp,
                      ),
                    );
                  }))
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (listPortopolio!.isEmpty) {
            return Center(
              child: Text(
                " - ",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 14.sp),
              ),
            );
          } else {
            if (_tableStocktype.value) {
              return SizedBox(
                height: 200.h,
                width: 1.sw,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: HorizontalDataTable(
                    elevation: 0,
                    rowSeparatorWidget: Divider(
                      height: 2.h,
                      thickness: 0.05,
                    ),
                    leftHandSideColumnWidth: 0.25.sw,
                    rightHandSideColumnWidth: 2.6.sw,
                    isFixedHeader: true,
                    isFixedFooter: true,
                    leftHandSideColBackgroundColor: Colors.black,
                    headerWidgets: _getHeaderWidget(),
                    footerWidgets: [
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                        child: Text(
                          'Total',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.3.sw,
                        color: foregroundwidget,
                        child: Text(
                          formattaCurrun(
                              listPortopolio!.first.totalPotentialGainLoss!),
                          style: TextStyle(
                              color: listPortopolio!
                                          .first.totalPotentialGainLoss! ==
                                      0
                                  ? Colors.yellow
                                  : listPortopolio!
                                              .first.totalPotentialGainLoss!
                                              .toInt() >=
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                        child: Text(
                          "${formatIndex2k(listPortopolio!.first.totalPotentialGainLossPercentage!.toDouble())} %",
                          style: TextStyle(
                              color: listPortopolio!.first
                                          .totalPotentialGainLossPercentage! ==
                                      0
                                  ? Colors.yellow
                                  : listPortopolio!.first
                                              .totalPotentialGainLossPercentage!
                                              .toInt() >=
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.3.sw,
                        color: foregroundwidget,
                        child: Text(
                          formattaCurrun(
                              listPortopolio!.first.totalMarketValue!),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                    ],
                    leftSideItemBuilder: (context, index) {
                      var data = listPortopolio!.first.arrayPorto;
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    " ${data![index].stockCode.toString()}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 11.sp),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 0.05.sw,
                                  child: !delistingStock(data[index].stockCode!)
                                      ? null
                                      : getSpesialNotifier(
                                                  data[index].stockCode!)
                                              .isEmpty
                                          ? null
                                          : GestureDetector(
                                              onTap: () {
                                                NotifikasiPopup.showINFO(
                                                    text:
                                                        '${specialNotations(getSpesialNotifier(data[index].stockCode!))}');
                                              },
                                              child: Icon(
                                                Icons.info_outline,
                                                color: Colors.blue,
                                                size: 15.sp,
                                              ),
                                            ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    rightSideItemBuilder: (context, index) {
                      var data = listPortopolio!.first.arrayPorto;
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data![index].volume!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].balance!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].lastPrice!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrunAverage(data[index].avgPrice!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.3.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].potentialGainLoss!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formatIndex2k(data[index]
                                      .potentialGainLossPercentage!
                                      .toDouble())
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].openBuyVolume!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].openSellVolume!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.3.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].marketValue!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].haircut!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: listPortopolio!.isEmpty
                        ? 0
                        : listPortopolio!.first.arrayPorto!.length,
                    rightHandSideColBackgroundColor: Colors.black,
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: 200.h,
                width: 1.sw,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: HorizontalDataTable(
                    elevation: 0,
                    rowSeparatorWidget: Divider(
                      height: 2.h,
                      thickness: 0.05,
                    ),
                    leftHandSideColumnWidth: 0.2.sw,
                    rightHandSideColumnWidth: 0.8.sw,
                    isFixedHeader: true,
                    isFixedFooter: true,
                    leftHandSideColBackgroundColor: Colors.black,
                    headerWidgets: _getHeaderWidgetType2(),
                    footerWidgets: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 20.h,
                            width: 0.2.sw,
                            color: foregroundwidget,
                            child: Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                        child: Text(
                          formattaCurrun(
                              listPortopolio!.first.totalMarketValue!),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 5.w),
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.3.sw,
                        color: foregroundwidget,
                        child: Text(
                          formattaCurrun(
                              listPortopolio!.first.totalPotentialGainLoss!),
                          style: TextStyle(
                              color: listPortopolio!
                                          .first.totalPotentialGainLoss!
                                          .toInt() ==
                                      0
                                  ? Colors.yellow
                                  : listPortopolio!
                                              .first.totalPotentialGainLoss!
                                              .toInt() >=
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 12.sp),
                        ),
                      ),
                    ],
                    leftSideItemBuilder: (context, index) {
                      var data = listPortopolio!.first.arrayPorto;
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            height: 40.h,
                            width: 0.2.sw,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  data![index].stockCode.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  formattaCurrun(data[index].volume!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    rightSideItemBuilder: (context, index) {
                      var data = listPortopolio!.first.arrayPorto;
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            height: 40.h,
                            width: 0.25.sw,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formattaCurrun(data![index].avgPrice!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp),
                                ),
                                Text(
                                  formattaCurrun(
                                      data[index].marketValue!.toInt()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            height: 40.h,
                            width: 0.25.sw,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formattaCurrun(data[index].lastPrice!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp),
                                ),
                                Text(
                                  formattaCurrun(data[index].marketValue!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 5.w),
                            alignment: Alignment.centerRight,
                            height: 40.h,
                            width: 0.3.sw,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${formatIndex2k(data[index].potentialGainLossPercentage!.toDouble())}%",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: data[index]
                                                  .potentialGainLossPercentage!
                                                  .toInt() ==
                                              0
                                          ? Colors.yellow
                                          : data[index]
                                                      .potentialGainLossPercentage!
                                                      .toInt() >=
                                                  0
                                              ? Colors.green
                                              : Colors.red,
                                      fontSize: 11.sp),
                                ),
                                Text(
                                  formattaCurrun(
                                      data[index].potentialGainLoss!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: listPortopolio!.isEmpty
                        ? 0
                        : listPortopolio!.first.arrayPorto!.length,
                    rightHandSideColBackgroundColor: Colors.black,
                  ),
                ),
              );
            }
          }
        }),
        Container(
          margin: EdgeInsets.only(
            top: 4.h,
            bottom: 3.h,
          ),
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 3.h),
          alignment: Alignment.center,
          width: 1.sw,
          height: 0.045.sh,
          decoration: BoxDecoration(
            color: bgabu,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Settlement",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
              Obx(() {
                return GestureDetector(
                    onTap: () {
                      if (listPortopolio!.isEmpty) {
                        NotifikasiPopup.showWarning("Please insert PIN");
                      } else {
                        _showSettlement.value = !_showSettlement.value;
                      }
                    },
                    child: FittedBox(
                      child: Icon(
                        _showSettlement.value
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                        color:
                            _showSettlement.value ? Colors.blue : Colors.white,
                        size: 19.sp,
                      ),
                    ));
              })
            ],
          ),
        ),
        Obx(() {
          if (listPortopolio!.isEmpty) {
            return Container();
          } else {
            if (_showSettlement.value) {
              return Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 4.w),
                        width: 0.15.sw,
                        height: 25.h,
                        decoration: BoxDecoration(color: foregroundwidget),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Account",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 4.w),
                        width: 0.15.sw,
                        height: 25.h,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "AR",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 4.w),
                        width: 0.15.sw,
                        height: 25.h,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "AP",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 4.w),
                        width: 0.15.sw,
                        height: 25.h,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Block",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 4.w),
                        width: 0.15.sw,
                        height: 25.h,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Netcash",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        SizedBox(
                          width: 0.85.sw,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration:
                                        BoxDecoration(color: foregroundwidget),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Cash T+0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t0AR!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t0AP!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(listPortopolio!
                                              .first.t0FundTransferRequest!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t0NetCash!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration:
                                        BoxDecoration(color: foregroundwidget),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Cash T+1",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t1AR!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t1AP!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(listPortopolio!
                                              .first.t1FundTransferRequest!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t1NetCash!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration:
                                        BoxDecoration(color: foregroundwidget),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Cash T+2",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t2AR!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t2AP!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(listPortopolio!
                                              .first.t2FundTransferRequest!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 4.w),
                                    width: 0.283.sw,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: Center(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formattaCurrun(
                                              listPortopolio!.first.t2NetCash!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })
                ],
              );
            } else {
              return Container();
            }
          }
        })
      ],
    );
  }
}

List<Widget> _getHeaderWidget() {
  return [
    Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 20.h,
          width: 0.25.sw,
          color: foregroundwidget.withOpacity(0.9),
          child: Text(
            'Code',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
        ),
      ],
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Vol',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Balance',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Last',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Avg',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'G/L',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'G/L(%)',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Open Buy',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Open Sell',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Market Val',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'Haircut',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}

List<Widget> _getHeaderWidgetType2() {
  return [
    Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40.h,
          width: 0.2.sw,
          color: foregroundwidget.withOpacity(0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Code',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                'Lot',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    Container(
      alignment: Alignment.center,
      height: 40.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Avg Price',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
          Text(
            'Amount',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
        ],
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 40.h,
      width: 0.25.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Last Price',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
          Text(
            'M Value',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
        ],
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 40.h,
      width: 0.3.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Unrealize',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
          Text(
            'Profit/Loss',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
        ],
      ),
    ),
  ];
}
