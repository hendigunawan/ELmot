// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/info/trade_confirmation.model.dart';
import 'package:online_trading/module/ordering/pkg/info/tradeconfirmation.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/helper/getSpesialnotifier.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'package:page_transition/page_transition.dart';

class TradeConfirmationMain extends StatelessWidget {
  TradeConfirmationMain({super.key});
  RxString account = ''.obs;
  RxString availableTahun = ''.obs;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SendFirstRowMessageController());
    controller.setDetault();
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
            "Trade Confirmation",
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
                      () => OrderMassage.reqTradeConfirmation(
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
                      await OrderMassage.reqTradeConfirmation(
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
                    listtradeconfirmationBYDATE.clear();
                    listtradeconfirmationREMAINDATE.clear();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: TradeConfirmationMain(),
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
                  Obx(() {
                    availableTahun.value;
                    return PopupMenuButton<String>(
                      position: PopupMenuPosition.under,
                      color: foregroundwidget,
                      constraints: BoxConstraints.tightFor(
                        height: 150.h,
                        width: 0.28.sw,
                      ),
                      itemBuilder: (BuildContext context) {
                        if (listtradeconfirmationREMAINDATE.isEmpty) return [];
                        List<String> availableYears =
                            listtradeconfirmationREMAINDATE
                                .expand((data) => data.array!)
                                .map((e) => e.tcDateList.toString())
                                .toSet()
                                .toList();
                        bool isSelected = availableTahun.value.isNotEmpty;
                        return availableYears.map((year) {
                          return PopupMenuItem(
                            padding: EdgeInsets.only(bottom: 3.h),
                            height: 22.h,
                            value: year,
                            child: Container(
                              alignment: Alignment.center,
                              color: availableTahun.value == year ||
                                      !isSelected &&
                                          availableYears.indexOf(year) == 0
                                  ? foregroundwidget2
                                  : foregroundwidget,
                              child: Text(
                                listtradeconfirmationREMAINDATE.isEmpty
                                    ? ''
                                    : dateAjaGarisMiring(year),
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

                        await OrderMassage.reqTradeConfirmation(
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
                            width: 0.23.sw,
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
                                    listtradeconfirmationREMAINDATE.isEmpty
                                        ? ''
                                        : dateAjaGarisMiring(
                                            listtradeconfirmationREMAINDATE
                                                    .isEmpty
                                                ? ''
                                                : availableTahun.value.isEmpty
                                                    ? listtradeconfirmationREMAINDATE
                                                        .first
                                                        .array!
                                                        .first
                                                        .tcDateList
                                                        .toString()
                                                    : availableTahun.value),
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
                    );
                  })
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 7.h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Buy Invoice",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 13.sp,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(onTap: () {
                                  if (listtradeconfirmationBYDATE.isEmpty) {
                                    NotifikasiPopup.show("Please insert PIN");
                                  } else {
                                    controller.isShowBuy.value =
                                        !controller.isShowBuy.value;
                                  }
                                }, child: Obx(() {
                                  return FittedBox(
                                    child: Icon(
                                      controller.isShowBuy.value
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                      color: controller.isShowBuy.value
                                          ? Colors.blue
                                          : Colors.white,
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
                        if (listtradeconfirmationBYDATE.isEmpty) {
                          return Container();
                        } else {
                          if (controller.isShowBuy.value) {
                            return Container(
                                margin: EdgeInsets.only(top: 5.h),
                                width: 1.sw,
                                height: 0.3.sh,
                                decoration: BoxDecoration(
                                  color: bgabu,
                                ),
                                child: HorizontalDataTable(
                                  elevation: 0,
                                  rowSeparatorWidget: Divider(
                                    height: 2.h,
                                    thickness: 0.05,
                                  ),
                                  leftHandSideColumnWidth: 0.4.sw,
                                  rightHandSideColumnWidth: 2.05.sw,
                                  isFixedHeader: true,
                                  scrollPhysics:
                                      listtradeconfirmationBYDATE.isEmpty ||
                                              listtradeconfirmationBYDATE
                                                      .first
                                                      .arraycountpertama!
                                                      .length <=
                                                  5
                                          ? const NeverScrollableScrollPhysics()
                                          : const ScrollPhysics(),
                                  isFixedFooter: true,
                                  headerWidgets: _getHeaderWidgetBUY(),
                                  leftHandSideColBackgroundColor: Colors.black,
                                  rightHandSideColBackgroundColor: Colors.black,
                                  itemCount:
                                      listtradeconfirmationBYDATE.isEmpty ||
                                              listtradeconfirmationBYDATE.first
                                                  .arraycountpertama!.isEmpty
                                          ? 0
                                          : listtradeconfirmationBYDATE
                                              .first.arraycountpertama!.length,
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
                                                color: Colors.white
                                                    .withOpacity(0.85),
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
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalGrossAmount!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalBrokerFee!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalLevy!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalWht!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalVAT!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
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
                                            listtradeconfirmationBYDATE
                                                .first.totalNetAmount!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ],
                                  leftSideItemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 20.h,
                                          width: 0.1.sw,
                                          color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                listtradeconfirmationBYDATE
                                                        .isEmpty
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  listtradeconfirmationBYDATE
                                                          .isEmpty
                                                      ? ""
                                                      : "  ${listtradeconfirmationBYDATE.first.arraycountpertama![index].stockcode}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 5.w),
                                                alignment:
                                                    Alignment.centerRight,
                                                width: 0.05.sw,
                                                child: listtradeconfirmationBYDATE
                                                        .isEmpty
                                                    ? null
                                                    : !delistingStock(
                                                            listtradeconfirmationBYDATE
                                                                .first
                                                                .arraycountpertama![
                                                                    index]
                                                                .stockcode!)
                                                        ? null
                                                        : getSpesialNotifier(listtradeconfirmationBYDATE
                                                                    .first
                                                                    .arraycountpertama![
                                                                        index]
                                                                    .stockcode!)
                                                                .isEmpty
                                                            ? null
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  NotifikasiPopup
                                                                      .showINFO(
                                                                          text:
                                                                              '${specialNotations(getSpesialNotifier(listtradeconfirmationBYDATE.first.arraycountpertama![index].stockcode!))}');
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .info_outline,
                                                                  color: Colors
                                                                      .blue,
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
                                    return Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .price!),
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
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .qty!),
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
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .grossAmount!),
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
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .brokerFee!),
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
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .levy!),
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
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .wht!),
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
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .vat!),
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
                                          height: 20.h,
                                          width: 0.3.sw,
                                          color: Colors.black,
                                          child: Text(
                                            formattaCurrun(
                                                listtradeconfirmationBYDATE
                                                    .first
                                                    .arraycountpertama![index]
                                                    .netAmount!),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: putihop85,
                                                fontSize: FontSizes.size11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ));
                          } else {
                            return Container();
                          }
                        }
                      }),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sell Invoice",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 13.sp,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(onTap: () {
                                  if (listtradeconfirmationBYDATE.isEmpty) {
                                    NotifikasiPopup.show("Please insert PIN");
                                  } else {
                                    controller.isShowSell.value =
                                        !controller.isShowSell.value;
                                  }
                                }, child: Obx(() {
                                  return FittedBox(
                                    child: Icon(
                                      controller.isShowSell.value
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                      color: controller.isShowSell.value
                                          ? Colors.blue
                                          : Colors.white,
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
                        if (listtradeconfirmationBYDATE.isEmpty) {
                          return Container();
                        } else {
                          if (controller.isShowSell.value) {
                            return Container(
                                margin: EdgeInsets.only(top: 5.h),
                                width: 1.sw,
                                height: 0.3.sh,
                                decoration: BoxDecoration(
                                  color: bgabu,
                                ),
                                child: HorizontalDataTable(
                                  elevation: 0,
                                  rowSeparatorWidget: Divider(
                                    height: 2.h,
                                    thickness: 0.05,
                                  ),
                                  leftHandSideColumnWidth: 0.4.sw,
                                  rightHandSideColumnWidth: 2.3.sw,
                                  isFixedHeader: true,
                                  isFixedFooter: true,
                                  scrollPhysics:
                                      listtradeconfirmationBYDATE.isEmpty ||
                                              listtradeconfirmationBYDATE
                                                      .first
                                                      .arraycountkedua!
                                                      .length <=
                                                  5
                                          ? const NeverScrollableScrollPhysics()
                                          : const ScrollPhysics(),
                                  headerWidgets: _getHeaderWidgetSELL(),
                                  leftHandSideColBackgroundColor: Colors.black,
                                  rightHandSideColBackgroundColor: Colors.black,
                                  itemCount:
                                      listtradeconfirmationBYDATE.isEmpty ||
                                              listtradeconfirmationBYDATE.first
                                                  .arraycountkedua!.isEmpty
                                          ? 0
                                          : listtradeconfirmationBYDATE
                                              .first.arraycountkedua!.length,
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
                                                color: Colors.white
                                                    .withOpacity(0.85),
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
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalGrossAmountAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalBrokerFeeAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalLevyAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalWhtAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalVATAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      width: 0.25.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalSalesTaxAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      height: 20.h,
                                      padding: EdgeInsets.only(right: 5.w),
                                      width: 0.3.sw,
                                      color: foregroundwidget,
                                      child: Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalNetAmountAR2!),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ],
                                  leftSideItemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 20.h,
                                          width: 0.1.sw,
                                          color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                listtradeconfirmationBYDATE
                                                        .isEmpty
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  listtradeconfirmationBYDATE
                                                          .isEmpty
                                                      ? ""
                                                      : "  ${listtradeconfirmationBYDATE.first.arraycountkedua![index].stockcode}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 5.w),
                                                alignment:
                                                    Alignment.centerRight,
                                                width: 0.05.sw,
                                                child: listtradeconfirmationBYDATE
                                                        .isEmpty
                                                    ? null
                                                    : !delistingStock(
                                                            listtradeconfirmationBYDATE
                                                                .first
                                                                .arraycountkedua![
                                                                    index]
                                                                .stockcode!)
                                                        ? null
                                                        : getSpesialNotifier(listtradeconfirmationBYDATE
                                                                    .first
                                                                    .arraycountkedua![
                                                                        index]
                                                                    .stockcode!)
                                                                .isEmpty
                                                            ? null
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  NotifikasiPopup
                                                                      .showINFO(
                                                                          text:
                                                                              '${specialNotations(getSpesialNotifier(listtradeconfirmationBYDATE.first.arraycountkedua![index].stockcode!))}');
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .info_outline,
                                                                  color: Colors
                                                                      .blue,
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
                                    return Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: 20.h,
                                          width: 0.25.sw,
                                          color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .price!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .qty!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .grossAmount!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .brokerFee!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .levy!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .wht!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .vat!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .salesTax!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: 20.h,
                                          padding: EdgeInsets.only(right: 5.w),
                                          width: 0.3.sw,
                                          color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                formattaCurrun(
                                                    listtradeconfirmationBYDATE
                                                        .first
                                                        .arraycountkedua![index]
                                                        .netAmount!),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: FontSizes.size11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ));
                          } else {
                            return Container();
                          }
                        }
                      }),
                      Container(
                        padding: EdgeInsets.only(left: 5.w),
                        margin: EdgeInsets.only(top: 5.h),
                        height: 30.h,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: bgabu,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Grand Total",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 13.sp,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(onTap: () {
                                  if (listtradeconfirmationBYDATE.isEmpty) {
                                    NotifikasiPopup.show("Please insert PIN");
                                  } else {
                                    controller.isShowTotal.value =
                                        !controller.isShowTotal.value;
                                  }
                                }, child: Obx(() {
                                  return FittedBox(
                                    child: Icon(
                                      controller.isShowTotal.value
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                      color: controller.isShowTotal.value
                                          ? Colors.blue
                                          : Colors.white,
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
                        if (listtradeconfirmationBYDATE.isEmpty) {
                          return Container();
                        } else {
                          if (controller.isShowTotal.value) {
                            return Wrap(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Net Purchase (Sell)",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.netPurchaseSELL!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.netPurchaseSELL ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first
                                                          .netPurchaseSELL! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Broker Fee",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalBrokerFee!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.totalBrokerFee ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first
                                                          .totalBrokerFee! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total LEVY",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.grandtotalLevy!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.grandtotalLevy ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first
                                                          .grandtotalLevy! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total WHT",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.grandtotalWHT!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.grandtotalWHT ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first
                                                          .grandtotalWHT! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total VAT",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.totalVAT!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.totalVAT ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first.totalVAT! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Sales Tax",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.salesTax!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.salesTax ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first.salesTax! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Other Fee",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.otherFee!),
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  height: 30.h,
                                  width: 1.sw,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Due to you",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                            listtradeconfirmationBYDATE
                                                .first.grandTotal!),
                                        style: TextStyle(
                                          color: listtradeconfirmationBYDATE
                                                      .first.grandTotal ==
                                                  0
                                              ? putihop85
                                              : listtradeconfirmationBYDATE
                                                          .first.grandTotal! <
                                                      0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _getHeaderWidgetBUY() {
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
            'Stock',
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
        'Price',
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
        'Vol',
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
        'Gross Amount',
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
        'Broker Fee',
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
        'Levy',
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
        'WHT',
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
        'Net Amount',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}

List<Widget> _getHeaderWidgetSELL() {
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
            'Stock',
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
        'Price',
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
        'Qty',
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
        'Gross Amount',
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
        'Broker Fee',
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
        'Levy',
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
        'WHT',
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
        'VAT',
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
        'Sales Tax',
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
        'Net Amount',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}

class SendFirstRowMessageController extends GetxController {
  RxBool isShowBuy = false.obs;
  RxBool isShowSell = false.obs;
  RxBool isShowTotal = false.obs;
  @override
  void onInit() {
    super.onInit();
    ever(listtradeconfirmationREMAINDATE, (callback) => sendFirst(callback));
  }

  void sendFirst(List<TradeConfirmationRemainDate> data) async {
    if (listtradeconfirmationREMAINDATE.isEmpty) {
    } else {
      await OrderMassage.reqTradeConfirmation(
        Get.find<PinSave>().pin.value,
        listtradeconfirmationREMAINDATE.first.array!.first.tcDateList
            .toString(),
        Get.find<LoginOrderController>().order!.value.account!.first.accountId!,
      );
      isShowBuy.toggle();
      isShowSell.toggle();
      isShowTotal.toggle();
    }
  }

  void setDetault() {
    Future.delayed(const Duration(milliseconds: 500), () {
      isShowBuy.value = false;
      isShowSell.value = false;
      isShowTotal.value = false;
    });
  }
}
