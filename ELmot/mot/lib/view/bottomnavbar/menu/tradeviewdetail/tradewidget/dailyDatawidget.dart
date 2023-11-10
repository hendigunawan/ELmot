// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/dailychartdata_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';

class DailyDataWidget extends StatelessWidget {
  final String title;
  List<DailyChartDataModel>? data;
  DailyDataWidget({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: HorizontalDataTable(
        elevation: 0,
        elevationColor: Colors.transparent,
        rowSeparatorWidget: Divider(
          height: 2.h,
          thickness: 0.05,
        ),
        leftHandSideColBackgroundColor: Colors.black,
        leftHandSideColumnWidth: 0.48.sw,
        rightHandSideColumnWidth: 0.9.sw,
        isFixedHeader: true,
        headerWidgets: _getHeaderWidget(),
        leftSideItemBuilder: (context, index) {
          Color color = Colorss(
            data!.first.arrayDailyChartList[index].closePrice,
            data!.first.arrayDailyChartList[index].openPrice,
          );

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 0.25.sw,
                height: 20.h,
                color: Colors.black,
                child: Text(
                  dateAjaGarisMiring(
                      data!.first.arrayDailyChartList[index].date),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 11.sp,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  width: 0.23.sw,
                  height: 20.h,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(
                            data!.first.arrayDailyChartList[index]
                                        .closePrice! ==
                                    data!.first.arrayDailyChartList[index]
                                        .openPrice
                                ? CupertinoIcons.equal
                                : data!.first.arrayDailyChartList[index]
                                            .closePrice! >
                                        data!.first.arrayDailyChartList[index]
                                            .openPrice!
                                    ? CupertinoIcons.arrowtriangle_up_fill
                                    : CupertinoIcons.arrowtriangle_down_fill,
                            color: color,
                            size: 15.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formattaCurrun(
                          data!.first.arrayDailyChartList[index].closePrice!
                              .toInt(),
                        ),
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  )),
            ],
          );
        },
        rightSideItemBuilder: (context, index) {
          Color color = Colorss(
            data!.first.arrayDailyChartList[index].closePrice!,
            data!.first.arrayDailyChartList[index].openPrice,
          );
          return Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: 0.2.sw,
                height: 20.h,
                color: Colors.black,
                child: Text(
                  formattaCurrun(
                    data!.first.arrayDailyChartList[index].openPrice!.toInt(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 11.sp,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 0.2.sw,
                height: 20.h,
                color: Colors.black,
                child: Text(
                  formattaCurrun(
                    data!.first.arrayDailyChartList[index].highPrice!.toInt(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 11.sp,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 0.2.sw,
                height: 20.h,
                color: Colors.black,
                child: Text(
                  formattaCurrun(
                    data!.first.arrayDailyChartList[index].lowPrice!.toInt(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 11.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w),
                alignment: Alignment.centerRight,
                width: 0.3.sw,
                height: 20.h,
                color: Colors.black,
                child: Text(
                  formattaCurrun(
                    data!.first.arrayDailyChartList[index].volume!.toInt(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: data == null || data!.isEmpty
            ? 0
            : data!.first.arrayDailyChartList.length,
        rightHandSideColBackgroundColor: Colors.black,
      ),
    );
  }
}

List<Widget> _getHeaderWidget() {
  return [
    Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 33.h,
          width: 0.25.sw,
          color: foregroundwidget,
          child: Text(
            'Date',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 33.h,
          width: 0.23.sw,
          color: foregroundwidget,
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
      ],
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.2.sw,
      color: foregroundwidget,
      child: Text(
        'Open',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.2.sw,
      color: foregroundwidget,
      child: Text(
        'High',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.2.sw,
      color: foregroundwidget,
      child: Text(
        'Low',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Vol',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
  ];
}

Stream<List<DailyChartDataModel>> getDailySortbyDate(
    String stockCode, String board) {
  final open = ObjectBoxDatabase.dailyChartDataBox;
  final stream = open.query(
    DailyChartDataModel_.stockCode.equals(stockCode) &
        DailyChartDataModel_.board.equals(board),
  );
  return stream.watch(triggerImmediately: true).map((event) => event.find());
}
