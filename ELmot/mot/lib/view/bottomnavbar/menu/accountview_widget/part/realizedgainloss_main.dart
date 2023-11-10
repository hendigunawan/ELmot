// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/realized_gainlost.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/helper/getSpesialnotifier.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'package:page_transition/page_transition.dart';

class RealizedGainLossMain extends StatelessWidget {
  RealizedGainLossMain({super.key});
  RxInt valuesTahun = DateTime.now().year.obs;
  RxInt selectedMonth = DateTime.now().month.obs;
  String sendDatemsg = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<PinSave>().pin.value = '';
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.find<PinSave>().pin.value = '';
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: IconSizes.backArrowSize,
            ),
          ),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Realized Gain/Loss",
            style: TextStyle(
              fontSize: FontSizes.size16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3.h, left: 5.w),
                  height: 45.h,
                  width: 0.88.sw,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Pin.show(
                    onSelect: () async {
                      sendDatemsg =
                          '$valuesTahun${selectedMonth.toString().length == 1 ? '0$selectedMonth' : selectedMonth}';
                      await Future.delayed(
                        const Duration(milliseconds: 51),
                        () => OrderMassage.reqRealizedGainLost(
                          Get.find<PinSave>().pin.value,
                          sendDatemsg,
                          accountId.value == ""
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId
                                  .toString()
                              : accountId.value,
                        ),
                      );
                    },
                    onComplete: (text) async {
                      Get.find<PinSave>().pin.value = text;
                      String bulan = selectedMonth.value.toString();
                      if (bulan.length < 2) {
                        bulan = '0$bulan';
                      }
                      sendDatemsg = "$valuesTahun$bulan";

                      await OrderMassage.reqRealizedGainLost(
                        text,
                        sendDatemsg,
                        accountId.value == ""
                            ? Get.find<LoginOrderController>()
                                .order!
                                .value
                                .account!
                                .first
                                .accountId
                                .toString()
                            : accountId.value,
                      );
                      fokusNode.unfocus();
                    },
                    paddingcustom: EdgeInsets.zero,
                    color: bgabu,
                    border: Border.all(
                      width: 0,
                    ),
                    decoration1: BoxDecoration(
                      color: bgabu,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    decoration2: BoxDecoration(
                      color: bgabu,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fontstyleNameaccount: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    fokusNode = FocusNode();
                    listRealizedGainlos.clear();
                    Get.find<PinSave>().pin.value = '';
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: RealizedGainLossMain(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: FittedBox(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, top: 7.h),
              width: 1.sw,
              height: 60.h,
              decoration: BoxDecoration(
                color: bgabu,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PopupMenuButton<int>(
                        offset: Offset(35.w, 0),
                        position: PopupMenuPosition.under,
                        color: foregroundwidget,
                        constraints: BoxConstraints.tightFor(
                          height: 150.h,
                          width: 0.205.sw,
                        ),
                        itemBuilder: (BuildContext context) {
                          return years.map((int year) {
                            return PopupMenuItem<int>(
                              padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                              height: 20.h,
                              value: year,
                              child: Container(
                                alignment: Alignment.center,
                                color: valuesTahun.value == year
                                    ? foregroundwidget2
                                    : foregroundwidget,
                                child: Text(
                                  year.toString(),
                                  style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        onSelected: (int selectedYear) async {
                          valuesTahun.value = selectedYear;
                          valuesTahun.refresh();
                          if (listRealizedGainlos.isEmpty) {
                            NotifikasiPopup.show("Please insert PIN");
                          } else {
                            String bulan = selectedMonth.value.toString();
                            if (bulan.length < 2) {
                              bulan = '0$bulan';
                            }
                            sendDatemsg = "$valuesTahun$bulan";
                            await OrderMassage.reqRealizedGainLost(
                              Get.find<PinSave>().pin.value,
                              sendDatemsg,
                              accountId.value == ""
                                  ? Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .account!
                                      .first
                                      .accountId
                                      .toString()
                                  : accountId.value,
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Year",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 13.sp),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              height: 22.h,
                              width: 0.15.sw,
                              decoration: BoxDecoration(
                                color: putihop85,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.r),
                                  bottomLeft: Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Obx(() {
                                    return Text(
                                      valuesTahun.value.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: FontSizes.size13,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Container(
                              height: 22.h,
                              width: 0.055.sw,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(3.r),
                                  bottomRight: Radius.circular(3.r),
                                ),
                              ),
                              child: const FittedBox(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      PopupMenuButton(
                        offset: Offset(0.w, 0.w),
                        position: PopupMenuPosition.under,
                        color: foregroundwidget,
                        constraints: BoxConstraints.tightFor(
                          height: 150.h,
                          width: 0.205.sw,
                        ),
                        itemBuilder: (BuildContext context) {
                          return months.map((int value) {
                            return PopupMenuItem<int>(
                              height: 20.h,
                              value: value,
                              padding: EdgeInsets.only(bottom: 3.h),
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedMonth.value == value
                                    ? foregroundwidget2
                                    : foregroundwidget,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        onSelected: (value) async {
                          selectedMonth.value = value;
                          selectedMonth.refresh();
                          if (listRealizedGainlos.isEmpty) {
                            NotifikasiPopup.show("Please insert PIN");
                          } else {
                            String bulan = selectedMonth.value.toString();
                            if (bulan.length < 2) {
                              bulan = '0$bulan';
                            }
                            sendDatemsg = "$valuesTahun$bulan";

                            await OrderMassage.reqRealizedGainLost(
                                Get.find<PinSave>().pin.value.toString(),
                                sendDatemsg,
                                Get.find<PinSave>().pin.value);
                          }
                        },
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Month",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              height: 22.h,
                              width: 0.15.sw,
                              decoration: BoxDecoration(
                                color: putihop85,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.r),
                                  bottomLeft: Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Obx(() {
                                    return Text(
                                      selectedMonth.value.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: FontSizes.size13,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Container(
                              height: 22.h,
                              width: 0.055.sw,
                              decoration: BoxDecoration(
                                color: foregroundwidget,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(3.r),
                                  bottomRight: Radius.circular(3.r),
                                ),
                              ),
                              child: const FittedBox(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.w,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Obx(() {
                        return Text(
                          "Total : ${listRealizedGainlos.isEmpty ? 0 : listRealizedGainlos.first.array!.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size13,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (listRealizedGainlos.isEmpty) {
                return Container();
              } else {
                return Expanded(
                  child: HorizontalDataTable(
                    elevation: 0,
                    rowSeparatorWidget: Divider(
                      height: 2.h,
                      thickness: 0.05,
                    ),
                    leftHandSideColumnWidth: 0.25.sw,
                    rightHandSideColumnWidth: 1.05.sw,
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
                        child: Text(
                          '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                        child: Text(
                          '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget,
                        child: Text(
                          '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.3.sw,
                        color: foregroundwidget,
                        child: Text(
                          listRealizedGainlos.isEmpty ? '' : '',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ],
                    leftSideItemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: 0.25.sw,
                              height: 20.h,
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "  ${listRealizedGainlos.first.array![index].stockCode}",
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
                                    child: !delistingStock(listRealizedGainlos
                                            .first.array![index].stockCode!)
                                        ? null
                                        : getSpesialNotifier(listRealizedGainlos
                                                    .first
                                                    .array![index]
                                                    .stockCode!)
                                                .isEmpty
                                            ? null
                                            : GestureDetector(
                                                onTap: () {
                                                  NotifikasiPopup.showINFO(
                                                      text:
                                                          '${specialNotations(getSpesialNotifier(listRealizedGainlos.first.array![index].stockCode!))}');
                                                },
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.blue,
                                                  size: 15.sp,
                                                ),
                                              ),
                                  )
                                ],
                              )),
                        ],
                      );
                    },
                    rightSideItemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 0.25.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(formatIndex4k(listRealizedGainlos
                                      .first.array![index].avgPrice!
                                      .toDouble())
                                  .toInt()),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                              formattaCurrun(listRealizedGainlos
                                  .first.array![index].price!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                              formattaCurrun(listRealizedGainlos
                                  .first.array![index].volume!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 5.w),
                            alignment: Alignment.centerRight,
                            width: 0.3.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(listRealizedGainlos
                                  .first.array![index].gainLossSign!),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: listRealizedGainlos.first.array![index]
                                              .gainLossSign ==
                                          0
                                      ? putihop85
                                      : listRealizedGainlos.first.array![index]
                                                  .gainLossSign! <
                                              0
                                          ? Colors.red
                                          : Colors.green,
                                  fontSize: 11.sp),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: listRealizedGainlos.first.array!.length,
                    rightHandSideColBackgroundColor: Colors.black,
                  ),
                );
              }
            })
          ],
        ),
      ),
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
        'Avg',
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
        'Price',
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
        'Vol',
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
  ];
}

final List<int> months = List.generate(12, (int index) => index + 1);
List<int> years = List.generate(20, (int index) => DateTime.now().year - index);
