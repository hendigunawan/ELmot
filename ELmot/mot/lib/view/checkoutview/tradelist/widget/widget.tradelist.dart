import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';

import '../../../widget/formattacurrency.dart';

class WidgetTradeList extends StatelessWidget {
  const WidgetTradeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Obx(
          () {
            return HorizontalDataTable(
              leftHandSideColumnWidth: 0.35.sw,
              rightHandSideColumnWidth: 1.sw,
              isFixedHeader: true,
              headerWidgets: _getHeaderWidget(),
              leftHandSideColBackgroundColor: Colors.transparent,
              rightHandSideColBackgroundColor: Colors.transparent,
              itemCount:
                  listTradeList.isEmpty ? 0 : listTradeList.first.array!.length,
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
                              listTradeList.first.array![index].command == 0
                                  ? 'Buy Order'
                                  : listTradeList.first.array![index].command ==
                                          1
                                      ? 'Sell Order'
                                      : listTradeList.first.array![index]
                                                  .command ==
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
                              listTradeList.first.array![index].orderId!,
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
                              listTradeList.first.array![index].stockCode!,
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
                              listTradeList.first.array![index].board!,
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
                              listTradeList.first.array![index].tradeDate == 0
                                  ? ''
                                  : dateAjaGarisMiring(listTradeList
                                      .first.array![index].tradeDate),
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
                              listTradeList.first.array![index].tradeTime == 0
                                  ? ''
                                  : dateTimeAJa(listTradeList
                                      .first.array![index].tradeTime),
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
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  listTradeList.first.array![index].price!),
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
                                  listTradeList.first.array![index].volume!),
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
                              listTradeList.first.array![index].exchangeCode!,
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
                              listTradeList.first.array![index].expiry! == 0
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
                  ],
                );
              },
            );
          },
        ));
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
              'Trade Date',
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
              'Trade Time',
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
              'Volume',
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
              'Ex Code',
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
  ];
}
