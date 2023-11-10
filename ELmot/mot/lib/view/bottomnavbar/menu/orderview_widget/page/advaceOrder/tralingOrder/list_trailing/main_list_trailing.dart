// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/requestTralingList.pkg.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/controllerTraling/tralingOrder.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/list_trailing/widget/trailing_list_widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/newTralingOrder/widget/cancelTraling.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

RxString selectedType = '0'.obs;

class ListTrailingMain extends StatelessWidget {
  ListTrailingMain({super.key});
  late String pin = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        listTrailingOrder.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(1.sw, 40.h),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Trailing List',
              style: TextStyle(
                fontSize: FontSizes.size16,
                color: putihop85,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                listTrailingOrder.clear();
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Pin.show(
              onComplete: (a) {
                Get.put(PinSave()).pin.value = a;
                Get.put(BodyController());
                pin = a;
                OrderMassage.reqListTrailingList(
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
                    status: int.parse(selectedType.value));
                ActivityRequest.parameterRequest(requestFlag: 1);
              },
              onSelect: () async {
                await Future.delayed(const Duration(milliseconds: 51), () {
                  OrderMassage.reqListTrailingList(
                      accountId: accountId.value == ""
                          ? Get.find<LoginOrderController>()
                              .order!
                              .value
                              .account!
                              .first
                              .accountId
                              .toString()
                          : accountId.value,
                      pin: int.parse(Get.find<PinSave>().pin.value),
                      status: int.parse(selectedType.value));
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 8.w, bottom: 5.h),
              child: PopupMenuButton(
                elevation: 0,
                offset: const Offset(0, 0),
                position: PopupMenuPosition.under,
                constraints: BoxConstraints.tightFor(
                  height: 90.h,
                  width: 0.28.sw,
                ),
                color: foregroundwidget,
                itemBuilder: (context) => listTrailingOrder.isEmpty
                    ? []
                    : [
                        PopupMenuItem(
                          value: '0',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'All',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size11),
                          )),
                        ),
                        PopupMenuItem(
                          value: '1',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Open',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size11),
                          )),
                        ),
                        PopupMenuItem(
                          value: '2',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Executed',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size11),
                          )),
                        ),
                        PopupMenuItem(
                          value: '3',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Withdrawn',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size11),
                          )),
                        ),
                        PopupMenuItem(
                          value: '4',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Rejected',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size11),
                          )),
                        ),
                      ],
                onSelected: (value) async {
                  switch (value) {
                    case '0':
                      selectedType.value = '0';
                      selectedType.refresh();
                    case '1':
                      selectedType.value = '1';
                      selectedType.refresh();
                    case '2':
                      selectedType.value = '2';
                      selectedType.refresh();
                    case '3':
                      selectedType.value = '3';
                      selectedType.refresh();
                    case '4':
                      selectedType.value = '4';
                      selectedType.refresh();
                  }
                  await OrderMassage.reqListTrailingList(
                      accountId: accountId.value == ""
                          ? Get.find<LoginOrderController>()
                              .order!
                              .value
                              .account!
                              .first
                              .accountId
                              .toString()
                          : accountId.value,
                      pin: int.parse(Get.find<PinSave>().pin.value),
                      status: int.parse(selectedType.value));
                },
                child: Wrap(
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
                      child: Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            return Text(
                              selectedType.value == '0'
                                  ? 'All'
                                  : selectedType.value == '1'
                                      ? 'Open'
                                      : selectedType.value == '2'
                                          ? 'Executed'
                                          : selectedType.value == '3'
                                              ? 'Withdrawn'
                                              : selectedType.value == '4'
                                                  ? 'Rejected'
                                                  : '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSizes.size12,
                              ),
                            );
                          })),
                    ),
                    Container(
                      height: 22.h,
                      width: 0.05.sw,
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
            ),
            Expanded(
              child: tableTrailingList(
                onTapX: (a) {
                  var controllerTraling = Get.put(TralingOrderController());
                  controllerTraling.typeComment.value =
                      a.command == 0 ? true : false;
                  controllerTraling.buyAt.value = a.execPrice!;
                  controllerTraling.qtyControllerTraling.text = formattaCurrun(
                    a.volume! ~/
                        Get.find<LoginOrderController>().order!.value.lot!,
                  );
                  controllerTraling.lowThanTraling.text =
                      formattaCurrun(a.dropPrice!);
                  controllerTraling.upThanTraling.text = (a.trailingStep! ~/
                          Get.find<LoginOrderController>().order!.value.lot!)
                      .toString();
                  controllerTraling.effectiveDateContollerTraling.text =
                      dateAjaGarisMiring(a.startDate);
                  controllerTraling.dueDateContollerTraling.text =
                      dateAjaGarisMiring(a.dueDate);
                  controllerTraling.autoTraling.value =
                      a.autoPriceStep == 0 ? false : true;
                  controllerTraling.priceStapControllerTraling.text =
                      a.autoPriceStep.toString();
                  controllerTraling.priceType.value = a.trailingPriceType!;

                  tralingID = a.orderId!;
                  if (a.command == 0) {
                    popUpConfim(a.orderId!);
                  } else {
                    popUpSellConfim(a.orderId!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
