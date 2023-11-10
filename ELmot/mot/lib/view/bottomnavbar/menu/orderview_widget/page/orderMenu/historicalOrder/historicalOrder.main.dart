// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/historical_orderlist.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cash_withdraw_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/orderMenu/historicalOrder/widget/widget_list_historical.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class HistoricalOrder extends StatelessWidget {
  const HistoricalOrder({super.key});
  @override
  Widget build(BuildContext context) {
    var dateController = Get.put(DateController());
    dateController.setDefaultListHistori();
    dateController.setDateDefault();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 40.h),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: SizedBox(
                child: Icon(
                  Icons.arrow_back,
                  size: 0.05.sw,
                  color: putihop85,
                ),
              ),
            ),
            title: Text(
              'Historical Order List',
              style: TextStyle(
                color: putihop85,
                fontSize: FontSizes.size16,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Pin.show(
              onComplete: (a) {
                Get.find<PinSave>().pin.value = a;
                String fromDate = dateController
                    .formatDateToyyyyMMdd(dateController.selectedDate.value);
                String toDate = dateController
                    .formatDateToyyyyMMdd(dateController.selectedToDate.value);
                OrderMassage.historicalorderListReq(
                    accountId: accountId.value == ''
                        ? Get.find<LoginOrderController>()
                            .order!
                            .value
                            .account!
                            .first
                            .accountId!
                        : accountId.value,
                    pin: a,
                    fromDate: int.parse(fromDate),
                    toDate: int.parse(toDate));
                fokusNode.unfocus();
              },
              onSelect: () async {
                String fromDate = dateController
                    .formatDateToyyyyMMdd(dateController.selectedDate.value);
                String toDate = dateController
                    .formatDateToyyyyMMdd(dateController.selectedToDate.value);
                await Future.delayed(const Duration(milliseconds: 51), () {
                  OrderMassage.historicalorderListReq(
                      accountId: accountId.value == ''
                          ? Get.find<LoginOrderController>()
                              .order!
                              .value
                              .account!
                              .first
                              .accountId!
                          : accountId.value,
                      pin: Get.find<PinSave>().pin.value,
                      fromDate: int.parse(fromDate),
                      toDate: int.parse(toDate));
                });
              },
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  "  From",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size12,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (listHistorical.isNotEmpty) {
                      dateController.showFromDate(context, ishostory: true);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
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
                              alignment: Alignment.center,
                              child: Obx(() {
                                return Text(
                                  "${dateController.selectedDate.value.toLocal()}"
                                      .split(' ')[0],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSizes.size12,
                                  ),
                                );
                              })),
                        ),
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
                Text(
                  "  to  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size12,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (listHistorical.isNotEmpty) {
                      dateController.showtoDate(context, ishostory: true);
                    }
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
                              alignment: Alignment.center,
                              child: Obx(() {
                                return Text(
                                  "${dateController.selectedToDate.value.toLocal()}"
                                      .split(' ')[0],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSizes.size12,
                                  ),
                                );
                              })),
                        ),
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
              ],
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: const WidgetListHistoricalOrder()),
            )
          ],
        ),
      ),
    );
  }
}
