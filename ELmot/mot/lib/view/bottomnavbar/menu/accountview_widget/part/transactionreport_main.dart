// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/info/transaction_report.model.dart';
import 'package:online_trading/module/ordering/pkg/info/transactionreport.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/helper/getSpesialnotifier.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'package:page_transition/page_transition.dart';

import '../../tradeviewdetail/tradewidget/candle/candle.dart';

class TransactionReportMain extends StatelessWidget {
  TransactionReportMain({super.key});
  RxString account = ''.obs;
  RxString availableTahun = ''.obs;
  @override
  Widget build(BuildContext context) {
    Get.put(Send1DataController());
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
            "Transaction Report",
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
                    onSelect: () => Future.delayed(
                      const Duration(milliseconds: 51),
                      () => OrderMassage.reqTransactionReport(
                        Get.find<PinSave>().pin.value,
                        availableTahun.value,
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
                    ),
                    onComplete: (text) async {
                      Get.find<PinSave>().pin.value = text;
                      await OrderMassage.reqTransactionReport(
                          text,
                          availableTahun.value,
                          accountId.value == ""
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId
                                  .toString()
                              : accountId.value);
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
                    listTransactionreportBYYEAR.clear();
                    listTransactionreportRemainyear.clear();
                    Get.find<PinSave>().pin.value = '';
                    fokusNode = FocusNode();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: TransactionReportMain(),
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
              height: 30.h,
              decoration: BoxDecoration(
                color: bgabu,
              ),
              child: Row(
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
                        width: 0.205.sw,
                      ),
                      itemBuilder: (BuildContext context) {
                        if (listTransactionreportRemainyear.isEmpty) return [];
                        List<String> availableYears =
                            listTransactionreportRemainyear
                                .expand((listTransactionreportRemainyear) =>
                                    listTransactionreportRemainyear.array!)
                                .map((e) => e.remainYear.toString())
                                .toSet()
                                .toList();

                        return availableYears.map((year) {
                          return PopupMenuItem(
                            padding: EdgeInsets.only(bottom: 3.h),
                            height: 20.h,
                            value: year,
                            child: Container(
                              alignment: Alignment.center,
                              color: availableTahun.value == year
                                  ? foregroundwidget2
                                  : foregroundwidget,
                              child: Text(
                                year,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: FontSizes.size12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList();
                      },
                      onSelected: (value) async {
                        availableTahun.value = value.toString();
                        availableTahun.refresh();

                        await OrderMassage.reqTransactionReport(
                          Get.find<PinSave>().pin.value,
                          availableTahun.value,
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
                      },
                      child: Wrap(
                        children: [
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
                                    listTransactionreportRemainyear.isEmpty
                                        ? ''
                                        : availableTahun.value.isEmpty
                                            ? listTransactionreportRemainyear
                                                .first.array!.first.remainYear
                                                .toString()
                                            : availableTahun.value.toString(),
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
                      ))
                ],
              ),
            ),
            Obx(() {
              if (listTransactionreportBYYEAR.isEmpty) {
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
                  rightHandSideColumnWidth: 3.78.sw,
                  isFixedHeader: true,
                  isFixedFooter: true,
                  footerWidgets: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.1.sw,
                          color: foregroundwidget,
                          child: Text(
                            'Total',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 12.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.3.sw,
                          color: foregroundwidget,
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      width: 0.13.sw,
                      color: foregroundwidget,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      width: 0.1.sw,
                      color: foregroundwidget,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      width: 0.3.sw,
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
                      width: 0.3.sw,
                      color: foregroundwidget,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.4.sw,
                      color: foregroundwidget,
                      child: Text(
                        formattaCurrun(listTransactionreportBYYEAR
                            .first.totalGrossAmount!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.3.sw,
                      color: foregroundwidget,
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalBrokerFee!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.3.sw,
                      color: foregroundwidget,
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalLevy!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.3.sw,
                      color: foregroundwidget,
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalWht!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.3.sw,
                      color: foregroundwidget,
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalVAT!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.3.sw,
                      color: foregroundwidget,
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalSalesTax!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.4.sw,
                      color: foregroundwidget,
                      padding: EdgeInsets.only(right: 5.w),
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalFees!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.4.sw,
                      color: foregroundwidget,
                      padding: EdgeInsets.only(right: 5.w),
                      child: Text(
                        formattaCurrun(
                            listTransactionreportBYYEAR.first.totalNetAmount!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ),
                  ],
                  headerWidgets: _getHeaderWidget(),
                  leftHandSideColBackgroundColor: Colors.black,
                  itemCount: listTransactionreportBYYEAR
                      .first.arrayTransReport!.length,
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
                                listTransactionreportBYYEAR.isEmpty
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
                                listTransactionreportBYYEAR.isEmpty
                                    ? ""
                                    : dateAja(listTransactionreportBYYEAR
                                        .first.arrayTransReport![index].date),
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
                  rightHandSideColBackgroundColor: Colors.black,
                  rightSideItemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.13.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                listTransactionreportBYYEAR
                                            .first
                                            .arrayTransReport![index]
                                            .command! ==
                                        0
                                    ? 'Buy'
                                    : 'Sell',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: listTransactionreportBYYEAR
                                                .first
                                                .arrayTransReport![index]
                                                .command! ==
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
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.1.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].board
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "  ${listTransactionreportBYYEAR.first.arrayTransReport![index].productStockCode}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size11,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10.w),
                                alignment: Alignment.centerRight,
                                width: 0.05.sw,
                                child: !delistingStock(
                                        listTransactionreportBYYEAR
                                            .first
                                            .arrayTransReport![index]
                                            .productStockCode!)
                                    ? null
                                    : getSpesialNotifier(
                                                listTransactionreportBYYEAR
                                                    .first
                                                    .arrayTransReport![index]
                                                    .productStockCode!)
                                            .isEmpty
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              NotifikasiPopup.showINFO(
                                                  text:
                                                      '${specialNotations(getSpesialNotifier(listTransactionreportBYYEAR.first.arrayTransReport![index].productStockCode!))}');
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
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].price!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].qty!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.4.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR.first
                                    .arrayTransReport![index].grossAmount!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].brokerFee!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].levy!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].wht!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].vat!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.3.sw,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].salesTax!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.4.sw,
                          color: Colors.black,
                          padding: EdgeInsets.only(right: 5.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR.first
                                    .arrayTransReport![index].subTotalFees!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 20.h,
                          width: 0.4.sw,
                          color: Colors.black,
                          padding: EdgeInsets.only(right: 5.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formattaCurrun(listTransactionreportBYYEAR
                                    .first.arrayTransReport![index].netAmount!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: FontSizes.size11,
                                    fontWeight: FontWeight.bold),
                              ),
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

class Send1DataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    ever(
      listTransactionreportRemainyear,
      (callback) => sendFirstrowData(callback),
    );
  }

  void sendFirstrowData(List<TransactionReportModelRemainYear> data) async {
    if (listTransactionreportRemainyear.isNotEmpty) {
      await OrderMassage.reqTransactionReport(
          Get.find<PinSave>().pin.value,
          data.first.array!.first.remainYear!.toString(),
          accountId.value == ""
              ? Get.find<LoginOrderController>()
                  .order!
                  .value
                  .account!
                  .first
                  .accountId
                  .toString()
              : accountId.value);
    } else {}
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
      width: 0.13.sw,
      color: foregroundwidget,
      child: Text(
        'Type',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.1.sw,
      color: foregroundwidget,
      child: Text(
        'Board',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Stock',
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
        'Price',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Qty',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.4.sw,
      color: foregroundwidget,
      child: Text(
        'Gross Ammount',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Broker Fee',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Levy',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'WHT',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'VAT',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Sales Tax',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.4.sw,
      color: foregroundwidget,
      child: Text(
        'Subtotal Fees',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.4.sw,
      color: foregroundwidget,
      child: Text(
        'Net Ammount',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}
