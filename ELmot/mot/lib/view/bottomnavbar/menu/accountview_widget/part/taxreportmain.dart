// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/info/tax_report.model.dart';
import 'package:online_trading/module/ordering/pkg/info/tax_report.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/helper/getSpesialnotifier.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pdf/model/tablePDF.model.dart';
import 'package:online_trading/view/widget/pdf/pdf.main.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:online_trading/view/widget/pdf/windget/createPDF.winget.part.dart';
import 'package:online_trading/view/widget/pdf/windget/widgetPDF.widget.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:page_transition/page_transition.dart';

class TaxReportWidget extends StatelessWidget {
  TaxReportWidget({super.key});
  RxString account = ''.obs;
  RxString availableTahun = ''.obs;

  @override
  Widget build(BuildContext context) {
    !Get.isRegistered<SendFirstdataController>()
        ? Get.put(SendFirstdataController())
        : Get.find<SendFirstdataController>();

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
              "Tax Report",
              style: TextStyle(
                fontSize: FontSizes.size16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
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
                      () => OrderMassage.taxReport(
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
                      await OrderMassage.taxReport(
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
                    Get.find<PinSave>().pin.value = '';
                    fokusNode = FocusNode();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: TaxReportWidget(),
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
                      if (listTaxReport.isEmpty) return [];
                      List<String> availableYears = listTaxReport
                          .expand((taxReport) => taxReport.taxReportArrayy!)
                          .map((e) => e.taxReportYearlist.toString())
                          .toSet()
                          .toList();

                      return availableYears.map((year) {
                        return PopupMenuItem(
                          height: 30.h,
                          value: year,
                          padding: EdgeInsets.only(bottom: 3.h),
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

                      await OrderMassage.taxReport(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  listTaxReport.isEmpty
                                      ? ''
                                      : availableTahun.value.isEmpty
                                          ? listTaxReport.first.taxReportArrayy!
                                              .first.taxReportYearlist
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
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    if (listtaxreportBYYEAR.isEmpty) {
                      return Container();
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          File file = await CreatePdf.generate(
                              header: WigetPdf.header(
                                  title:
                                      "TAX-REPORT - ${accountName.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountName : accountName.value}  - ${availableTahun.value == '' ? listtaxreportBYYEAR.first.taxReportYear : availableTahun.value} "),
                              body: [
                                WigetPdf.table(
                                  header: [
                                    TableModelHederPDF(
                                      label: p.Text('No.',
                                          style: p.TextStyle(
                                              fontSize: 15.sp,
                                              color: PdfColors.white)),
                                    ),
                                    TableModelHederPDF(
                                      label: p.Text('Date',
                                          style: p.TextStyle(
                                              fontSize: 15.sp,
                                              color: PdfColors.white)),
                                    ),
                                    TableModelHederPDF(
                                      label: p.Text('Board',
                                          style: p.TextStyle(
                                              fontSize: 15.sp,
                                              color: PdfColors.white)),
                                    ),
                                    TableModelHederPDF(
                                      label: p.Text('Stock',
                                          style: p.TextStyle(
                                              fontSize: 15.sp,
                                              color: PdfColors.white)),
                                    ),
                                    TableModelHederPDF(
                                      label: p.Text('Price',
                                          style: p.TextStyle(
                                              fontSize: 15.sp,
                                              color: PdfColors.white)),
                                    ),
                                    TableModelHederPDF(
                                      label: p.Text('Qty',
                                          style: p.TextStyle(
                                              fontSize: 15.sp,
                                              color: PdfColors.white)),
                                    ),
                                  ],
                                ),
                              ],
                              nameFile:
                                  'TAX-REPORT-$accountName - $availableTahun.pdf');
                          Get.to(PdfMainPage(path: file));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              color: Colors.blue,
                              size: 17.sp,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                " Save ",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
            Obx(() {
              if (listtaxreportBYYEAR.isEmpty) {
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
                    rightHandSideColumnWidth: 3.25.sw,
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
                          formattaCurrun(
                              listtaxreportBYYEAR.first.totalGrossAmount!),
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
                              listtaxreportBYYEAR.first.totalBrokerFee!),
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
                          formattaCurrun(listtaxreportBYYEAR.first.totalLevy!),
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
                          formattaCurrun(listtaxreportBYYEAR.first.totalWht!),
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
                          formattaCurrun(listtaxreportBYYEAR.first.totalVAT!),
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
                              listtaxreportBYYEAR.first.totalSalesTax!),
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
                              listtaxreportBYYEAR.first.totalNetAmount!),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        ),
                      ),
                    ],
                    headerWidgets: _getHeaderWidget(),
                    leftHandSideColBackgroundColor: Colors.black,
                    itemCount:
                        listtaxreportBYYEAR.first.taxReportArrayybyyear!.length,
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
                                  listtaxreportBYYEAR.isEmpty
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
                                  listtaxreportBYYEAR.isEmpty
                                      ? ""
                                      : dateAja(listtaxreportBYYEAR.first
                                          .taxReportArrayybyyear![index].date),
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
                            width: 0.1.sw,
                            color: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  listtaxreportBYYEAR
                                      .first.taxReportArrayybyyear![index].board
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
                                    "  ${listtaxreportBYYEAR.first.taxReportArrayybyyear![index].productStockCode}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: putihop85,
                                        fontSize: FontSizes.size11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 0.05.sw,
                                  child: !delistingStock(listtaxreportBYYEAR
                                          .first
                                          .taxReportArrayybyyear![index]
                                          .productStockCode!)
                                      ? null
                                      : getSpesialNotifier(listtaxreportBYYEAR
                                                  .first
                                                  .taxReportArrayybyyear![index]
                                                  .productStockCode!)
                                              .isEmpty
                                          ? null
                                          : GestureDetector(
                                              onTap: () {
                                                NotifikasiPopup.showINFO(
                                                    text:
                                                        '${specialNotations(getSpesialNotifier(listtaxreportBYYEAR.first.taxReportArrayybyyear![index].productStockCode!))}');
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
                                  formattaCurrun(listtaxreportBYYEAR.first
                                      .taxReportArrayybyyear![index].price!),
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
                                  formattaCurrun(listtaxreportBYYEAR.first
                                      .taxReportArrayybyyear![index].qty!),
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
                                  formattaCurrun(listtaxreportBYYEAR
                                      .first
                                      .taxReportArrayybyyear![index]
                                      .grossAmount!),
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
                                  formattaCurrun(listtaxreportBYYEAR
                                      .first
                                      .taxReportArrayybyyear![index]
                                      .brokerFee!),
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
                                  formattaCurrun(listtaxreportBYYEAR.first
                                      .taxReportArrayybyyear![index].levy!),
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
                                  formattaCurrun(listtaxreportBYYEAR.first
                                      .taxReportArrayybyyear![index].wht!),
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
                                  formattaCurrun(listtaxreportBYYEAR.first
                                      .taxReportArrayybyyear![index].vat!),
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
                                  formattaCurrun(listtaxreportBYYEAR.first
                                      .taxReportArrayybyyear![index].salesTax!),
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
                                  formattaCurrun(listtaxreportBYYEAR
                                      .first
                                      .taxReportArrayybyyear![index]
                                      .netAmount!),
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

class SendFirstdataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    ever(
      listTaxReport,
      (callback) => sendFirstrowData(callback),
    );
  }

  void sendFirstrowData(List<TaxReportData> data) async {
    if (listTaxReport.isNotEmpty) {
      await OrderMassage.taxReport(
        Get.find<PinSave>().pin.value,
        data.first.taxReportArrayy!.first.taxReportYearlist!.toString(),
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
        'Vol',
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
        'Net Ammount',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}
