// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/fund_withdraw_list.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cash_withdraw_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class FundWithdrawHistoryMain extends StatelessWidget {
  const FundWithdrawHistoryMain({super.key});

  @override
  Widget build(BuildContext context) {
    var dateController = Get.find<DateController>();
    dateController.setStatusDefault();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 5.w,
            top: 7.h,
          ),
          width: 1.sw,
          height: 60.h,
          decoration: BoxDecoration(
            color: bgabu,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PopupMenuButton(
                    elevation: 0,
                    offset: const Offset(0, 0),
                    position: PopupMenuPosition.under,
                    constraints: BoxConstraints.tightFor(
                      height: 90.h,
                      width: 0.28.sw,
                    ),
                    color: foregroundwidget,
                    itemBuilder: (context) => listFundWithDrawList.isEmpty
                        ? []
                        : [
                            PopupMenuItem(
                              height: 35.h,
                              value: '5',
                              child: Center(
                                  child: Text(
                                'All',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size11),
                              )),
                            ),
                            PopupMenuItem(
                              value: '0',
                              height: 35.h,
                              child: Center(
                                  child: Text(
                                'Rejected',
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
                                'Transferring',
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
                                'Transferred',
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
                                'Canceled',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size11),
                              )),
                            ),
                          ],
                    onSelected: (value) async {
                      switch (value) {
                        case '0':
                          dateController.selectedStatus.value = '0';
                          dateController.selectedStatus.refresh();

                        case '1':
                          dateController.selectedStatus.value = '1';
                          dateController.selectedStatus.refresh();
                        case '2':
                          dateController.selectedStatus.value = '2';
                          dateController.selectedStatus.refresh();
                        case '3':
                          dateController.selectedStatus.value = '3';
                          dateController.selectedStatus.refresh();
                        case '4':
                          dateController.selectedStatus.value = '4';
                          dateController.selectedStatus.refresh();
                        case '5':
                          dateController.selectedStatus.value = '5';
                          dateController.selectedStatus.refresh();
                      }
                      String fromDate = dateController.formatDateToyyyyMMdd(
                          dateController.selectedDate.value);
                      String toDate = dateController.formatDateToyyyyMMdd(
                          dateController.selectedToDate.value);
                      await OrderMassage.reqFundWithdrawanListReq(
                        pin: Get.find<PinSave>().pin.value,
                        accountId: accountId.value == ""
                            ? Get.find<LoginOrderController>()
                                .order!
                                .value
                                .account!
                                .first
                                .accountId
                                .toString()
                            : accountId.value,
                        status: int.parse(dateController.selectedStatus.value),
                        fromDate: int.parse(fromDate),
                        toDate: int.parse(toDate),
                      );
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
                                    dateController.selectedStatus.value == '5'
                                        ? 'All'
                                        : dateController.selectedStatus.value ==
                                                '0'
                                            ? 'Rejected'
                                            : dateController
                                                        .selectedStatus.value ==
                                                    '1'
                                                ? 'Open'
                                                : dateController.selectedStatus
                                                            .value ==
                                                        '2'
                                                    ? 'Transfering'
                                                    : dateController
                                                                .selectedStatus
                                                                .value ==
                                                            '3'
                                                        ? 'Transferred'
                                                        : dateController
                                                                    .selectedStatus
                                                                    .value ==
                                                                '4'
                                                            ? 'Canceled'
                                                            : '',
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
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (listFundWithDrawList.isNotEmpty) {
                        dateController.showFromDate(context);
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
                    " to ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSizes.size12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (listFundWithDrawList.isNotEmpty) {
                        dateController.showtoDate(context);
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
              Container(
                margin: EdgeInsets.only(top: 7.h),
                padding: EdgeInsets.only(right: 5.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() {
                    return Text(
                      "Total : ${listFundWithDrawList.isEmpty ? 0 : listFundWithDrawList.first.array!.length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSizes.size13,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (listFundWithDrawList.isEmpty) {
            return Container();
          } else {
            return Expanded(
                child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 0.45.sw,
                rightHandSideColumnWidth: 1.65.sw,
                isFixedHeader: true,
                leftHandSideColBackgroundColor: Colors.black,
                rightHandSideColBackgroundColor: Colors.black,
                headerWidgets: _getHeaderWidget(),
                itemCount: listFundWithDrawList.isEmpty
                    ? 0
                    : listFundWithDrawList.first.array!.length,
                leftSideItemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 66.h,
                        width: 0.1.sw,
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${index + 1}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 66.h,
                        width: 0.1.sw,
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        child: listFundWithDrawList
                                    .first.array![index].status ==
                                1
                            ? GestureDetector(
                                onTap: () {
                                  NotifikasiPopup.showCANCEL(
                                      onSubmit: () {
                                        Navigator.pop(context);

                                        OrderMassage.reqCancelWithdraw(
                                          pin: Get.find<PinSave>().pin.value,
                                          accountId: accountId.value == ""
                                              ? Get.find<LoginOrderController>()
                                                  .order!
                                                  .value
                                                  .account!
                                                  .first
                                                  .accountId
                                                  .toString()
                                              : accountId.value,
                                          funwithdrawid: listFundWithDrawList
                                              .first.array![index].transferId!,
                                        );
                                      },
                                      text:
                                          "Are you sure want to\ncancel this Withdraw?\nTransfer Id: ${listFundWithDrawList.first.array![index].transferId}");
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: 18.sp,
                                  color: Colors.red,
                                ),
                              )
                            : null,
                      ),
                      Container(
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
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
                              child: Text(
                                listFundWithDrawList
                                            .first.array![index].status ==
                                        0
                                    ? 'Rejected'
                                    : listFundWithDrawList
                                                .first.array![index].status ==
                                            1
                                        ? 'Open'
                                        : listFundWithDrawList.first
                                                    .array![index].status ==
                                                2
                                            ? 'Transfering'
                                            : listFundWithDrawList.first
                                                        .array![index].status ==
                                                    3
                                                ? 'Transferred'
                                                : 'Canceled',
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                dateAjaGarisMiring(listFundWithDrawList
                                    .first.array![index].transferDate),
                                maxLines: 1,
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
                rightSideItemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        height: 66.h,
                        width: 0.3.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattaCurrun(listFundWithDrawList
                                    .first.array![index].amount!),
                                maxLines: 1,
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
                                formattaCurrun(listFundWithDrawList
                                    .first.array![index].fee!),
                                maxLines: 1,
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
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        height: 66.h,
                        width: 0.3.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.centerRight,
                              child: Text(
                                listFundWithDrawList.first.array![index].rtgs!
                                    .toString(),
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                listFundWithDrawList.first.array![index]
                                                .executedDate ==
                                            null ||
                                        listFundWithDrawList.first.array![index]
                                                .executedDate! ==
                                            0
                                    ? ''
                                    : dateAjaGarisMiring(listFundWithDrawList
                                        .first.array![index].executedDate),
                                maxLines: 1,
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
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
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
                              child: Text(
                                dateAjaGarisMiring(listFundWithDrawList
                                    .first.array![index].subscribeDate!),
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                listFundWithDrawList.first.array![index]
                                            .subscribeTime ==
                                        0
                                    ? ''
                                    : dateTimeAJa(listFundWithDrawList
                                        .first.array![index].subscribeTime),
                                maxLines: 1,
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
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        height: 66.h,
                        width: 0.4.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                listFundWithDrawList
                                    .first.array![index].bankId!,
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                listFundWithDrawList
                                    .first.array![index].bankAccount!,
                                maxLines: 1,
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
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        height: 66.h,
                        width: 0.4.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                listFundWithDrawList
                                    .first.array![index].inputBy!,
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 3.w),
                                  height: 33.h,
                                  width: 0.35.sw,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${listFundWithDrawList.first.array![index].message}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 5.w),
                                  height: 33.h,
                                  width: 0.05.sw,
                                  alignment: Alignment.center,
                                  child: listFundWithDrawList
                                              .first.array![index].message ==
                                          ''
                                      ? null
                                      : GestureDetector(
                                          onTap: () {
                                            NotifikasiPopup.showINFO(
                                                text:
                                                    "${listFundWithDrawList.first.array![index].message}");
                                          },
                                          child: const FittedBox(
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ));
          }
        }),
      ],
    );
  }
}

List<Widget> _getHeaderWidget() {
  return [
    Row(
      children: [
        Container(
          color: foregroundwidget,
          height: 66.h,
          width: 0.1.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 66.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: 12.sp,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: foregroundwidget,
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
          color: foregroundwidget,
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
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
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
                child: Text(
                  'TF Date',
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
      color: foregroundwidget,
      height: 66.h,
      width: 0.3.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
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
              'Amount',
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
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              'Fee',
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
      color: foregroundwidget,
      height: 66.h,
      width: 0.3.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
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
              'RTGS',
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
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              'Exec Date',
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
      color: foregroundwidget,
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
              'Subs Date',
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
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              'Subs Time',
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
      color: foregroundwidget,
      height: 66.h,
      width: 0.4.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
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
              'Bank Id',
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
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              'Bank Account',
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
      color: foregroundwidget,
      height: 66.h,
      width: 0.4.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
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
              'Input By',
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
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              'Message',
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  ];
}
