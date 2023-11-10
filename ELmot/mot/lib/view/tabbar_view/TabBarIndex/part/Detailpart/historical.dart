import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';

class HistoricalMain extends StatelessWidget {
  final String indexCode;
  const HistoricalMain({super.key, required this.indexCode});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ObjectBoxDatabase.streamChart(indexCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style:
                    TextStyle(color: Colors.white, fontSize: FontSizes.size13),
              ),
            );
          } else {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
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
                  leftHandSideColumnWidth: 0.43.sw,
                  rightHandSideColumnWidth: 0.9.sw,
                  isFixedHeader: true,
                  headerWidgets: _getHeaderWidget(),
                  leftSideItemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: 0.23.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              "",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                              ),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: 0.2.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text("",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 11.sp, color: Colors.white))),
                      ],
                    );
                  },
                  rightSideItemBuilder: (context, index) {
                    return Row(
                      children: List.generate(1, (i) {
                        return Row(
                          children: [
                            Container(
                                alignment: Alignment.centerRight,
                                width: 0.2.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text(
                                  "",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 11.sp, color: Colors.white),
                                )),
                            Container(
                                alignment: Alignment.centerRight,
                                width: 0.2.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text(
                                  "",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 11.sp, color: Colors.white),
                                )),
                            Container(
                                alignment: Alignment.centerRight,
                                width: 0.2.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text(
                                  "",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 11.sp, color: Colors.white),
                                )),
                            Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 5.w),
                                width: 0.3.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text("",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 11.sp, color: Colors.white))),
                          ],
                        );
                      }),
                    );
                  },
                  itemCount: 0,
                  rightHandSideColBackgroundColor: Colors.black,
                ),
              );
            } else {
              var data = snapshot.data!;
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
                  leftHandSideColumnWidth: 0.43.sw,
                  rightHandSideColumnWidth: 0.9.sw,
                  isFixedHeader: true,
                  headerWidgets: _getHeaderWidget(),
                  leftSideItemBuilder: (context, index) {
                    DateTime dates = DateTime.fromMillisecondsSinceEpoch(date(
                        data.first.arraydailyindexchartdatasList[index].date
                            .toString()));
                    String formatse = DateFormat('dd-MM-yyyy').format(dates);
                    return Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: 0.23.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              formatse,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: putihop85,
                                fontSize: 11.sp,
                              ),
                            )),
                        Container(
                            alignment: Alignment.centerRight,
                            width: 0.2.sw,
                            height: 20.h,
                            color: Colors.black,
                            child: Text(
                              "${formatIndex4k(data.first.arraydailyindexchartdatasList[index].closePrice!.toDouble())}",
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                color: Colorss(
                                  data
                                      .first
                                      .arraydailyindexchartdatasList[index]
                                      .closePrice!
                                      .toInt(),
                                  data
                                      .first
                                      .arraydailyindexchartdatasList[index]
                                      .openPrice!
                                      .toInt(),
                                ),
                              ),
                            )),
                      ],
                    );
                  },
                  rightSideItemBuilder: (context, index) {
                    return Row(
                      children: List.generate(1, (i) {
                        return Row(
                          children: [
                            Container(
                                alignment: Alignment.centerRight,
                                width: 0.2.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text(
                                  "${formatIndex4k(data.first.arraydailyindexchartdatasList[index].openPrice!.toDouble())}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                    color: Colorss(
                                      data
                                          .first
                                          .arraydailyindexchartdatasList[index]
                                          .closePrice!
                                          .toInt(),
                                      data
                                          .first
                                          .arraydailyindexchartdatasList[index]
                                          .openPrice!
                                          .toInt(),
                                    ),
                                  ),
                                )),
                            Container(
                                alignment: Alignment.centerRight,
                                width: 0.2.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text(
                                  "${formatIndex4k(data.first.arraydailyindexchartdatasList[index].highPrice!.toDouble())}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                    color: Colorss(
                                      data
                                          .first
                                          .arraydailyindexchartdatasList[index]
                                          .closePrice!
                                          .toInt(),
                                      data
                                          .first
                                          .arraydailyindexchartdatasList[index]
                                          .openPrice!
                                          .toInt(),
                                    ),
                                  ),
                                )),
                            Container(
                                alignment: Alignment.centerRight,
                                width: 0.2.sw,
                                height: 20.h,
                                color: Colors.black,
                                child: Text(
                                  "${formatIndex4k(data.first.arraydailyindexchartdatasList[index].lowPrice!.toDouble())}",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                    color: Colorss(
                                      data
                                          .first
                                          .arraydailyindexchartdatasList[index]
                                          .closePrice!
                                          .toInt(),
                                      data
                                          .first
                                          .arraydailyindexchartdatasList[index]
                                          .openPrice!
                                          .toInt(),
                                    ),
                                  ),
                                )),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 5.w),
                              width: 0.3.sw,
                              height: 20.h,
                              color: Colors.black,
                              child: Text(
                                "${formatIndex4k(data.first.arraydailyindexchartdatasList[index].volume!.toDouble())}",
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                    color: putihop85),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                  itemCount: data.first.arraydailyindexchartdatasList.length,
                  rightHandSideColBackgroundColor: Colors.black,
                ),
              );
            }
          }
        });
  }
}

List<Widget> _getHeaderWidget() {
  return [
    Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 33.h,
          width: 0.23.sw,
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
          width: 0.2.sw,
          color: foregroundwidget,
          child: Text(
            'Last',
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
