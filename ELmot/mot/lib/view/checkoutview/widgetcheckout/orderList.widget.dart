import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/order/orderListReq.model.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/mainchechout_view.dart';
import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/new_OrderSell.widget.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/streamlist.trading.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

void orderListDataWidget({
  void Function(OrderListData, String accountId)? onTapA,
  void Function(OrderListData, String accountId)? onTapW,
}) {
  var controllers = Get.put(OrderListController());
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
    ),
    useSafeArea: true,
    enableDrag: true,
    backgroundColor: bgabu,
    context: Get.context!,
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
              "Order List",
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
              child: Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Obx(
                  () {
                    return ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: HorizontalDataTable(
                        leftHandSideColumnWidth: 0.3.sw,
                        rightHandSideColumnWidth: 1.48.sw,
                        leftHandSideColBackgroundColor: Colors.transparent,
                        rightHandSideColBackgroundColor: Colors.transparent,
                        isFixedHeader: true,
                        itemCount: controllers.data.value.array == null
                            ? 0
                            : controllers.data.value.array!.length,
                        headerWidgets: [
                          Row(
                            children: [
                              Container(
                                height: 66.h,
                                width: 0.1.sw,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: foregroundwidget,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                              width: 1.w,
                                            ),
                                          )),
                                    ),
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: foregroundwidget,
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                              width: 1.w,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 66.h,
                                width: 0.2.sw,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33.h,
                                      width: 0.2.sw,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: foregroundwidget,
                                          border: Border(
                                              bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ))),
                                      child: Text(
                                        'Type',
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 33.h,
                                      width: 0.2.sw,
                                      alignment: Alignment.center,
                                      color: foregroundwidget,
                                      child: Text(
                                        'Code',
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 66.h,
                            width: 0.23.sw,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                          left: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ))),
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.black,
                                          width: 1.w,
                                        ),
                                      )),
                                  child: Text(
                                    'Board',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 66.h,
                            width: 0.25.sw,
                            alignment: Alignment.center,
                            color: foregroundwidget,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 33.h,
                                  width: 0.25.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ))),
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 33.h,
                                  width: 0.25.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.black,
                                          width: 1.w,
                                        ),
                                      )),
                                  child: Text(
                                    'Qty',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 66.h,
                            width: 0.25.sw,
                            alignment: Alignment.center,
                            color: foregroundwidget,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 33.h,
                                  width: 0.25.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                          left: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ))),
                                  child: Text(
                                    'Order Time',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 33.h,
                                  width: 0.25.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.black,
                                          width: 1.w,
                                        ),
                                      )),
                                  child: Text(
                                    'Input User',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 66.h,
                            width: 0.25.sw,
                            alignment: Alignment.center,
                            color: foregroundwidget,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 33.h,
                                  width: 0.25.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                          left: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ))),
                                  child: Text(
                                    'Done Qty',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 33.h,
                                  width: 0.25.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.black,
                                          width: 1.w,
                                        ),
                                      )),
                                  child: Text(
                                    'Rest Qty',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 66.h,
                            width: 0.50.sw,
                            alignment: Alignment.center,
                            color: foregroundwidget,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 33.h,
                                  width: 0.50.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                          left: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.w,
                                          ))),
                                  child: Text(
                                    'Order ID',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 33.h,
                                  width: 0.50.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: foregroundwidget,
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.black,
                                          width: 1.w,
                                        ),
                                      )),
                                  child: Text(
                                    'Idx ID',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        leftSideItemBuilder: (context, index) => Obx(
                          () {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: controllers.data.value.array == null ||
                                      controllers.data.value.array!.isEmpty
                                  ? []
                                  : [
                                      controllers.data.value.array![index]
                                                  .orderStatus ==
                                              1
                                          ? Container(
                                              height: 66.h,
                                              width: 0.1.sw,
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      onTapA == null
                                                          ? null
                                                          : onTapA(
                                                              controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                  index],
                                                              controllers
                                                                  .data
                                                                  .value
                                                                  .accountId!);
                                                    },
                                                    child: Container(
                                                      height: 33.h,
                                                      width: 0.1.sw,
                                                      alignment:
                                                          Alignment.center,
                                                      color: index % 2 == 0
                                                          ? Colors.black
                                                          : bgabu
                                                              .withOpacity(0.6),
                                                      child: Text(
                                                        "A",
                                                        style: TextStyle(
                                                          color: Colors.amber,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      onTapW == null
                                                          ? null
                                                          : onTapW(
                                                              controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                  index],
                                                              controllers
                                                                  .data
                                                                  .value
                                                                  .accountId!);
                                                    },
                                                    child: Container(
                                                      height: 33.h,
                                                      width: 0.1.sw,
                                                      alignment:
                                                          Alignment.center,
                                                      color: index % 2 == 0
                                                          ? Colors.black
                                                          : bgabu
                                                              .withOpacity(0.6),
                                                      child: Text(
                                                        "W",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : controllers.data.value.array![index]
                                                      .orderStatus ==
                                                  0
                                              ? GestureDetector(
                                                  onTap: () => OrderMassage
                                                      .reqRejectedOrderMassage(
                                                    orderID: controllers
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .orderId!,
                                                    pin: Get.find<PinSave>()
                                                        .pin
                                                        .value,
                                                    accountId: controllers
                                                        .data.value.accountId!,
                                                  ),
                                                  child: Container(
                                                    height: 66.h,
                                                    width: 0.1.sw,
                                                    color: index % 2 == 0
                                                        ? Colors.black
                                                        : bgabu
                                                            .withOpacity(0.6),
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Colors.blue,
                                                      size: 15.sp,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 66.h,
                                                  width: 0.1.sw,
                                                  color: index % 2 == 0
                                                      ? Colors.black
                                                      : bgabu.withOpacity(0.6),
                                                ),
                                      Container(
                                        height: 66.h,
                                        width: 0.2.sw,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 33.h,
                                              width: 0.2.sw,
                                              alignment: Alignment.center,
                                              color: index % 2 == 0
                                                  ? Colors.black
                                                  : bgabu.withOpacity(0.6),
                                              child: Text(
                                                controllers
                                                            .data
                                                            .value
                                                            .array![index]
                                                            .command ==
                                                        0
                                                    ? "B"
                                                    : controllers
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .command ==
                                                            1
                                                        ? "S"
                                                        : controllers
                                                                    .data
                                                                    .value
                                                                    .array![
                                                                        index]
                                                                    .command ==
                                                                2
                                                            ? "M"
                                                            : controllers
                                                                        .data
                                                                        .value
                                                                        .array![
                                                                            index]
                                                                        .command ==
                                                                    3
                                                                ? "SS"
                                                                : "",
                                                style: TextStyle(
                                                    color: controllers
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .command ==
                                                            0
                                                        ? Colors.red
                                                        : controllers
                                                                    .data
                                                                    .value
                                                                    .array![
                                                                        index]
                                                                    .command ==
                                                                1
                                                            ? Colors.green
                                                            : controllers
                                                                        .data
                                                                        .value
                                                                        .array![
                                                                            index]
                                                                        .command ==
                                                                    2
                                                                ? Colors.orange
                                                                : controllers
                                                                            .data
                                                                            .value
                                                                            .array![
                                                                                index]
                                                                            .command ==
                                                                        3
                                                                    ? Colors
                                                                        .blue
                                                                    : null,
                                                    fontSize: 11.sp),
                                              ),
                                            ),
                                            Container(
                                              height: 33.h,
                                              width: 0.2.sw,
                                              alignment: Alignment.center,
                                              color: index % 2 == 0
                                                  ? Colors.black
                                                  : bgabu.withOpacity(0.6),
                                              child: Text(
                                                controllers.data.value
                                                    .array![index].stockCode
                                                    .toString(),
                                                style: TextStyle(
                                                  color: putihop85,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                            );
                          },
                        ),
                        rightSideItemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                height: 66.h,
                                width: 0.23.sw,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          OrderMassage.reqRejectedOrderMassage(
                                        orderID: controllers
                                            .data.value.array![index].orderId!,
                                        pin: Get.find<PinSave>().pin.value,
                                        accountId:
                                            controllers.data.value.accountId!,
                                      ),
                                      child: Container(
                                        height: 33.h,
                                        color: index % 2 == 0
                                            ? Colors.black
                                            : bgabu.withOpacity(0.6),
                                        alignment: Alignment.center,
                                        child: Text(
                                          controllers.data.value.array![index]
                                                      .orderStatus ==
                                                  1
                                              ? 'Open'
                                              : controllers
                                                          .data
                                                          .value
                                                          .array![index]
                                                          .orderStatus ==
                                                      2
                                                  ? 'Matched'
                                                  : controllers
                                                              .data
                                                              .value
                                                              .array![index]
                                                              .orderStatus ==
                                                          3
                                                      ? 'Amending'
                                                      : controllers
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .orderStatus ==
                                                              4
                                                          ? 'Withdrawing'
                                                          : controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .orderStatus ==
                                                                  5
                                                              ? 'Withdrawn'
                                                              : controllers
                                                                          .data
                                                                          .value
                                                                          .array![
                                                                              index]
                                                                          .orderStatus ==
                                                                      6
                                                                  ? 'Amended'
                                                                  : 'Rejected',
                                          style: TextStyle(
                                            color: putihop85,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.center,
                                      color: index % 2 == 0
                                          ? Colors.black
                                          : bgabu.withOpacity(0.6),
                                      child: Text(
                                        controllers.data.value.array![index]
                                            .boardMarketCode
                                            .toString(),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 66.h,
                                width: 0.25.sw,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.centerRight,
                                      color: index % 2 == 0
                                          ? Colors.black
                                          : bgabu.withOpacity(0.6),
                                      child: Text(
                                        formattaCurrun(controllers
                                            .data.value.array![index].price!),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.centerRight,
                                      color: index % 2 == 0
                                          ? Colors.black
                                          : bgabu.withOpacity(0.6),
                                      child: Text(
                                        formattaCurrun(controllers
                                            .data.value.array![index].oVolume!),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 66.h,
                                width: 0.25.sw,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.center,
                                      color: index % 2 == 0
                                          ? Colors.black
                                          : bgabu.withOpacity(0.6),
                                      child: Text(
                                        formatJam(controllers.data.value
                                                .array![index].orderTime
                                                .toString())
                                            .replaceAll(RegExp(r' '), ''),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.center,
                                      color: index % 2 == 0
                                          ? Colors.black
                                          : bgabu.withOpacity(0.6),
                                      child: Text(
                                        controllers
                                            .data.value.array![index].inputUser
                                            .toString(),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 5.w),
                                height: 66.h,
                                width: 0.25.sw,
                                color: index % 2 == 0
                                    ? Colors.black
                                    : bgabu.withOpacity(0.6),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        formattaCurrun(controllers
                                            .data.value.array![index].tVolume!),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        formattaCurrun(controllers
                                            .data.value.array![index].rVolume!),
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 5.w),
                                height: 66.h,
                                width: 0.50.sw,
                                color: index % 2 == 0
                                    ? Colors.black
                                    : bgabu.withOpacity(0.6),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        controllers
                                            .data.value.array![index].orderId!,
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 33.h,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        controllers.data.value.array![index]
                                            .idxOrderId!,
                                        style: TextStyle(
                                          color: putihop85,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

void popUpConfirmationOrder({required String type}) {
  BuildingMassageOrder contollerBuilding = Get.find();
  final bodyControl = Get.find<BodyController>();
  var getLimit = Get.find<PinSave>();
  Get.dialog(AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
    backgroundColor: Colors.white,
    titlePadding: EdgeInsets.only(top: 5.h),
    title: Column(
      children: [
        Text(
          type,
          style: TextStyle(
              color: type == 'BUY' ? Colors.red : greenOn,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp),
        ),
        Text(
          'Confirmation',
          style: TextStyle(
              color: type == 'BUY' ? Colors.red : greenOn,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp),
        ),
        SizedBox(height: 2.h),
        Text(
          '${getLimit.stockCode.value} - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(getLimit.stockCode.value)).build().findFirst()!.stockName!}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSizes.size13,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.only(
            left: 3.w,
            right: 3.w,
          ),
          width: 300.w,
          child: Row(
            children: [
              Text(
                'Account ID: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizes.size12,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              Flexible(
                child: Text(
                  '${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountId : accountId.value} - ${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountName : Get.find<LoginOrderController>().order!.value.account!.firstWhere((element) => element.accountId == accountId.value).accountName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.size12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        )
      ],
    ),
    contentPadding: EdgeInsets.zero,
    actionsAlignment: MainAxisAlignment.center,
    actions: <Widget>[
      GestureDetector(
        onTap: () => Get.back(),
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
            style: TextStyle(color: Colors.black, fontSize: FontSizes.size12),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          contollerBuilding.building.value.stockCode = getLimit.stockCode.value;
          contollerBuilding.building.value.volume = int.parse(
                bodyControl.qtyController.text.replaceAll(
                  RegExp(r','),
                  '',
                ),
              ) *
              Get.find<LoginOrderController>().order!.value.lot!;
          contollerBuilding.building.value.price = int.parse(
            bodyControl.priceController.value.text.replaceAll(
              RegExp(r','),
              '',
            ),
          );
          contollerBuilding.building.value.board =
              Get.find<ControllerBoard>().boards.value == 'RG' ? 0 : 1;
          contollerBuilding.building.value.pin =
              int.parse(Get.find<PinSave>().pin.value);
          contollerBuilding.building.value.command = type == 'BUY' ? 0 : 1;
          contollerBuilding.building.value.prevSameOrder =
              bodyControl.sameOrder.value == false ? 0 : 1;
          contollerBuilding.building.value.rendomSplit =
              bodyControl.randomSlit.value == false ? 0 : 1;
          contollerBuilding.building.value.nSplit =
              int.parse(bodyControl.splitTo.value.text);
          contollerBuilding.building.value.activPriceStep =
              bodyControl.aPriceStap.value == false ? 0 : 1;
          contollerBuilding.building.value.autoOrderPriceStep =
              int.parse(bodyControl.autoPrice.value.text);
          bodyControl.aOrder.value == false ? 0 : 1;
          contollerBuilding.building.value.priceStep =
              int.parse(bodyControl.priceStap.value.text);
          contollerBuilding.building.refresh();
          contollerBuilding.see();
          onTapConfirm.toggle();

          onChackOut.value = 'goCheckoutview';
          Get.back();
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
            style: TextStyle(color: Colors.black, fontSize: FontSizes.size12),
          ),
        ),
      ),
    ],
    content: Container(
      margin: EdgeInsets.only(top: 5.h),
      padding: EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w),
      height: 0.35.sh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                columnWidths: {
                  0: FixedColumnWidth(0.2.sw),
                  1: FixedColumnWidth(0.05.sw),
                  2: FixedColumnWidth(0.13.sw),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 25,
                          child: Text(
                            bodyControl.priceController.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Vol',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 25,
                          child: Text(
                            bodyControl.qtyController.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Table(
                columnWidths: {
                  0: FixedColumnWidth(0.17.sw),
                  1: FixedColumnWidth(0.05.sw),
                  2: FixedColumnWidth(0.15.sw),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            'Market',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 25,
                          child: Text(
                            Get.find<ControllerBoard>().boards.value == 'RG'
                                ? 'Regular '
                                : 'Cash ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: bgabu,
            height: 2.h,
            thickness: 1.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(0.3.sw),
                1: FixedColumnWidth(0.05.sw),
                2: FixedColumnWidth(0.1.sw),
              },
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 25,
                        child: Text(
                          'Prevent same order',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizes.size11,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizes.size11,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        child: Text(
                          bodyControl.sameOrder.value ? 'ON' : 'OFF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizes.size10,
                            color: bodyControl.sameOrder.value
                                ? greenOn
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                columnWidths: {
                  0: FixedColumnWidth(0.3.sw),
                  1: FixedColumnWidth(0.05.sw),
                  2: FixedColumnWidth(0.1.sw),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Randomize Split',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            bodyControl.randomSlit.value ? 'ON' : 'OFF',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                              color: bodyControl.randomSlit.value
                                  ? greenOn
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Price Step',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            bodyControl.aPriceStap.value ? 'ON' : 'OFF',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                              color: bodyControl.aPriceStap.value
                                  ? greenOn
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Auto ${type == 'BUY' ? 'SELL' : "BUY"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            bodyControl.aOrder.value ? 'ON' : 'OFF',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                              color: bodyControl.aOrder.value
                                  ? greenOn
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Table(
                columnWidths: {
                  0: FixedColumnWidth(0.13.sw),
                  1: FixedColumnWidth(0.05.sw),
                  2: FixedColumnWidth(0.08.sw),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Split to',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 25,
                          child: Text(
                            bodyControl.splitTo.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Value',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 25,
                          child: Text(
                            bodyControl.priceStap.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 25,
                          child: Text(
                            'Value',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 25,
                          child: Text(
                            bodyControl.autoPrice.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
              child: MainTable(
            header: [
              HeaderModel(
                label: Text(
                  'Estimation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size11,
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
                    fontSize: FontSizes.size11,
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
                    fontSize: FontSizes.size11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ],
            body: [
              BodyModel(
                body: [
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(
                      formattaCurrun(bodyControl.stockEstimasi()),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: FontSizes.size11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(
                      formattaCurrun(
                          bodyControl.fee(type == 'BUY' ? true : false)),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: FontSizes.size11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h, right: 3.w),
                    child: Text(
                      formattaCurrun(
                          bodyControl.nett(type == 'BUY' ? true : false)),
                      style: TextStyle(
                        color: type == 'BUY' ? Colors.red : greenOn,
                        fontSize: FontSizes.size11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    ),
  ));
  // showDialog(
  //   useSafeArea: true,
  //   context: Get.context!,
  //   builder: (context) {
  //     return AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.r),
  //       ),
  //       backgroundColor: Colors.white,
  //       titlePadding: EdgeInsets.only(top: 5.h),
  //       title: Column(
  //         children: [
  //           Text(
  //             type,
  //             style: TextStyle(
  //                 color: type == 'BUY' ? Colors.red : greenOn,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 15.sp),
  //           ),
  //           Text(
  //             'Confirmation',
  //             style: TextStyle(
  //                 color: type == 'BUY' ? Colors.red : greenOn,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 15.sp),
  //           ),
  //           SizedBox(height: 2.h),
  //           Text(
  //             '${getLimit.stockCode.value} - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(getLimit.stockCode.value)).build().findFirst()!.stockName!}',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: FontSizes.size13,
  //             ),
  //             textAlign: TextAlign.center,
  //             maxLines: 2,
  //           ),
  //           SizedBox(height: 5.h),
  //           Container(
  //             padding: EdgeInsets.only(
  //               left: 3.w,
  //               right: 3.w,
  //             ),
  //             width: 300.w,
  //             child: Row(
  //               children: [
  //                 Text(
  //                   'Account ID: ',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: FontSizes.size12,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   maxLines: 1,
  //                 ),
  //                 Flexible(
  //                   child: Text(
  //                     '${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountId : accountId.value} - ${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountName : Get.find<LoginOrderController>().order!.value.account!.firstWhere((element) => element.accountId == accountId.value).accountName}',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: FontSizes.size12,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     maxLines: 1,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //       contentPadding: EdgeInsets.zero,
  //       actionsAlignment: MainAxisAlignment.center,
  //       actions: <Widget>[
  //         GestureDetector(
  //           onTap: () => Navigator.of(context).pop(),
  //           child: Container(
  //             width: 70.w,
  //             height: 30.h,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5.r),
  //               color: Colors.red,
  //             ),
  //             alignment: AlignmentDirectional.center,
  //             child: Text(
  //               'Cancel',
  //               style:
  //                   TextStyle(color: Colors.black, fontSize: FontSizes.size12),
  //             ),
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             contollerBuilding.building.value.stockCode =
  //                 getLimit.stockCode.value;
  //             contollerBuilding.building.value.volume = int.parse(
  //                   bodyControl.qtyController.text.replaceAll(
  //                     RegExp(r','),
  //                     '',
  //                   ),
  //                 ) *
  //                 Get.find<LoginOrderController>().order!.value.lot!;
  //             contollerBuilding.building.value.price = int.parse(
  //               bodyControl.priceController.value.text.replaceAll(
  //                 RegExp(r','),
  //                 '',
  //               ),
  //             );
  //             contollerBuilding.building.value.board =
  //                 Get.find<ControllerBoard>().boards.value == 'RG' ? 0 : 1;
  //             contollerBuilding.building.value.pin =
  //                 int.parse(Get.find<PinSave>().pin.value);
  //             contollerBuilding.building.value.command = type == 'BUY' ? 0 : 1;
  //             contollerBuilding.building.value.prevSameOrder =
  //                 bodyControl.sameOrder.value == false ? 0 : 1;
  //             contollerBuilding.building.value.rendomSplit =
  //                 bodyControl.randomSlit.value == false ? 0 : 1;
  //             contollerBuilding.building.value.nSplit =
  //                 int.parse(bodyControl.splitTo.value.text);
  //             contollerBuilding.building.value.activPriceStep =
  //                 bodyControl.aPriceStap.value == false ? 0 : 1;
  //             contollerBuilding.building.value.autoOrderPriceStep =
  //                 int.parse(bodyControl.autoPrice.value.text);
  //             bodyControl.aOrder.value == false ? 0 : 1;
  //             contollerBuilding.building.value.priceStep =
  //                 int.parse(bodyControl.priceStap.value.text);
  //             contollerBuilding.building.refresh();
  //             contollerBuilding.see();
  //             onTapConfirm.toggle();

  //             onChackOut.value = 'goCheckoutview';
  //             Navigator.of(context).pop();
  //           },
  //           child: Container(
  //             width: 70.w,
  //             height: 30.h,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5.r),
  //               color: Colors.blue,
  //             ),
  //             alignment: AlignmentDirectional.center,
  //             child: Text(
  //               'Confirm',
  //               style:
  //                   TextStyle(color: Colors.black, fontSize: FontSizes.size12),
  //             ),
  //           ),
  //         ),
  //       ],
  //       content: Container(
  //         margin: EdgeInsets.only(top: 5.h),
  //         padding: EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w),
  //         height: 0.35.sh,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(5.r),
  //         ),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Table(
  //                   columnWidths: {
  //                     0: FixedColumnWidth(0.2.sw),
  //                     1: FixedColumnWidth(0.05.sw),
  //                     2: FixedColumnWidth(0.13.sw),
  //                   },
  //                   children: [
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Price',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerRight,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.priceController.text,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Vol',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerRight,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.qtyController.text,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 Table(
  //                   columnWidths: {
  //                     0: FixedColumnWidth(0.17.sw),
  //                     1: FixedColumnWidth(0.05.sw),
  //                     2: FixedColumnWidth(0.15.sw),
  //                   },
  //                   children: [
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               'Market',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerRight,
  //                             height: 25,
  //                             child: Text(
  //                               Get.find<ControllerBoard>().boards.value == 'RG'
  //                                   ? 'Regular '
  //                                   : 'Cash ',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Divider(
  //               color: bgabu,
  //               height: 2.h,
  //               thickness: 1.h,
  //             ),
  //             Container(
  //               alignment: Alignment.centerLeft,
  //               child: Table(
  //                 columnWidths: {
  //                   0: FixedColumnWidth(0.3.sw),
  //                   1: FixedColumnWidth(0.05.sw),
  //                   2: FixedColumnWidth(0.1.sw),
  //                 },
  //                 children: [
  //                   TableRow(
  //                     children: [
  //                       TableCell(
  //                         child: Container(
  //                           alignment: Alignment.centerLeft,
  //                           height: 25,
  //                           child: Text(
  //                             'Prevent same order',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: FontSizes.size11,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       TableCell(
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           height: 25,
  //                           child: Text(
  //                             ':',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: FontSizes.size11,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       TableCell(
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           height: 25,
  //                           child: Text(
  //                             bodyControl.sameOrder.value ? 'ON' : 'OFF',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: FontSizes.size10,
  //                               color: bodyControl.sameOrder.value
  //                                   ? greenOn
  //                                   : Colors.red,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Table(
  //                   columnWidths: {
  //                     0: FixedColumnWidth(0.3.sw),
  //                     1: FixedColumnWidth(0.05.sw),
  //                     2: FixedColumnWidth(0.1.sw),
  //                   },
  //                   children: [
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Randomize Split',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.randomSlit.value ? 'ON' : 'OFF',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                                 color: bodyControl.randomSlit.value
  //                                     ? greenOn
  //                                     : Colors.red,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Price Step',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.aPriceStap.value ? 'ON' : 'OFF',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                                 color: bodyControl.aPriceStap.value
  //                                     ? greenOn
  //                                     : Colors.red,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Auto ${type == 'BUY' ? 'SELL' : "BUY"}',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.aOrder.value ? 'ON' : 'OFF',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                                 color: bodyControl.aOrder.value
  //                                     ? greenOn
  //                                     : Colors.red,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 Table(
  //                   columnWidths: {
  //                     0: FixedColumnWidth(0.13.sw),
  //                     1: FixedColumnWidth(0.05.sw),
  //                     2: FixedColumnWidth(0.08.sw),
  //                   },
  //                   children: [
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Split to',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerRight,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.splitTo.text,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Value',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerRight,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.priceStap.text,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     TableRow(
  //                       children: [
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             height: 25,
  //                             child: Text(
  //                               'Value',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 25,
  //                             child: Text(
  //                               ':',
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         TableCell(
  //                           child: Container(
  //                             alignment: Alignment.centerRight,
  //                             height: 25,
  //                             child: Text(
  //                               bodyControl.autoPrice.text,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: FontSizes.size11,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Expanded(
  //                 child: MainTable(
  //               header: [
  //                 HeaderModel(
  //                   label: Text(
  //                     'Estimation',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: FontSizes.size11,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   alignment: Alignment.center,
  //                 ),
  //                 HeaderModel(
  //                   label: Text(
  //                     'Transaction Fee',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: FontSizes.size11,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   alignment: Alignment.center,
  //                 ),
  //                 HeaderModel(
  //                   label: Text(
  //                     'Nett',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: FontSizes.size11,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   alignment: Alignment.center,
  //                 ),
  //               ],
  //               body: [
  //                 BodyModel(
  //                   body: [
  //                     Container(
  //                       margin: EdgeInsets.only(top: 5.h),
  //                       child: Text(
  //                         formattaCurrun(bodyControl.stockEstimasi()),
  //                         style: TextStyle(
  //                           color: Colors.black.withOpacity(0.8),
  //                           fontSize: FontSizes.size11,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                         textAlign: TextAlign.right,
  //                       ),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(top: 5.h),
  //                       child: Text(
  //                         formattaCurrun(
  //                             bodyControl.fee(type == 'BUY' ? true : false)),
  //                         style: TextStyle(
  //                           color: Colors.red,
  //                           fontSize: FontSizes.size11,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                         textAlign: TextAlign.right,
  //                       ),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(top: 5.h, right: 3.w),
  //                       child: Text(
  //                         formattaCurrun(
  //                             bodyControl.nett(type == 'BUY' ? true : false)),
  //                         style: TextStyle(
  //                           color: type == 'BUY' ? Colors.red : greenOn,
  //                           fontSize: FontSizes.size11,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                         textAlign: TextAlign.right,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ))
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  // );
}
