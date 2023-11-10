import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/controller/breakOrder.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/widget/newGTCBuy.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/widget_stock_balanace.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class SellBreakWidget extends StatelessWidget {
  final String title;
  final String pin;
  const SellBreakWidget({super.key, required this.title, required this.pin});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BreakOrderContoller());
    var controllers = Get.put(BodyController());
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  'Price: ',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              SizedBox(
                width: 0.73.sw,
                height: 25.h,
                child: TextField(
                  controller: controller.priceContollerBreak,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.size12,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  onTap: () {
                    controller.priceContollerBreak.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.priceContollerBreak.text.length,
                    );
                  },
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
                              size: 0.05.sw,
                            ),
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.show("Please Insert Pin");
                                return;
                              }

                              var a = int.parse(
                                  controller.priceContollerBreak.text == ''
                                      ? '0'
                                      : controller.priceContollerBreak.text
                                          .replaceFirst(RegExp(r','), ''));

                              int frac = controllers.fraksiPrice(
                                a == 0 ? a.toString() : (a - 1).toString(),
                              );
                              controller.priceContollerBreak.text =
                                  formattaCurrun(
                                (int.parse(controller
                                                .priceContollerBreak.text ==
                                            ''
                                        ? '0'
                                        : controller.priceContollerBreak.text
                                            .replaceFirst(RegExp(r','), '')) -
                                    frac),
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.show("Please Insert Pin");
                                return;
                              }
                              var a = int.parse(
                                  controller.priceContollerBreak.text == ''
                                      ? '0'
                                      : controller.priceContollerBreak.text
                                          .replaceFirst(RegExp(r','), ''));
                              int frac = controllers.fraksiPrice(
                                a == 0
                                    ? (a + 2).toString()
                                    : (a + 1).toString(),
                              );
                              controller.priceContollerBreak.text =
                                  formattaCurrun(
                                (int.parse(controller
                                                .priceContollerBreak.text ==
                                            ''
                                        ? '0'
                                        : controller.priceContollerBreak.text
                                            .replaceFirst(RegExp(r','), '')) +
                                    frac),
                              );
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 0.05.sw,
                            ),
                          ),
                          SizedBox(
                            width: 0.01.sh,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  'QTY: ',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              SizedBox(
                width: 0.37.sw,
                height: 25.h,
                child: TextField(
                  controller: controller.qrtyControllerBreak,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.size12,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  onTap: () {
                    controller.qrtyControllerBreak.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.qrtyControllerBreak.text.length,
                    );
                  },
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
                              size: 0.05.sw,
                            ),
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.show("Please Insert Pin");
                                return;
                              }
                              controller.qrtyControllerBreak.text == '0'
                                  ? null
                                  : controller.qrtyControllerBreak.text =
                                      (int.parse(controller.qrtyControllerBreak
                                                          .text ==
                                                      ''
                                                  ? '0'
                                                  : controller
                                                      .qrtyControllerBreak.text
                                                      .replaceFirst(
                                                          RegExp(r','), '')) -
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
                                NotifikasiPopup.show("Please Insert Pin");
                                return;
                              }
                              controller.qrtyControllerBreak.text = (int.parse(
                                          controller.qrtyControllerBreak.text ==
                                                  ''
                                              ? '0'
                                              : controller
                                                  .qrtyControllerBreak.text
                                                  .replaceFirst(
                                                      RegExp(r','), '')) +
                                      1)
                                  .toString();
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 0.05.sw,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => Get.find<PinSave>()
                            .limit
                            .value
                            .remainTradingLimit ==
                        null
                    ? NotifikasiPopup.show("Please Insert Pin")
                    : controller.priceContollerBreak.text == ''
                        ? NotifikasiPopup.show("Please Input Price")
                        : controller.qrtyControllerBreak.text = formattaCurrun(
                            controllers.max(
                              true,
                              int.parse(controller.priceContollerBreak.text
                                  .replaceFirst(RegExp(r','), '')),
                              0,
                            ),
                          ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  width: 60.w,
                  height: 24.h,
                  child: Text(
                    'MaxCash',
                    style:
                        TextStyle(fontSize: FontSizes.size11, color: putihop85),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => Get.find<PinSave>()
                            .limit
                            .value
                            .remainTradingLimit ==
                        null
                    ? NotifikasiPopup.show("Please Insert Pin")
                    : controller.priceContollerBreak.text == ''
                        ? NotifikasiPopup.show("Please Input Price")
                        : controller.qrtyControllerBreak.text = formattaCurrun(
                            controllers.max(
                              true,
                              int.parse(controller.priceContollerBreak.text
                                  .replaceFirst(RegExp(r','), '')),
                              1,
                            ),
                          ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  width: 60.w,
                  height: 24.h,
                  child: Text(
                    'MaxLimit',
                    style:
                        TextStyle(fontSize: FontSizes.size11, color: putihop85),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return Row(
              children: [
                SizedBox(
                  width: 50.w,
                  child: Text(
                    'C.Price: ',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size12,
                    ),
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (c) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Text(
                          'Best Bid Price',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Best Offer Price',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          'Last Price',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text(
                          'Avg Price',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                    ];
                  },
                  onSelected: (i) {
                    controller.cPriceType.value = i;
                  },
                  position: PopupMenuPosition.under,
                  child: SizedBox(
                    width: 115.w,
                    height: 25.h,
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(
                        text: controller.cPriceType.value == 0
                            ? ' Best Bid Price'
                            : controller.cPriceType.value == 1
                                ? ' Best Offer Price'
                                : controller.cPriceType.value == 2
                                    ? ' Last Price'
                                    : ' Avg Price',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: putihop85,
                      ),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSizes.size12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                PopupMenuButton(
                  itemBuilder: (c) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          '<',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          '>',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                    ];
                  },
                  onSelected: (i) {
                    controller.cPriceCpn.value = i;
                  },
                  constraints: BoxConstraints.tightFor(width: 40.w),
                  position: PopupMenuPosition.under,
                  child: SizedBox(
                    width: 46.w,
                    height: 25.h,
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(
                        text: controller.cPriceCpn.value == 1 ? ' <' : ' >',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: putihop85,
                        suffixIcon: Container(
                          padding: EdgeInsets.zero,
                          color: Colors.black.withOpacity(0.7),
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 19.0.sp,
                          ),
                        ),
                        suffixIconConstraints:
                            BoxConstraints.tightFor(width: 18.w, height: 50.h),
                        suffixIconColor: putihop85,
                      ),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSizes.size12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: 98.w,
                  height: 25.h,
                  child: TextField(
                    controller: controller.cPriceContollerBreak,
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    maxLength: 9,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size12,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      CurrencyInputFormatter(
                        thousandSeparator: ThousandSeparator.Comma,
                        mantissaLength: 0,
                      ),
                    ],
                    onTap: () {
                      controller.cPriceContollerBreak.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset:
                            controller.cPriceContollerBreak.text.length,
                      );
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                      counterText: '',
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return Row(
              children: [
                SizedBox(
                  width: 50.w,
                  child: Text(
                    'C.Vol: ',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size12,
                    ),
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (c) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Text(
                          'None',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Traded Volume',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          'Best Bid Volume',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text(
                          'Best Offer Volume',
                          style: TextStyle(fontSize: FontSizes.size12),
                        ),
                      ),
                    ];
                  },
                  onSelected: (i) {
                    controller.cVolType.value = i;
                  },
                  constraints: BoxConstraints.tightFor(width: 125.w),
                  child: SizedBox(
                    width: 115.w,
                    height: 25.h,
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(
                        text: controller.cVolType.value == 0
                            ? ' None'
                            : controller.cVolType.value == 1
                                ? ' Traded Volume'
                                : controller.cVolType.value == 2
                                    ? ' Best Bid Volume'
                                    : ' Best Offer Volume',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: putihop85,
                        counterText: '',
                      ),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSizes.size12,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLength: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Obx(() {
                  return PopupMenuButton(
                    position: PopupMenuPosition.under,
                    enabled: controller.cVolType.value == 0 ? false : true,
                    itemBuilder: (a) {
                      return [
                        PopupMenuItem(
                          value: 0,
                          child: Text(
                            '<=',
                            style: TextStyle(fontSize: FontSizes.size12),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            '>=',
                            style: TextStyle(fontSize: FontSizes.size12),
                          ),
                        ),
                      ];
                    },
                    constraints: BoxConstraints.tightFor(width: 50.w),
                    onSelected: (i) {
                      controller.cVolCpn.value = i;
                    },
                    child: SizedBox(
                      width: 46.w,
                      height: 25.h,
                      child: TextField(
                        enabled: false,
                        controller: TextEditingController(
                          text: controller.cVolCpn.value == 0 ? ' <=' : ' >=',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: putihop85,
                          suffixIcon: Container(
                            padding: EdgeInsets.zero,
                            color: Colors.black.withOpacity(0.7),
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 19.0.sp,
                            ),
                          ),
                          suffixIconConstraints: BoxConstraints.tightFor(
                              width: 18.w, height: 50.h),
                          suffixIconColor: putihop85,
                        ),
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FontSizes.size12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: 98.w,
                  height: 25.h,
                  child: Obx(() {
                    return TextField(
                      controller: controller.cVolContollerBreak,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSizes.size12,
                        fontWeight: FontWeight.w500,
                      ),
                      enabled: controller.cVolType.value == 0 ? false : true,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        CurrencyInputFormatter(
                          thousandSeparator: ThousandSeparator.Comma,
                          mantissaLength: 0,
                        ),
                      ],
                      onTap: () {
                        controller.cVolContollerBreak.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset:
                              controller.cVolContollerBreak.text.length,
                        );
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: putihop85,
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  'Expiry: ',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size12,
                  ),
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
                  controller.effectiveDateContollerBreak.text = data;
                },
                child: SizedBox(
                  width: 0.345.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controller.effectiveDateContollerBreak,
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
                  controller.dueDateContollerBreak.text = data;
                },
                child: SizedBox(
                  width: 0.345.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controller.dueDateContollerBreak,
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
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60.w,
                  child: Text(
                    'AutoOrder: ',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  height: 25.h,
                  width: 55.w,
                  child: FlutterSwitch(
                    value: controller.autoOrder.value,
                    onToggle: (e) {
                      if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                          null) {
                        NotifikasiPopup.show("Please Insert Pin");
                        return;
                      }
                      controller.autoOrder.value = e;
                      if (e == false) {
                        controller.priceStap.text = '';
                      }
                      if (e == true) {
                        controller.priceStap.text = '8';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: 0.48.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controller.priceStap,
                    showCursor: false,
                    enabled: controller.autoOrder.value,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size12,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    maxLength: 2,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      counterText: '',
                      border: const OutlineInputBorder(),
                      fillColor: putihop85,
                      filled: true,
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  var a = Get.find<PinSave>().pin.value;
                  // if (pin == '') pin = a;
                  OrderMassage.stockBalance(
                    pin: a == '' ? pin : a,
                    accountId: accountId.value == ''
                        ? Get.find<LoginOrderController>()
                            .order!
                            .value
                            .account!
                            .first
                            .accountId!
                        : accountId.value,
                  );
                  if (pin == '' || a == '') {}
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r)),
                    ),
                    useSafeArea: true,
                    backgroundColor: bgabu,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 0.5.sh,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  fontWeight: FontWeight.bold),
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
                                  controller.qrtyControllerBreak.text =
                                      formattaCurrun(a.balance! ~/
                                          Get.find<LoginOrderController>()
                                              .order!
                                              .value
                                              .lot!);
                                  if (a.stockCode != title) {
                                    Navigator.of(context).pushReplacementNamed(
                                      '/newBreak',
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
                      );
                    },
                  );
                },
                child: Container(
                  width: 0.35.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.blue.withOpacity(0.25),
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Stock Balance',
                    style: TextStyle(
                      fontSize: FontSizes.size12,
                      fontWeight: FontWeight.bold,
                      color: putihop85,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                      null) {
                    NotifikasiPopup.show("Please Insert Pin");
                    return;
                  }
                  if (controller.priceContollerBreak.text == '' ||
                      controller.qrtyControllerBreak.text == '') {
                    NotifikasiPopup.show(
                      "Please Input ${controller.priceContollerBreak.text == '' ? 'Price' : 'Quantity'}",
                    );
                    return;
                  }

                  Get.defaultDialog(
                    title: 'SELL Break Confirmation',
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
                        child: const Text('Cancle'),
                      ),
                    ),
                    confirm: GestureDetector(
                      onTap: () {
                        controller.onSendMassageBuy(
                          stockCode: title,
                          type: false,
                          pin: pin,
                        );
                        controller.clearData();
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
                        child: const Text('Confirm'),
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
                            '$title - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(title)).build().findFirst()!.stockName!}',
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
                                      controller.priceContollerBreak.text,
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
                                      controller.qrtyControllerBreak.text,
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
                              SizedBox(
                                width: 160.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Conditional Price: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.cPriceType.value == 0
                                          ? ' Best Bid Price'
                                          : controller.cPriceType.value == 1
                                              ? ' Best Offer Price'
                                              : controller.cPriceType.value == 2
                                                  ? ' Last Price'
                                                  : ' Avg Price',
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
                                      controller.cPriceCpn.value == 1
                                          ? '<'
                                          : '>',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      controller.cPriceContollerBreak.text == ''
                                          ? '0'
                                          : controller
                                              .cPriceContollerBreak.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 160.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Conditional Vol: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    ),
                                    Text(
                                      controller.cVolType.value == 0
                                          ? ' None'
                                          : controller.cVolType.value == 1
                                              ? ' Traded Volume'
                                              : controller.cVolType.value == 2
                                                  ? ' Best Bid Volume'
                                                  : ' Best Offer Volume',
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
                                      controller.cVolCpn.value == 0
                                          ? ' <='
                                          : ' >=',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                    Text(
                                      controller.cVolContollerBreak.text == ''
                                          ? '0'
                                          : controller.cVolContollerBreak.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
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
                                      controller
                                          .effectiveDateContollerBreak.text,
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
                                      controller.dueDateContollerBreak.text,
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
                            height: 6.h,
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
                                      (controller.autoOrder.value
                                              ? 'Active'
                                              : 'Inactive')
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller.autoOrder.value
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
                                      controller.priceStap.text == ''
                                          ? '0'
                                          : controller.priceStap.text,
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
                                          price: controller
                                              .priceContollerBreak.text,
                                          qty: controller
                                              .qrtyControllerBreak.text,
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
                                          price: controller
                                              .priceContollerBreak.text,
                                          qty: controller
                                              .qrtyControllerBreak.text,
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
                                          price: controller
                                              .priceContollerBreak.text,
                                          qty: controller
                                              .qrtyControllerBreak.text,
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
                  width: 0.35.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.green,
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Confirm SELL Break',
                    style: TextStyle(
                      fontSize: FontSizes.size12,
                      fontWeight: FontWeight.bold,
                      color: putihop85,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
