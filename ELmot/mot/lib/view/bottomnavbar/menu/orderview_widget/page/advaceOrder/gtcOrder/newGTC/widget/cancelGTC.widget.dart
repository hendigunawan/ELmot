// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/requestGTCList.pkg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/listGTC/widget/tableGTCOrder.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/controller/newGTC.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/newGTC.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

String idGTC = '';

class CancelGTCWidget extends StatelessWidget {
  const CancelGTCWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewGTCController());
    var controllers = Get.put(BodyController());
    void showtablegtcList(BuildContext context, int pin) {
      OrderMassage.reqListAdvaceOrder(
        packageID: Constans.PACKAGE_ID_REQUEST_GTC_ORDER_LIST,
        pin: pin,
        status: 1,
      );
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r))),
        backgroundColor: bgabu,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 0.65.sh,
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
                  'GTC List',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: tableGTC(
                    onTap: (i) {
                      if (Get.find<PinSave>().pin.value == '') {
                        NotifikasiPopup.showWarning("Please Insert Pin");
                        return;
                      }
                      Navigator.of(context).pop();
                      var data = listGTC.first.array![i];
                      if (data.stockCode != title) {
                        Navigator.pushReplacementNamed(context, '/newGTC',
                            arguments: <String, String>{
                              'title': data.stockCode!,
                            });
                        indexTab.value = 2;
                      }
                      controller.priceContollerGTC.text =
                          data.price!.toString();
                      controller.qtyContollerGTC.text =
                          ((data.oVolume! - data.tVolume!) ~/
                                  Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .lot!)
                              .toString();
                      if (data.autoPriceStep! > 0) {
                        controller.autoGTC.value = true;
                        controller.priceStapControllerGTC.text =
                            data.autoPriceStep!.toString();
                      }
                      controller.effectiveDateContollerGTC.text =
                          dateAjaGarisMiring(data.effectiveDate);
                      controller.dueDateContollerGTC.text =
                          dateAjaGarisMiring(data.dueDate);
                      idGTC = data.gtcId!;
                      controller.comment.value =
                          data.command == 0 ? true : false;
                      controller.accountId.value = listGTC.first.accountId!;
                      // OrderMassage.createGTCCancel(
                      //   pin: int.parse(Get.find<PinSave>().pin.value),
                      //   gtcId: listGTC.first.array![i].gtcId!,
                      // );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
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
                  maxLength: 7,
                  enabled: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.size12,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
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
          Divider(height: 10.h, thickness: 0.5.r),
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
                width: 0.76.sw,
                height: 25.h,
                child: TextField(
                  controller: controller.qtyContollerGTC,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  enabled: false,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.size12,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
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
          Divider(height: 10.h, thickness: 0.5.r),
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
                    disabled: true,
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
                      if (e == true) {
                        controller.priceStapControllerGTC.text = '8';
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
          Divider(height: 10.h, thickness: 0.5.r),
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
                  showtablegtcList(
                      context, int.parse(Get.find<PinSave>().pin.value));
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
                    'GTC LIST',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size14,
                      fontWeight: FontWeight.bold,
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
                    NotifikasiPopup.showWarning("Please Insert Pin");
                    return;
                  }
                  if (controller.priceContollerGTC.text == '' ||
                      controller.qtyContollerGTC.text == '') {
                    NotifikasiPopup.showWarning(
                      "Please Select Transction In GTC List",
                    );
                    return;
                  }
                  Get.defaultDialog(
                    title:
                        'Cancel GTC ${controller.comment.value ? 'BUY' : 'SELL'} Confirmation',
                    titleStyle: TextStyle(
                      color:
                          controller.comment.value ? Colors.red : Colors.green,
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
                        child: const Text('Cancel'),
                      ),
                    ),
                    confirm: GestureDetector(
                      onTap: () {
                        OrderMassage.createGTCCancel(
                          pin: int.parse(Get.find<PinSave>().pin.value),
                          gtcId: idGTC,
                        );
                        controller.clear();
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
                                          controller.comment.value
                                              ? true
                                              : false,
                                          price:
                                              controller.priceContollerGTC.text,
                                          qty: controller.qtyContollerGTC.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: controller.comment.value
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
                                          controller.comment.value
                                              ? true
                                              : false,
                                          price:
                                              controller.priceContollerGTC.text,
                                          qty: controller.qtyContollerGTC.text,
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: controller.comment.value
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
                  width: 0.3.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm Cancel',
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
