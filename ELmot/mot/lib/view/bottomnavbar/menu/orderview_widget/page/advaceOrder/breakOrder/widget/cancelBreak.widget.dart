import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/controller/breakOrder.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/widget_break_order_list.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class CancleBreakWidget extends StatelessWidget {
  final String title;
  final String pin;
  const CancleBreakWidget({super.key, required this.title, required this.pin});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BreakOrderContoller());
    var controllers = Get.put(BodyController());
    void listBreakView() {
      OrderMassage.reqBreakOrderList(
        accountId: accountId.value == ""
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId
                .toString()
            : accountId.value,
        pin: int.parse(pin),
        status: 1,
      );
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r))),
        backgroundColor: bgabu,
        context: context,
        builder: (c) => Container(
          height: 0.65.sh,
          width: 1.sw,
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 3.5.h,
                margin: EdgeInsets.symmetric(vertical: FontSizes.size5),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: foregroundwidget2,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              Text(
                'Break List',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0.sp,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: WidgetBreakOrderList(
                  onTapX: (a) {
                    controller.priceContollerBreak.text =
                        formattaCurrun(a.price!);
                    controller.qrtyControllerBreak.text = formattaCurrun(
                      a.volume! ~/
                          Get.find<LoginOrderController>().order!.value.lot!,
                    );
                    controller.cPriceType.value = a.priceType!;
                    controller.cPriceCpn.value = a.priceCriteria!;
                    controller.cPriceContollerBreak.text =
                        formattaCurrun(a.targetPrice!);
                    controller.cVolType.value = a.volumeType!;
                    controller.cVolCpn.value = a.volumeCriteria!;
                    controller.cVolContollerBreak.text =
                        formattaCurrun(a.targetVol!);
                    controller.effectiveDateContollerBreak.text =
                        dateAjaGarisMiring(a.startDate);
                    controller.dueDateContollerBreak.text =
                        dateAjaGarisMiring(a.dueDate);
                    controller.autoOrder.value =
                        a.autoPriceStep == 0 ? false : true;
                    controller.priceStap.text = a.autoPriceStep!.toString();
                    controller.idBreakContollerBreak.text = a.orderId!;
                    controller.command.value = a.command == 0 ? true : false;
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      );
    }

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
                  enabled: false,
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
                width: 0.73.sw,
                height: 25.h,
                child: TextField(
                  enabled: false,
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
                SizedBox(
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
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
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
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: 98.w,
                  height: 25.h,
                  child: TextField(
                    enabled: false,
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
                SizedBox(
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
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
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
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: 98.w,
                  height: 25.h,
                  child: TextField(
                    controller: controller.cVolContollerBreak,
                    textAlign: TextAlign.end,
                    enabled: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      CurrencyInputFormatter(
                        thousandSeparator: ThousandSeparator.Comma,
                        mantissaLength: 0,
                      ),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size12,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                    ),
                  ),
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
              SizedBox(
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
              Text(
                ' ~ ',
                style: TextStyle(
                  fontSize: FontSizes.size12,
                  color: putihop85,
                ),
              ),
              SizedBox(
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
                    disabled: true,
                    value: controller.autoOrder.value,
                    onToggle: (e) {
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
                    enabled: false,
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
              GestureDetector(
                onTap: () {
                  listBreakView();
                },
                child: Container(
                  width: 0.3.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Break List',
                    style: TextStyle(
                      fontSize: FontSizes.size11,
                      fontWeight: FontWeight.bold,
                      color: putihop85,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
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
                    title:
                        'Cancel Break ${controller.command.value ? 'BUY' : 'SELL'} Confirmation',
                    titleStyle: TextStyle(
                      color:
                          controller.command.value ? Colors.red : Colors.green,
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
                        Navigator.of(context).pop();
                        controller.onSeadCancelBreak(int.parse(pin));
                        controller.clearData();
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
                                          controller.command.value,
                                          price: controller
                                              .priceContollerBreak.text,
                                          qty: controller
                                              .qrtyControllerBreak.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: controller.command.value
                                            ? Colors.red
                                            : Colors.green,
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      formattaCurrun(
                                        controllers.nett(
                                          controller.command.value,
                                          price: controller
                                              .priceContollerBreak.text,
                                          qty: controller
                                              .qrtyControllerBreak.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: controller.command.value
                                            ? Colors.red
                                            : Colors.green,
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
                  width: 0.5.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.red,
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Confirm Cancel Break',
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
