// ignore_for_file: must_be_immutable

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
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/controllerTraling/tralingOrder.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/newTralingOrder/widget/popupTraling.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

import '../../../gtcOrder/newGTC/widget/newGTCBuy.widget.dart';

class NewBuyTralingWidget extends StatelessWidget {
  final String title;
  NewBuyTralingWidget({super.key, required this.title});
  // var controller = Get.put(());
  var controllerTraling = Get.put(TralingOrderController());
  var controllers = Get.put(BodyController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'Buy at: ',
                  style: TextStyle(
                    fontSize: FontSizes.size12,
                    color: putihop85,
                  ),
                ),
              ),
              SizedBox(width: 0.695.sw, height: 25.h, child: buyAt()),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'QTY: ',
                  style: TextStyle(
                    fontSize: FontSizes.size12,
                    color: putihop85,
                  ),
                ),
              ),
              SizedBox(
                width: 0.345.sw,
                height: 25.h,
                child: TextField(
                  controller: controllerTraling.qtyControllerTraling,
                  enabled: true,
                  maxLines: 1,
                  maxLength: 9,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: FontSizes.size12,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.right,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  onTap: () {
                    controllerTraling.qtyControllerTraling.selection =
                        TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          controllerTraling.qtyControllerTraling.text.length,
                    );
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: putihop85,
                    suffixIcon: Container(
                      width: 15.w,
                      padding: const EdgeInsets.only(
                        top: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.black87,
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
                              controllerTraling.qtyControllerTraling.text == '0'
                                  ? null
                                  : controllerTraling
                                          .qtyControllerTraling.text =
                                      formattaCurrun(int.parse(controllerTraling
                                              .qtyControllerTraling.text
                                              .replaceAll(RegExp(r','), '')) -
                                          1);
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
                              controllerTraling.qtyControllerTraling.text =
                                  formattaCurrun(int.parse(controllerTraling
                                          .qtyControllerTraling.text
                                          .replaceAll(RegExp(r','), '')) +
                                      1);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.black87,
                              size: 0.05.sw,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () =>
                    Get.find<PinSave>().limit.value.remainTradingLimit == null
                        ? NotifikasiPopup.show("Please Insert Pin")
                        : controllerTraling.qtyControllerTraling.text =
                            formattaCurrun(controllers.max(
                            true,
                            controllerTraling.getFraksiPlus(
                              stockCode: title,
                            ),
                            0,
                          )),
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
                      fontSize: FontSizes.size11,
                      color: putihop85,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () =>
                    Get.find<PinSave>().limit.value.remainTradingLimit == null
                        ? NotifikasiPopup.show("Please Insert Pin")
                        : controllerTraling.qtyControllerTraling.text =
                            formattaCurrun(controllers.max(
                            true,
                            controllerTraling.getFraksiPlus(
                              stockCode: title,
                            ),
                            1,
                          )),
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
                      fontSize: FontSizes.size11,
                      color: putihop85,
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
                width: 60.w,
                child: Text(
                  'Low Than: ',
                  style: TextStyle(
                    fontSize: FontSizes.size12,
                    color: putihop85,
                  ),
                ),
              ),
              SizedBox(
                width: 0.69.sw,
                height: 25.h,
                child: TextField(
                  controller: controllerTraling.lowThanTraling,
                  enabled: true,
                  maxLines: 1,
                  maxLength: 9,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: FontSizes.size12,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.right,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  onTap: () {
                    controllerTraling.lowThanTraling.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          controllerTraling.lowThanTraling.text.length,
                    );
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: putihop85,
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
                width: 60.w,
                child: Text(
                  'Up Than: ',
                  style: TextStyle(
                    fontSize: FontSizes.size12,
                    color: putihop85,
                  ),
                ),
              ),
              SizedBox(
                width: 0.69.sw,
                height: 25.h,
                child: TextField(
                  controller: controllerTraling.upThanTraling,
                  enabled: true,
                  maxLines: 1,
                  maxLength: 2,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: FontSizes.size12,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.right,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  onTap: () {
                    controllerTraling.upThanTraling.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controllerTraling.upThanTraling.text.length,
                    );
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: putihop85,
                    suffixText: '%',
                    suffixStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSizes.size14,
                      fontWeight: FontWeight.w800,
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
                width: 60.w,
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
                  if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                      null) {
                    return NotifikasiPopup.show("Please Insert Pin");
                  }
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
                  controllerTraling.effectiveDateContollerTraling.text = data;
                },
                child: SizedBox(
                  width: 0.324.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controllerTraling.effectiveDateContollerTraling,
                    showCursor: false,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSizes.size12,
                      fontWeight: FontWeight.w800,
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
                  if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                      null) {
                    return NotifikasiPopup.show("Please Insert Pin");
                  }
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
                  controllerTraling.dueDateContollerTraling.text = data;
                },
                child: SizedBox(
                  width: 0.324.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controllerTraling.dueDateContollerTraling,
                    showCursor: false,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSizes.size12,
                      fontWeight: FontWeight.w800,
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
                  width: 62.w,
                  child: Text(
                    'AutoOrder: ',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                  width: 55.w,
                  child: FlutterSwitch(
                    value: controllerTraling.autoTraling.value,
                    onToggle: (e) {
                      if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                          null) {
                        NotifikasiPopup.show("Please Insert Pin");
                        return;
                      }
                      controllerTraling.autoTraling.value = e;
                      if (e == false) {
                        controllerTraling.priceStapControllerTraling.text = '';
                      }
                      if (e == true) {
                        controllerTraling.priceStapControllerTraling.text = '8';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: 0.52.sw,
                  height: 25.h,
                  child: TextField(
                    controller: controllerTraling.priceStapControllerTraling,
                    showCursor: false,
                    enabled: controllerTraling.autoTraling.value,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSizes.size12,
                      fontWeight: FontWeight.w800,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    onTap: () {
                      controllerTraling.priceStapControllerTraling.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controllerTraling
                            .priceStapControllerTraling.text.length,
                      );
                    },
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
            height: 11.h,
          ),
          GestureDetector(
            onTap: () {
              if (controllerTraling.qtyControllerTraling.text == '' ||
                  controllerTraling.qtyControllerTraling.text == '0' ||
                  controllerTraling.lowThanTraling.text == '' ||
                  controllerTraling.upThanTraling.text == '') {
                NotifikasiPopup.show(
                  'Please Input ${controllerTraling.qtyControllerTraling.text == '' || controllerTraling.qtyControllerTraling.text == '0' ? 'QTY' : controllerTraling.lowThanTraling.text == '' ? 'Low Than' : 'Up Than'}',
                );
                return;
              }
              popUpConfim(title);
            },
            child: Container(
              width: 0.5.sw,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(7.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'Confirm BUY',
                style: TextStyle(
                  color: putihop85,
                  fontSize: FontSizes.size14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  PopupMenuButton buyAt() {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      constraints: BoxConstraints.tightFor(height: 100.h),
      itemBuilder: (a) {
        return PopUpTralingMenu.listPopUp();
      },
      onSelected: (a) {
        controllerTraling.buyAt.value = a;
      },
      child: Obx(
        () {
          return TextField(
            enabled: false,
            controller: TextEditingController(
              text: controllerTraling.buyAt.value == 0
                  ? '  Best Offer'
                  : controllerTraling.buyAt.value == 1
                      ? '  Best Offer +1'
                      : controllerTraling.buyAt.value == 2
                          ? '  Best Offer +2'
                          : controllerTraling.buyAt.value == 3
                              ? '  Best Offer +3'
                              : controllerTraling.buyAt.value == 4
                                  ? '  Best Offer +4'
                                  : '  Best Offer +5',
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
                  size: FontSizes.xsmall,
                ),
              ),
              suffixIconConstraints: BoxConstraints.tightFor(
                width: 25.w,
              ),
              suffixIconColor: putihop85,
            ),
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: FontSizes.size12,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
    );
  }

  popUpConfim(String stockCode) {
    return Get.defaultDialog(
      title: 'BUY Traling Confirmation',
      titleStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      cancel: GestureDetector(
        onTap: () => Get.back(),
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
          Get.back();
          controllerTraling.confirmBUYTraling(stockCode);
          controllerTraling.clearData();
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
                    Get.find<ControllerBoard>().boards.value == 'RG'
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Buy At: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.buyAt.value == 0
                            ? '  Best Bid'
                            : controllerTraling.buyAt.value == 1
                                ? '  Best Bid +1'
                                : controllerTraling.buyAt.value == 2
                                    ? '  Best Bid +2'
                                    : controllerTraling.buyAt.value == 3
                                        ? '  Best Bid +3'
                                        : controllerTraling.buyAt.value == 4
                                            ? '  Best Bid +4'
                                            : '  Best Bid +5',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Volume: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.qtyControllerTraling.text,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Low Than: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.lowThanTraling.text,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Up Than: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        '${controllerTraling.upThanTraling.text} %',
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EffectiveDate: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.effectiveDateContollerTraling.text,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due Date: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.dueDateContollerTraling.text,
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Auto Order Sell: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.autoTraling.value
                            ? 'Active'
                            : 'Inactive',
                        style: TextStyle(
                          color: controllerTraling.autoTraling.value
                              ? Colors.green
                              : Colors.red,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price Stap: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizes.size10,
                        ),
                      ),
                      Text(
                        controllerTraling.priceStapControllerTraling.text == ''
                            ? '0'
                            : controllerTraling.priceStapControllerTraling.text,
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
                            price: controllerTraling
                                .getFraksiPlus(stockCode: stockCode)
                                .toString(),
                            qty: controllerTraling.qtyControllerTraling.text,
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
                            true,
                            price: controllerTraling
                                .getFraksiPlus(stockCode: stockCode)
                                .toString(),
                            qty: controllerTraling.qtyControllerTraling.text,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: FontSizes.size10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        formattaCurrun(
                          controllers.nett(
                            true,
                            price: controllerTraling
                                .getFraksiPlus(stockCode: stockCode)
                                .toString(),
                            qty: controllerTraling.qtyControllerTraling.text,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.red,
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
  }
}
