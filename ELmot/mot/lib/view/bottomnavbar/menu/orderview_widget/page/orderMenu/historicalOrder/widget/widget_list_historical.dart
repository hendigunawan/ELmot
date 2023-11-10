import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/pkg/order/historical_orderlist.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

class WidgetListHistoricalOrder extends StatelessWidget {
  const WidgetListHistoricalOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Obx(() {
          return HorizontalDataTable(
            leftHandSideColumnWidth: 0.35.sw,
            rightHandSideColumnWidth: 1.775.sw,
            isFixedHeader: true,
            headerWidgets: _getHeaderWidget(),
            leftHandSideColBackgroundColor: Colors.black,
            rightHandSideColBackgroundColor: Colors.black,
            itemCount:
                listHistorical.isEmpty ? 0 : listHistorical.first.array!.length,
            leftSideItemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 66.h,
                    width: 0.1.sw,
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                            listHistorical.first.array![index].orderStatus == 0
                                ? 'Rejected'
                                : listHistorical
                                            .first.array![index].orderStatus ==
                                        1
                                    ? 'Open'
                                    : listHistorical.first.array![index]
                                                .orderStatus ==
                                            2
                                        ? 'Matched'
                                        : listHistorical.first.array![index]
                                                    .orderStatus ==
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
                            listHistorical.first.array![index].orderId!,
                            maxLines: 1,
                            style: TextStyle(
                              color: putihop85,
                              fontSize: 10.sp,
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                            listHistorical.first.array![index].stockCode!,
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
                            listHistorical.first.array![index].boardMarketCode!,
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                            listHistorical.first.array![index].orderDate == 0
                                ? ''
                                : dateAjaGarisMiring(listHistorical
                                    .first.array![index].orderDate),
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
                            listHistorical.first.array![index].orderTime == 0
                                ? ''
                                : dateTimeAJa(listHistorical
                                    .first.array![index].orderTime),
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                    height: 66.h,
                    width: 0.225.sw,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 33.h,
                          alignment: Alignment.center,
                          child: Text(
                            listHistorical.first.array![index].command! == 0
                                ? 'Buy Order'
                                : listHistorical.first.array![index].command! ==
                                        1
                                    ? 'Sell Order'
                                    : listHistorical
                                                .first.array![index].command! ==
                                            2
                                        ? 'Margin Buy'
                                        : 'Short Sell',
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
                            listHistorical.first.array![index].command == null
                                ? ''
                                : listHistorical.first.array![index].command! ==
                                        0
                                    ? 'Day Order'
                                    : 'Session Order',
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                            dateTimeAJa(
                                listHistorical.first.array![index].sentTime),
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
                            listHistorical.first.array![index].exchangeCode!,
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          child: Text(
                            formattaCurrun(
                                listHistorical.first.array![index].price!),
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
                            formattaCurrun(
                                listHistorical.first.array![index].oVolume!),
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          child: Text(
                            formattaCurrun(
                                listHistorical.first.array![index].rVolume!),
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
                            formattaCurrun(
                                listHistorical.first.array![index].tVolume!),
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
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          child: Text(
                            listHistorical.first.array![index].inputUser!,
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
                              padding: EdgeInsets.only(left: 5.w),
                              height: 33.h,
                              width: 0.25.sw,
                              alignment: Alignment.center,
                              child: Text(
                                listHistorical.first.array![index].rejectNote ==
                                            '' ||
                                        listHistorical.first.array![index]
                                                .rejectNote ==
                                            null
                                    ? ''
                                    : listHistorical
                                        .first.array![index].rejectNote!,
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
                              child: listHistorical
                                              .first.array![index].rejectNote ==
                                          '' ||
                                      listHistorical
                                              .first.array![index].rejectNote ==
                                          null
                                  ? null
                                  : GestureDetector(
                                      onTap: () {
                                        NotifikasiPopup.showINFO(
                                            text: listHistorical.first
                                                .array![index].rejectNote!);
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
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }));
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
                    right: BorderSide(
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
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  'Order Id',
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
              'Stockcode',
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
              'Order Date',
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
              'Order Time',
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
      width: 0.225.sw,
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
              'Command',
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
              'Expiry',
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
              'Sent Time',
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
              'Exchange Code',
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
              'Price',
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
              'O Volume',
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
              'R Volume',
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
              'T Volume',
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
              'Input User',
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
              'Reject Note',
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
