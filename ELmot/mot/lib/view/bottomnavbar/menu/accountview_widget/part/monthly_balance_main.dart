import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/monthly_balance.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/helper/getSpesialnotifier.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'package:page_transition/page_transition.dart';

class MonthlyBalanceMain extends StatelessWidget {
  const MonthlyBalanceMain({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MonyhlyBalanceController());
    controller;
    return WillPopScope(
      onWillPop: () async {
        controller.setToDefault();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              controller.setToDefault();
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
            "Monthly Balance",
            style: TextStyle(
              fontSize: 16.sp,
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
                      listmonthlybalanceBYYEAR.clear();
                      listmonthlybalanceREMAINYEAR.clear();
                      controller.selectedYear.value = '';
                      await Future.delayed(
                        const Duration(milliseconds: 51),
                        () => OrderMassage.reqMonthlyBalance(
                            pin: Get.find<PinSave>().pin.value,
                            accountId: accountId.value == ""
                                ? Get.find<LoginOrderController>()
                                    .order!
                                    .value
                                    .account!
                                    .first
                                    .accountId
                                    .toString()
                                : accountId.value,
                            tahun: controller.selectedYear.value),
                      );
                    },
                    onComplete: (text) async {
                      Get.find<PinSave>().pin.value = text;
                      await OrderMassage.reqMonthlyBalance(
                          pin: text,
                          accountId: accountId.value == ""
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId
                                  .toString()
                              : accountId.value,
                          tahun: controller.selectedYear.value);
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
                    controller.setToDefault();
                    fokusNode = FocusNode();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: const MonthlyBalanceMain(),
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
              padding: EdgeInsets.only(left: 5.w),
              alignment: Alignment.center,
              width: 1.sw,
              height: 60.h,
              decoration: BoxDecoration(
                color: bgabu,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Available Year",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      PopupMenuButton(
                        position: PopupMenuPosition.under,
                        color: foregroundwidget,
                        constraints: BoxConstraints.tightFor(
                          height: 150.h,
                          width: 0.235.sw,
                        ),
                        itemBuilder: (BuildContext context) {
                          if (listmonthlybalanceREMAINYEAR.isEmpty) return [];
                          List<String> availableYears =
                              listmonthlybalanceREMAINYEAR
                                  .expand((data) => data.array!)
                                  .map((e) => e.remainyearData.toString())
                                  .toSet()
                                  .toList();

                          return availableYears.map((year) {
                            return PopupMenuItem(
                              height: 22.h,
                              value: year,
                              padding: EdgeInsets.only(bottom: 3.h),
                              child: Container(
                                alignment: Alignment.center,
                                color: controller.selectedYear.value == year
                                    ? foregroundwidget2
                                    : foregroundwidget,
                                child: Text(
                                  controller.formatDate(year),
                                  style: TextStyle(
                                    color: putihop85,
                                    fontSize: 12.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        onSelected: (value) async {
                          controller.selectedYear.value = value.toString();
                          await OrderMassage.reqMonthlyBalance(
                              pin: Get.find<PinSave>().pin.value,
                              accountId: accountId.value == ""
                                  ? Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .account!
                                      .first
                                      .accountId
                                      .toString()
                                  : accountId.value,
                              tahun: controller.selectedYear.value);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 22.h,
                              width: 0.18.sw,
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
                                        controller.selectedYear.value == ''
                                            ? ''
                                            : controller.formatDate(
                                                controller.selectedYear.value),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                        ),
                                      );
                                    })),
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
                  Container(
                    alignment: Alignment.center,
                    width: 1.sw,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: bgabu,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cash Info",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 13.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (listmonthlybalanceBYYEAR.isEmpty) {
                return Center(
                  child: Text(
                    " - ",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 0.332.sw,
                          height: 25.h,
                          decoration: BoxDecoration(color: foregroundwidget),
                          child: Center(
                            child: Text(
                              "Total Cash",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Container(
                          width: 0.332.sw,
                          height: 25.h,
                          decoration: BoxDecoration(color: foregroundwidget),
                          child: Center(
                            child: Text(
                              "Market Val",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Container(
                          width: 0.332.sw,
                          height: 25.h,
                          decoration: BoxDecoration(color: foregroundwidget),
                          child: Center(
                            child: Text(
                              "Total Asset",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: 0.332.sw,
                          height: 25.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            formattaCurrun(
                                listmonthlybalanceBYYEAR.first.totalCash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 0.332.sw,
                          height: 25.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            formattaCurrun(listmonthlybalanceBYYEAR
                                .first.totalMarketValue!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 3.w),
                          alignment: Alignment.centerRight,
                          width: 0.332.sw,
                          height: 25.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            formattaCurrun(
                                listmonthlybalanceBYYEAR.first.totalAsset!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              alignment: Alignment.center,
              width: 1.sw,
              height: 30.h,
              decoration: BoxDecoration(
                color: bgabu,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Stock Info",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
                ),
              ),
            ),
            Obx(() {
              if (listmonthlybalanceBYYEAR.isEmpty) {
                return Center(
                  child: Text(
                    " - ",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                );
              } else {
                return Expanded(
                    child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: HorizontalDataTable(
                    isFixedHeader: true,
                    isFixedFooter: true,
                    itemCount: listmonthlybalanceBYYEAR.first.array!.length,
                    elevation: 0,
                    rowSeparatorWidget: Divider(
                      height: 2.h,
                      thickness: 0.05,
                    ),
                    leftHandSideColumnWidth: 0.25.sw,
                    rightHandSideColumnWidth: 1.8.sw,
                    leftHandSideColBackgroundColor: Colors.black,
                    rightHandSideColBackgroundColor: Colors.black,
                    headerWidgets: _getHeaderWidget(),
                    footerWidgets: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 20.h,
                            width: 0.25.sw,
                            color: foregroundwidget.withOpacity(0.9),
                            child: Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.2.sw,
                        color: foregroundwidget.withOpacity(0.9),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget.withOpacity(0.9),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 0.25.sw,
                        color: foregroundwidget.withOpacity(0.9),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.4.sw,
                        color: foregroundwidget.withOpacity(0.9),
                        child: Text(
                          listmonthlybalanceBYYEAR.isEmpty
                              ? ''
                              : formattaCurrun(listmonthlybalanceBYYEAR
                                  .first.totalMarketValue!),
                          style: TextStyle(
                              color: listmonthlybalanceBYYEAR.isEmpty
                                  ? Colors.white.withOpacity(0.85)
                                  : listmonthlybalanceBYYEAR
                                              .first.totalMarketValue!
                                              .toInt() >
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.3.sw,
                        color: foregroundwidget.withOpacity(0.9),
                        child: Text(
                          listmonthlybalanceBYYEAR.isEmpty
                              ? ''
                              : formattaCurrun(listmonthlybalanceBYYEAR
                                  .first.totalPotentialGainLoss!),
                          style: TextStyle(
                              color: listmonthlybalanceBYYEAR.isEmpty
                                  ? Colors.white.withOpacity(0.85)
                                  : listmonthlybalanceBYYEAR
                                              .first.totalPotentialGainLoss!
                                              .toInt() >
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 4.w),
                        alignment: Alignment.centerRight,
                        height: 20.h,
                        width: 0.4.sw,
                        color: foregroundwidget.withOpacity(0.9),
                        child: Text(
                          listmonthlybalanceBYYEAR.isEmpty
                              ? ''
                              : formatIndex2k(listmonthlybalanceBYYEAR
                                      .first.totalPotentialGainLossPercentage!
                                      .toDouble())
                                  .toString(),
                          style: TextStyle(
                              color: listmonthlybalanceBYYEAR.isEmpty
                                  ? Colors.white.withOpacity(0.85)
                                  : listmonthlybalanceBYYEAR.first
                                              .totalPotentialGainLossPercentage!
                                              .toInt() >
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 12.sp),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    "  ${listmonthlybalanceBYYEAR.first.array![index].stockcode}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 11.sp),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  alignment: Alignment.centerRight,
                                  width: 0.05.sw,
                                  child: !delistingStock(
                                          listmonthlybalanceBYYEAR
                                              .first.array![index].stockcode!)
                                      ? null
                                      : getSpesialNotifier(
                                                  listmonthlybalanceBYYEAR.first
                                                      .array![index].stockcode!)
                                              .isEmpty
                                          ? null
                                          : GestureDetector(
                                              onTap: () {
                                                NotifikasiPopup.showINFO(
                                                    text:
                                                        '${specialNotations(getSpesialNotifier(listmonthlybalanceBYYEAR.first.array![index].stockcode!))}');
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
                      var data = listmonthlybalanceBYYEAR.first.array;
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.2.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data![index].avgPrice!),
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
                              formattaCurrun(data[index].closePrice!),
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
                              formattaCurrunAverage(data[index].balanceQty!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 0.4.sw,
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
                            width: 0.3.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formattaCurrun(data[index].potentialGainLoss!),
                              maxLines: 1,
                              style: TextStyle(
                                  color: data[index].potentialGainLoss == 0
                                      ? Colors.white
                                      : data[index].potentialGainLoss! > 0
                                          ? Colors.green
                                          : Colors.red,
                                  fontSize: 11.sp),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 4.w),
                            alignment: Alignment.centerRight,
                            width: 0.4.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formatIndex2k(data[index]
                                      .potentialGainLossPercentage!
                                      .toDouble())
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  color: data[index]
                                              .potentialGainLossPercentage ==
                                          0
                                      ? Colors.white
                                      : data[index]
                                                  .potentialGainLossPercentage! >
                                              0
                                          ? Colors.green
                                          : Colors.red,
                                  fontSize: 11.sp),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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
      width: 0.2.sw,
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
        'Close',
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
        'Balance Qty',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.4.sw,
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
      width: 0.4.sw,
      color: foregroundwidget.withOpacity(0.9),
      child: Text(
        'G/L(%)',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}

class MonyhlyBalanceController extends GetxController {
  RxString selectedYear = ''.obs;
  @override
  void onInit() {
    super.onInit();
    ever(listmonthlybalanceREMAINYEAR, (callback) => sendFirstDate());
  }

  void sendFirstDate() async {
    if (listmonthlybalanceREMAINYEAR.isEmpty) {
    } else {
      if (listmonthlybalanceREMAINYEAR.isNotEmpty ||
          listmonthlybalanceREMAINYEAR.first.array!.isNotEmpty) {
        await OrderMassage.reqMonthlyBalance(
          pin: Get.find<PinSave>().pin.value,
          accountId: Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId!,
          tahun: listmonthlybalanceREMAINYEAR.first.array!.first.remainyearData
              .toString(),
        );
        selectedYear.value = listmonthlybalanceREMAINYEAR
            .first.array!.first.remainyearData
            .toString();
      }
    }
  }

  void setToDefault() {
    listmonthlybalanceBYYEAR.clear();
    listmonthlybalanceREMAINYEAR.clear();
    Get.find<PinSave>().pin.value = '';
    selectedYear.value = '';
  }

  String formatDate(String data) {
    String year = data.substring(0, 4);
    String month = data.substring(4, 6);
    data = '$year/$month';
    return data;
  }
}
