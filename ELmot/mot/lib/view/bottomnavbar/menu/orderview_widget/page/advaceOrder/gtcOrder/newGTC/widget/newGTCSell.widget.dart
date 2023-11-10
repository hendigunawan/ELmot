import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/controller/newGTC.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/widget_stock_balanace.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

import 'newGTCBuy.widget.dart';

class NewGTCSellWidget extends StatelessWidget {
  final String title;
  const NewGTCSellWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewGTCController());
    var controllers = Get.put(BodyController());
    if (!isFirst) {
      Future.delayed(
        Duration.zero,
        () {
          controller.priceContollerGTC.text = formattaCurrun(
            ObjectBoxDatabase.quotesBox
                .query(Quotes_.stockCode.equals(title))
                .build()
                .findFirst()!
                .lastPrice!,
          );
        },
      );

      isFirst = true;
    }
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price:',
                style: TextStyle(
                  color: putihop85,
                  fontSize: FontSizes.size12,
                ),
              ),
              SizedBox(
                width: 0.76.sw,
                height: 25.h,
                child: TextField(
                  controller: controller.priceContollerGTC,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.size12,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(),
                    fillColor: putihop85,
                    filled: true,
                    suffixIcon: Container(
                      width: 0.15.sw,
                      padding: EdgeInsets.only(
                        top: 0.1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 18.sp,
                            ),
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }

                              var a = int.parse(
                                  controller.priceContollerGTC.text == ''
                                      ? '0'
                                      : controller.priceContollerGTC.text
                                          .replaceFirst(RegExp(r','), ''));

                              int frac = controllers.fraksiPrice(
                                a == 0 ? a.toString() : (a - 1).toString(),
                              );
                              controller.priceContollerGTC.text = (int.parse(
                                          controller.priceContollerGTC.text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .priceContollerGTC.text
                                                  .replaceFirst(
                                                      RegExp(r','), '')) -
                                      frac)
                                  .toString();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }
                              var a = int.parse(
                                  controller.priceContollerGTC.text == ''
                                      ? '0'
                                      : controller.priceContollerGTC.text
                                          .replaceFirst(RegExp(r','), ''));
                              int frac = controllers.fraksiPrice(
                                a == 0
                                    ? (a + 2).toString()
                                    : (a + 1).toString(),
                              );
                              controller.priceContollerGTC.text = (int.parse(
                                          controller.priceContollerGTC.text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .priceContollerGTC.text
                                                  .replaceFirst(
                                                      RegExp(r','), '')) +
                                      frac)
                                  .toString();
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 18.sp,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 10.h, thickness: 0.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'QTY: ',
                style: TextStyle(
                  color: putihop85,
                  fontSize: FontSizes.size12,
                ),
              ),
              SizedBox(
                width: 0.41.sw,
                height: 25.h,
                child: TextField(
                  controller: controller.qtyContollerGTC,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.size12,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(),
                    fillColor: putihop85,
                    filled: true,
                    suffixIcon: Container(
                      width: 0.15.sw,
                      padding: EdgeInsets.only(
                        top: 0.1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 18.sp,
                            ),
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }
                              controller.qtyContollerGTC.text == '0'
                                  ? null
                                  : controller.qtyContollerGTC.text =
                                      (int.parse(controller.qtyContollerGTC
                                                          .text ==
                                                      ''
                                                  ? '0'
                                                  : controller
                                                      .qtyContollerGTC.text) -
                                              1)
                                          .toString();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }
                              controller.qtyContollerGTC.text = (int.parse(
                                          controller.qtyContollerGTC.text == ''
                                              ? '0'
                                              : controller
                                                  .qtyContollerGTC.text) +
                                      1)
                                  .toString();
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Get.find<PinSave>().limit.value.remainTradingLimit == null
                        ? NotifikasiPopup.showWarning("Please Insert Pin")
                        : controller.priceContollerGTC.text == ''
                            ? NotifikasiPopup.showWarning("Please Input Price")
                            : controller.qtyContollerGTC.text = controllers
                                .max(
                                  true,
                                  int.parse(controller.priceContollerGTC.text),
                                  0,
                                )
                                .toString(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  width: 55.w,
                  height: 24.h,
                  child: Text(
                    'MaxCash',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size11,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Get.find<PinSave>().limit.value.remainTradingLimit == null
                        ? NotifikasiPopup.showWarning("Please Insert Pin")
                        : controller.priceContollerGTC.text == ''
                            ? NotifikasiPopup.showWarning("Please Input Price")
                            : controller.qtyContollerGTC.text = controllers
                                .max(
                                  true,
                                  int.parse(controller.priceContollerGTC.text),
                                  1,
                                )
                                .toString(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  width: 55.w,
                  height: 24.h,
                  child: Text(
                    'MaxLimit',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size11,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 10.h, thickness: 0.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expiry: ',
                style: TextStyle(
                  color: putihop85,
                  fontSize: FontSizes.size12,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var date = await selectDate(
                    context,
                    DateTime.now(),
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day +
                          DateUtils.getDaysInMonth(
                            DateTime.now().year,
                            DateTime.now().month,
                          ),
                    ),
                  );

                  var data = DateFormat('yyyy/MM/dd').format(
                    date ?? DateTime.now(),
                  );
                  controller.effectiveDateContollerGTC.text = data;
                },
                child: SizedBox(
                  width: 0.35.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controller.effectiveDateContollerGTC,
                    showCursor: false,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size12,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: putihop85,
                      filled: true,
                    ),
                  ),
                ),
              ),
              Text(
                ' ~ ',
                style: TextStyle(
                  fontSize: FontSizes.size12,
                  color: putihop85,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var date = await selectDate(
                    context,
                    DateTime.now(),
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day +
                          DateUtils.getDaysInMonth(
                            DateTime.now().year,
                            DateTime.now().month,
                          ),
                    ),
                  );

                  var data = DateFormat('yyyy/MM/dd').format(
                    date ?? DateTime.now(),
                  );
                  controller.dueDateContollerGTC.text = data;
                },
                child: SizedBox(
                  width: 0.35.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controller.dueDateContollerGTC,
                    showCursor: false,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size12,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: putihop85,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 10.h, thickness: 0.5.r),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'AutoOrder: ',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size12,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  height: 25.h,
                  width: 55.w,
                  child: FlutterSwitch(
                    value: controller.autoGTC.value,
                    onToggle: (e) {
                      if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                          null) {
                        NotifikasiPopup.showWarning("Please Insert Pin");
                        return;
                      }
                      controller.autoGTC.value = e;
                      if (e == false) {
                        controller.priceStapControllerGTC.text = '';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: 0.47.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controller.priceStapControllerGTC,
                    showCursor: false,
                    enabled: controller.autoGTC.value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size12,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: putihop85,
                      filled: true,
                    ),
                  ),
                ),
              ],
            );
          }),
          Divider(height: 10.h, thickness: 0.5.h),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (Get.find<PinSave>().pin.value == '') {
                    NotifikasiPopup.showWarning("Please Insert Pin");
                    return;
                  }
                  OrderMassage.stockBalance(
                    pin: Get.find<PinSave>().pin.value,
                    accountId: accountId.value == ''
                        ? Get.find<LoginOrderController>()
                            .order!
                            .value
                            .account!
                            .first
                            .accountId!
                        : accountId.value,
                  );

                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    useSafeArea: true,
                    backgroundColor: bgabu,
                    context: context,
                    builder: (c) => SizedBox(
                      height: 0.5.sh,
                      width: 1.sw,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 3.h, bottom: 5.h),
                            width: 0.25.sw,
                            height: 10.h,
                            child: Divider(
                              color: foregroundwidget2,
                              thickness: 2.h,
                              height: 3.h,
                            ),
                          ),
                          Text(
                            "Stock Balance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: putihop85,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Expanded(
                            child: StockBalanceWidget(
                              onTapCode: (a) {
                                Navigator.of(context).pop();
                                if (!delistingStock(a.stockCode!)) {
                                  NotifikasiPopup.showWarning(
                                    'Sorry, but the stock you have selected is not available in the market or has been delisted. Please contact customer service for more detailed information.',
                                  );
                                  return;
                                }
                                ActivityRequest.quoteRequest(
                                  packageId: Constans.PACKAGE_ID_QUOTES,
                                  commant: 1,
                                  arrayStockCode: [
                                    ArrayStockCode(
                                      stockCode: a.stockCode!,
                                      board: Get.find<ControllerBoard>()
                                          .boards
                                          .value,
                                    )
                                  ],
                                );
                                ActivityRequest.orderBookRequest(
                                  packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                  stockCode: a.stockCode!,
                                  board:
                                      Get.find<ControllerBoard>().boards.value,
                                  commant: "1",
                                );

                                controller.qtyContollerGTC.text = (a.balance! ~/
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .lot!)
                                    .toString();
                                if (a.stockCode != title) {
                                  Navigator.of(context).pushReplacementNamed(
                                    '/newGTC',
                                    arguments: <String, String>{
                                      'title': a.stockCode!,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 0.3.sw,
                  height: 30.h,
                  margin: EdgeInsets.only(right: 10.w, left: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Stock Balance',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                      null) {
                    NotifikasiPopup.showWarning("Please Insert Pin");
                    return;
                  }
                  if (controller.priceContollerGTC.text == '' ||
                      controller.qtyContollerGTC.text == '') {
                    NotifikasiPopup.showWarning(
                      "Please Input ${controller.priceContollerGTC.text == '' ? 'Price' : 'Quantity'}",
                    );
                    return;
                  }

                  Get.defaultDialog(
                    title: 'SELL\n GTC Confirmation',
                    titleStyle: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    cancel: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 70.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.red,
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'Cancel',
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                      ),
                    ),
                    confirm: GestureDetector(
                      onTap: () {
                        controller.confirm(
                          stockCode: title,
                          pin: int.parse(
                            Get.find<PinSave>().pin.value,
                          ),
                          type: false,
                        );
                        controller.qtyContollerGTC.text = '';
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 70.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.blue,
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'Confirm',
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                      ),
                    ),
                    content: Container(
                      padding: EdgeInsets.all(2.w),
                      // color: Colors.greenAccent,
                      // width: 1.w,
                      // height: 0.5.sw,
                      child: Column(
                        children: [
                          Text(
                            '${Get.find<PinSave>().stockCode.value} - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(Get.find<PinSave>().stockCode.value)).build().findFirst()!.stockName!}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size13,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                            width: 0.5.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Market: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                                Text(
                                  Get.find<ControllerBoard>().boards.value ==
                                          'RG'
                                      ? 'Regular Market'
                                      : 'Cash Market',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Account ID: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizes.size11,
                                  ),
                                ),
                                SizedBox(
                                  width: 190.w,
                                  child: Text(
                                    '${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountId : accountId.value} - ${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountName : Get.find<LoginOrderController>().order!.value.account!.firstWhere((element) => element.accountId == accountId.value).accountName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizes.size11,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.priceContollerGTC.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 0.025.sw,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Volume: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.qtyContollerGTC.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 3.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'EffectiveDate: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.effectiveDateContollerGTC.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 0.025.sw,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'DueDate: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.dueDateContollerGTC.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Auto Order: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      (controller.autoGTC.value
                                              ? 'Active'
                                              : 'Inactive')
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller.autoGTC.value
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 0.025.sw,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price Stap: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.priceStapControllerGTC.text ==
                                              ''
                                          ? '0'
                                          : controller
                                              .priceStapControllerGTC.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 0.25.sw,
                            child: MainTable(
                              header: [
                                HeaderModel(
                                  label: Text(
                                    'Estimation',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                HeaderModel(
                                  label: Text(
                                    'Transaction Fee',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                HeaderModel(
                                  label: Text(
                                    'Nett',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ],
                              body: [
                                BodyModel(
                                  body: [
                                    Text(
                                      formattaCurrun(
                                        controllers.stockEstimasi(
                                          price:
                                              controller.priceContollerGTC.text,
                                          qty: controller.qtyContollerGTC.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      formattaCurrun(
                                        controllers.fee(
                                          false,
                                          price:
                                              controller.priceContollerGTC.text,
                                          qty: controller.qtyContollerGTC.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      formattaCurrun(
                                        controllers.nett(
                                          false,
                                          price:
                                              controller.priceContollerGTC.text,
                                          qty: controller.qtyContollerGTC.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 0.3.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm SELL',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
