import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/breakorderlist.pkg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/controller/breakOrder.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/widget_break_order_list.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

RxString selectedTypeBreak = '1'.obs;

// ignore: must_be_immutable
class ListBreakOrderMain extends StatelessWidget {
  ListBreakOrderMain({super.key});
  late String pin = '';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BreakOrderContoller());
    var controllers = Get.put(BodyController());
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(1.sw, 40.h),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Break Order List',
              style: TextStyle(
                fontSize: 16.sp,
                color: putihop85,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
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
                pin = a;
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
                    status: int.parse(selectedTypeBreak.value));
              },
              onSelect: () async {
                await Future.delayed(const Duration(milliseconds: 51), () {
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
                      pin: int.parse(Get.find<PinSave>().pin.value),
                      status: int.parse(selectedTypeBreak.value));
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
                itemBuilder: (context) => listBreakorderList.isEmpty
                    ? []
                    : [
                        PopupMenuItem(
                          value: '1',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Open',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                        ),
                        PopupMenuItem(
                          value: '2',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Executed',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                        ),
                        PopupMenuItem(
                          value: '3',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Withdrawn',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                        ),
                        PopupMenuItem(
                          value: '0',
                          height: 35.h,
                          child: Center(
                              child: Text(
                            'Rejected',
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                        ),
                      ],
                onSelected: (value) async {
                  switch (value) {
                    case '0':
                      selectedTypeBreak.value = '0';
                      selectedTypeBreak.refresh();
                    case '1':
                      selectedTypeBreak.value = '1';
                      selectedTypeBreak.refresh();
                    case '2':
                      selectedTypeBreak.value = '2';
                      selectedTypeBreak.refresh();
                    case '3':
                      selectedTypeBreak.value = '3';
                      selectedTypeBreak.refresh();
                  }
                  await OrderMassage.reqBreakOrderList(
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
                      status: int.parse(selectedTypeBreak.value));
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
                              selectedTypeBreak.value == '0'
                                  ? 'Rejected'
                                  : selectedTypeBreak.value == '1'
                                      ? 'Open'
                                      : selectedTypeBreak.value == '2'
                                          ? 'Executed'
                                          : 'Withdrawn',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
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
                            '${a.stockCode} - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(a.stockCode!)).build().findFirst()!.stockName!}',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
