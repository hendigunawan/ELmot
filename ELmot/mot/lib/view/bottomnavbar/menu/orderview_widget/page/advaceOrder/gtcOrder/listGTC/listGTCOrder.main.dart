// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/requestGTCList.pkg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/listGTC/widget/tableGTCOrder.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/controller/newGTC.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/widget/cancelGTC.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class ListGTCOrderMain extends StatelessWidget {
  ListGTCOrderMain({super.key});
  late String pin = '';
  var controller = Get.put(NewGTCController());
  var controllers = Get.put(BodyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 40.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'GTC List',
            style: TextStyle(
              fontSize: FontSizes.size16,
              color: putihop85,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              listGTC.clear();
              controller.clear();
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: putihop85,
              size: 20.sp,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Pin.show(onComplete: (a) {
            Get.put(PinSave()).pin.value = a;
            pin = a;
            controller.getList();
          }, onSelect: () {
            Future.delayed(Duration.zero, () => controller.getList());
          }),
          Container(
            margin: EdgeInsets.only(
              bottom: 15.h,
              left: 18.w,
              right: 18.w,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: putihop85,
                  width: 0.15.w,
                ),
                borderRadius: BorderRadius.circular(7.r)),
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            alignment: Alignment.centerLeft,
            width: 1.sw,
            height: 50.h,
            child: Row(
              children: [
                PopupMenuButton(
                  color: bgabu,
                  position: PopupMenuPosition.under,
                  constraints: BoxConstraints(maxWidth: 120.w),
                  itemBuilder: (_) {
                    return [
                      PopupMenuItem(
                        value: 'All',
                        onTap: () {
                          controller.filterData.value = 'All';
                        },
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Open',
                        onTap: () {
                          controller.filterData.value = 'Open';
                        },
                        child: Text(
                          'Open',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Executed',
                        onTap: () {
                          controller.filterData.value = 'Executed';
                        },
                        child: Text(
                          'Executed',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: FontSizes.size12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Withdrawn',
                        onTap: () {
                          controller.filterData.value = 'Withdrawn';
                        },
                        child: Text(
                          'Withdrawn',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Expired',
                        onTap: () {
                          controller.filterData.value = 'Expired';
                        },
                        child: Text(
                          'Expired',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: FontSizes.size12,
                          ),
                        ),
                      ),
                    ];
                  },
                  onSelected: (a) {
                    if (pin == '' && Get.find<PinSave>().pin.value == '') {
                      NotifikasiPopup.show("Please Insert Pin");
                      return;
                    }
                    controller.getList();
                  },
                  child: Container(
                    width: 130.w,
                    height: 25.h,
                    padding: EdgeInsets.only(left: 5.w),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Obx(
                      () {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.filterData.value),
                            Container(
                              width: 30.w,
                              color: bgabu,
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: FontSizes.xsmall,
                                color: putihop85,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 1.sw,
            height: 500.h,
            child: tableGTC(
              onTap: (a) {
                var data = listGTC.first.array![a];
                controller.priceContollerGTC.text = data.price!.toString();
                controller.qtyContollerGTC.text =
                    ((data.oVolume! - data.tVolume!) ~/
                            Get.find<LoginOrderController>().order!.value.lot!)
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

                Get.defaultDialog(
                  title: 'Cancel GTC Confirmation',
                  titleStyle: const TextStyle(
                    color: Colors.red,
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
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                    ),
                  ),
                  confirm: GestureDetector(
                    onTap: () {
                      OrderMassage.createGTCCancel(
                        pin: int.parse(Get.find<PinSave>().pin.value),
                        gtcId: idGTC,
                      );
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
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
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
                          '${data.stockCode} - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(data.stockCode!)).build().findFirst()!.stockName!}',
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
                          height: 6.h,
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
                                    controller.priceStapControllerGTC.text == ''
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
                                        true,
                                        price:
                                            controller.priceContollerGTC.text,
                                        qty: controller.qtyContollerGTC.text,
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
                                        price:
                                            controller.priceContollerGTC.text,
                                        qty: controller.qtyContollerGTC.text,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
