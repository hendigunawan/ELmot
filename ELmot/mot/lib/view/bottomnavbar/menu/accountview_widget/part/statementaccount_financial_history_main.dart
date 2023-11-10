// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/financial_history.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:page_transition/page_transition.dart';

class FinancialHistoryMain extends StatelessWidget {
  FinancialHistoryMain({super.key});
  RxString account = ''.obs;
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
            "Statement of Account",
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
                        () => OrderMassage.reqFinancialHistory(
                          Get.find<PinSave>().pin.value,
                          accountId.value == ""
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId
                                  .toString()
                              : accountId.value,
                          sendDatemsg,
                        ),
                      );
                    },
                    onComplete: (text) async {
                      Get.find<PinSave>().pin.value = text;
                      sendDatemsg =
                          '$valuesTahun${selectedMonth.toString().length == 1 ? '0$selectedMonth' : selectedMonth}';
                      Get.find<PinSave>().pin.value = text;
                      await OrderMassage.reqFinancialHistory(
                        text,
                        accountId.value == ""
                            ? Get.find<LoginOrderController>()
                                .order!
                                .value
                                .account!
                                .first
                                .accountId
                                .toString()
                            : accountId.value,
                        sendDatemsg,
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
                    Get.find<PinSave>().pin.value = '';
                    fokusNode = FocusNode();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: FinancialHistoryMain(),
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
                          if (listFinancialHistory.isEmpty) {
                            NotifikasiPopup.showWarning("Please insert PIN");
                          } else {
                            String bulan = selectedMonth.value.toString();
                            if (bulan.length < 2) {
                              bulan = '0$bulan';
                            }
                            sendDatemsg = "$valuesTahun$bulan";
                            await OrderMassage.reqFinancialHistory(
                              Get.find<PinSave>().pin.value,
                              accountId.value == ""
                                  ? Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .account!
                                      .first
                                      .accountId
                                      .toString()
                                  : accountId.value,
                              sendDatemsg,
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
                        offset: const Offset(0, 0),
                        position: PopupMenuPosition.under,
                        color: foregroundwidget,
                        constraints: BoxConstraints.tightFor(
                          height: 150.h,
                          width: 0.205.sw,
                        ),
                        itemBuilder: (BuildContext context) {
                          return months.map((int value) {
                            return PopupMenuItem<int>(
                              padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                              height: 20.h,
                              value: value,
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

                          if (listFinancialHistory.isEmpty) {
                            NotifikasiPopup.showWarning("Please insert PIN");
                          } else {
                            String bulan = selectedMonth.value.toString();
                            if (bulan.length < 2) {
                              bulan = '0$bulan';
                            }
                            sendDatemsg = "$valuesTahun$bulan";
                            await OrderMassage.reqFinancialHistory(
                              Get.find<PinSave>().pin.value,
                              accountId.value == ""
                                  ? Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .account!
                                      .first
                                      .accountId
                                      .toString()
                                  : accountId.value,
                              sendDatemsg,
                            );
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
                          "Total : ${listFinancialHistory.isEmpty ? 0 : listFinancialHistory.first.array!.length}",
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
              if (listFinancialHistory.isEmpty) {
                return Container();
              } else {
                return Expanded(
                    child: HorizontalDataTable(
                  elevation: 0,
                  rowSeparatorWidget: Divider(
                    height: 2.h,
                    thickness: 0.05,
                  ),
                  leftHandSideColumnWidth: 0.4.sw,
                  rightHandSideColumnWidth: 1.1.sw,
                  isFixedHeader: true,
                  headerWidgets: _getHeaderWidget(),
                  leftHandSideColBackgroundColor: Colors.black,
                  rightHandSideColBackgroundColor: Colors.black,
                  itemCount: listFinancialHistory.first.array!.length,
                  leftSideItemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.1.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                listFinancialHistory.isEmpty
                                    ? ""
                                    : ("${index + 1}"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: FontSizes.size11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                listFinancialHistory.isEmpty
                                    ? ""
                                    : dateAja(listFinancialHistory
                                        .first.array![index].transactionDate),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: FontSizes.size11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  rightSideItemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.25.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listFinancialHistory
                                    .first.array![index].debit!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: listFinancialHistory
                                                .first.array![index].debit ==
                                            0
                                        ? putihop85
                                        : listFinancialHistory.first
                                                    .array![index].debit! <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.25.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listFinancialHistory
                                    .first.array![index].credit!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: listFinancialHistory
                                                .first.array![index].credit ==
                                            0
                                        ? putihop85
                                        : listFinancialHistory.first
                                                    .array![index].credit! <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.25.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listFinancialHistory
                                    .first.array![index].balance!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: listFinancialHistory
                                                .first.array![index].balance ==
                                            0
                                        ? putihop85
                                        : listFinancialHistory.first
                                                    .array![index].balance! <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 20.h,
                          width: 0.35.sw,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 0.28.sw,
                                child: Text(
                                  "  ${listFinancialHistory.first.array![index].descriptions!}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size11,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  NotifikasiPopup.showINFO(
                                    text:
                                        "${listFinancialHistory.first.array![index].descriptions}",
                                  );
                                },
                                child: FittedBox(
                                  child: SizedBox(
                                    width: 0.05.sw,
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.blue,
                                      size: 13.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ));
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
          width: 0.1.sw,
          color: foregroundwidget,
          child: Text(
            'No.',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 20.h,
          width: 0.3.sw,
          color: foregroundwidget,
          child: Text(
            'Date',
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
      color: foregroundwidget,
      child: Text(
        'Debit',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget,
      child: Text(
        'Credit',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget,
      child: Text(
        'Balance',
        style: TextStyle(
          color: Colors.white.withOpacity(0.85),
          fontSize: 12.sp,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.35.sw,
      color: foregroundwidget,
      child: Text(
        'Descriptions',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}

final List<int> months = List.generate(12, (int index) => index + 1);
List<int> years = List.generate(30, (int index) => DateTime.now().year - index);
