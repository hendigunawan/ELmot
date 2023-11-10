// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/model/order/breakorder_list.model.dart';
import 'package:online_trading/module/ordering/pkg/order/breakorderlist.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

class WidgetBreakOrderList extends StatelessWidget {
  void Function(ArrayBreakOrderList)? onTapX;
  WidgetBreakOrderList({super.key, this.onTapX});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return HorizontalDataTable(
          elevation: 0,
          rowSeparatorWidget: Divider(
            height: 2.h,
            thickness: 0.05,
          ),
          leftHandSideColumnWidth: 0.6.sw,
          rightHandSideColumnWidth: 2.5.sw,
          isFixedHeader: true,
          leftHandSideColBackgroundColor: Colors.black,
          rightHandSideColBackgroundColor: Colors.black,
          headerWidgets: getHeaderWidget(),
          itemCount: listBreakorderList.isEmpty
              ? 0
              : listBreakorderList.first.array!.length,
          leftSideItemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: 66.h,
                    width: 0.1.sw,
                    color:
                        index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                    child: listBreakorderList.first.array![index].orderstatus ==
                            1
                        ? GestureDetector(
                            onTap: () {
                              onTapX!(listBreakorderList.first.array![index]);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                          )
                        : null),
                Container(
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList.first.array![index].orderstatus ==
                                  0
                              ? 'Rejected'
                              : listBreakorderList
                                          .first.array![index].orderstatus ==
                                      1
                                  ? 'Open'
                                  : listBreakorderList.first.array![index]
                                              .orderstatus ==
                                          2
                                      ? 'Executed'
                                      : 'Withdrawn',
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
                          listBreakorderList.first.array![index].command == 0
                              ? 'Buy'
                              : listBreakorderList
                                          .first.array![index].command ==
                                      1
                                  ? 'Sell'
                                  : listBreakorderList.first.array![index]
                                              .orderstatus ==
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
                    ],
                  ),
                ),
                Container(
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList.first.array![index].stockCode!,
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
                          listBreakorderList.first.array![index].board!,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: putihop85,
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                              listBreakorderList.first.array![index].price!),
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
                            listBreakorderList.first.array![index].volume!,
                          ),
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                  height: 66.h,
                  width: 0.25.sw,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 33.h,
                        alignment: listBreakorderList
                                    .first.array![index].autoPriceStep ==
                                0
                            ? Alignment.center
                            : Alignment.centerRight,
                        child: Text(
                          listBreakorderList
                                      .first.array![index].autoPriceStep ==
                                  0
                              ? 'Not Active'
                              : listBreakorderList
                                  .first.array![index].autoPriceStep
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
                          listBreakorderList.first.array![index].priceType! == 0
                              ? 'Best Bid'
                              : listBreakorderList
                                          .first.array![index].priceType! ==
                                      1
                                  ? 'Best Offer'
                                  : listBreakorderList
                                              .first.array![index].priceType! ==
                                          2
                                      ? 'Last Price'
                                      : 'Avg Price',
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList
                                      .first.array![index].priceCriteria ==
                                  0
                              ? 'Equals (=)'
                              : listBreakorderList
                                          .first.array![index].priceCriteria ==
                                      1
                                  ? 'Lower (<)'
                                  : "Bigger (>)",
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
                          formattaCurrun(listBreakorderList
                              .first.array![index].targetPrice!),
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList.first.array![index].volumeType! ==
                                  0
                              ? 'None'
                              : listBreakorderList
                                          .first.array![index].volumeType! ==
                                      1
                                  ? 'Traded Vol'
                                  : listBreakorderList.first.array![index]
                                              .volumeType! ==
                                          2
                                      ? 'Best Bid Vol'
                                      : 'Best Offer Vol',
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
                          listBreakorderList
                                      .first.array![index].volumeCriteria! <=
                                  0
                              ? 'Lower than (<=)'
                              : "Bigger than (>=)",
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                  height: 66.h,
                  width: 0.25.sw,
                  alignment: Alignment.centerRight,
                  child: Text(
                    formattaCurrun(
                        listBreakorderList.first.array![index].targetVol!),
                    maxLines: 1,
                    style: TextStyle(
                      color: putihop85,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList.first.array![index].orderDate == 0
                              ? ''
                              : dateAjaGarisMiring(listBreakorderList
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
                          listBreakorderList.first.array![index].orderTime == 0
                              ? ''
                              : dateTimeAJa(listBreakorderList
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList.first.array![index].sendDate == 0
                              ? ''
                              : dateAjaGarisMiring(listBreakorderList
                                  .first.array![index].sendDate),
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
                          listBreakorderList.first.array![index].sendTime == 0
                              ? ''
                              : dateTimeAJa(listBreakorderList
                                  .first.array![index].sendTime),
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                  height: 66.h,
                  width: 0.25.sw,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height: 33.h,
                        alignment: Alignment.center,
                        child: Text(
                          listBreakorderList.first.array![index].startDate == 0
                              ? ''
                              : dateAjaGarisMiring(listBreakorderList
                                  .first.array![index].startDate),
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
                          listBreakorderList.first.array![index].startDate == 0
                              ? ''
                              : dateAjaGarisMiring(listBreakorderList
                                  .first.array![index].dueDate),
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                          listBreakorderList.first.array![index].inputUser!,
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
                          listBreakorderList.first.array![index].withdrawBy!,
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
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 0.18.sw,
                              child: Text(
                                " ${listBreakorderList.first.array![index].description!}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0.05.sw,
                              child: listBreakorderList
                                          .first.array![index].description ==
                                      ''
                                  ? null
                                  : GestureDetector(
                                      onTap: () {
                                        NotifikasiPopup.showINFO(
                                            text:
                                                '${listBreakorderList.first.array![index].description}');
                                      },
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.blue,
                                        size: 16.sp,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 33.h,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 0.18.sw,
                              child: Text(
                                " ${listBreakorderList.first.array![index].resultNote!}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0.05.sw,
                              child: listBreakorderList
                                          .first.array![index].resultNote! ==
                                      ''
                                  ? null
                                  : GestureDetector(
                                      onTap: () {
                                        NotifikasiPopup.showINFO(
                                            text:
                                                '${listBreakorderList.first.array![index].resultNote}');
                                      },
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.blue,
                                        size: 16.sp,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    });
  }
}

const List<String> breakOrderData = [
  'Status',
  'Command',
  'Stockcode',
  'Board',
  'Price',
  'Volume',
  'Auto PS',
  'Price Type',
  'Price Criteria',
  'Target Price',
  'Volume Type',
  'Volume Criteria',
  'Target Volume',
  'Order Date',
  'Order Time',
  'Send Date',
  'Send Time',
  'Start Date',
  'Due Date',
  'Input User',
  'Withdraw By',
  'Description',
  'Result Note'
];

List<Widget> getHeaderWidget() {
  List<String> dataHeader = breakOrderData.sublist(4);
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
                  ),
                ),
                child: Text(
                  breakOrderData[0],
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
                  breakOrderData[1],
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
                    ),
                  ),
                ),
                child: Text(
                  breakOrderData[2],
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
                  ),
                ),
                child: Text(
                  breakOrderData[3],
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
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[0],
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
              dataHeader[1],
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
              dataHeader[2],
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
              dataHeader[3],
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
              dataHeader[4],
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
              dataHeader[5],
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
              dataHeader[6],
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
              dataHeader[7],
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
      child: Container(
        height: 66.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 1.w,
          ),
        )),
        child: Text(
          dataHeader[8],
          style: TextStyle(
            color: putihop85,
            fontSize: 12.sp,
          ),
        ),
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
              dataHeader[9],
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
              dataHeader[10],
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
              dataHeader[11],
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
              dataHeader[12],
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
              dataHeader[13],
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
              dataHeader[14],
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
              dataHeader[15],
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
              dataHeader[16],
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
              dataHeader[17],
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
              dataHeader[18],
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
