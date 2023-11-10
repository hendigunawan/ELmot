// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';
import 'package:online_trading/view/tabbar_view/tradingView/controller/runningtrade.controller.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/streamlist.trading.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class RunningTradeWidget extends StatelessWidget {
  const RunningTradeWidget({super.key, this.stockCsearch});
  final String? stockCsearch;

  @override
  Widget build(BuildContext context) {
    var getRunning = Get.find<RunningTradeController>();
    getRunning.querys.value = stockCsearch!;

    return Obx(
      () {
        List<RunningTrades> dataSource1 =
            getRunning.listQuery.reversed.toList();
        List<BodyModel> rows = dataSource1.isEmpty
            ? []
            : List.generate(
                dataSource1.length,
                (index) {
                  return BodyModel(
                    body: [
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            String text = dataSource1[index].lastTradedTime ==
                                        0 ||
                                    dataSource1[index].lastTradedTime == null
                                ? ''
                                : formatJam(
                                    dataSource1[index]
                                        .lastTradedTime
                                        .toString(),
                                  );

                            int maxLines = 1;
                            double fontSize = FontSizes.size12;
                            FontWeight fontWeight = FontWeight.bold;

                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(fontSize: fontSize),
                              ),
                              textDirection: TextDirection.ltr,
                            );

                            textPainter.layout(maxWidth: double.infinity);
                            if (text.length <= 5) {
                              fontSize = FontSizes.size12;
                            } else {
                              fontSize = FontSizes.size11;
                            }
                            return Text(
                              text,
                              textAlign: TextAlign.center,
                              maxLines: maxLines,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: Colors.white,
                                fontWeight: fontWeight,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            String text = dataSource1[index].lastPrice == 0
                                ? ''
                                : formattaCurrun(dataSource1[index].lastPrice!);

                            int maxLines = 1;
                            double fontSize = FontSizes.size12;
                            FontWeight fontWeight = FontWeight.bold;

                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(fontSize: fontSize),
                              ),
                              textDirection: TextDirection.ltr,
                            );

                            textPainter.layout(maxWidth: double.infinity);
                            if (text.length <= 5) {
                              fontSize = FontSizes.size12;
                            } else {
                              fontSize = FontSizes.size11;
                            }
                            return Text(
                              text,
                              textAlign: TextAlign.right,
                              maxLines: maxLines,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: dataSource1[index].change == null
                                    ? null
                                    : dataSource1[index].change! < 0
                                        ? Colors.red
                                        : dataSource1[index].change! == 0
                                            ? Colors.yellow
                                            : Colors.green,
                                fontWeight: fontWeight,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            String text = dataSource1[index].change == null
                                ? ''
                                : dataSource1[index].change! < 0
                                    ? '${dataSource1[index].change}'
                                    : dataSource1[index].change! == 0
                                        ? '${dataSource1[index].change}'
                                        : '${dataSource1[index].change}';

                            int maxLines = 1;
                            double fontSize = FontSizes.size12;
                            FontWeight fontWeight = FontWeight.bold;

                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(fontSize: fontSize),
                              ),
                              textDirection: TextDirection.ltr,
                            );

                            textPainter.layout(maxWidth: double.infinity);
                            if (text.length <= 5) {
                              fontSize = FontSizes.size12;
                            } else {
                              fontSize = FontSizes.size11;
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                dataSource1[index].change == null
                                    ? Container()
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Icon(
                                          dataSource1[index].change! < 0
                                              ? CupertinoIcons
                                                  .arrowtriangle_down_fill
                                              : dataSource1[index].change! == 0
                                                  ? CupertinoIcons.equal
                                                  : CupertinoIcons
                                                      .arrowtriangle_up_fill,
                                          color: dataSource1[index].change ==
                                                  null
                                              ? null
                                              : dataSource1[index].change! < 0
                                                  ? Colors.red
                                                  : dataSource1[index]
                                                              .change! ==
                                                          0
                                                      ? Colors.yellow
                                                      : Colors.green,
                                          size: 12.5.sp,
                                        ),
                                      ),
                                const Spacer(),
                                Text(
                                  text.replaceAll(RegExp(r'-'), ''),
                                  textAlign: TextAlign.right,
                                  maxLines: maxLines,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: dataSource1[index].change == null
                                        ? null
                                        : dataSource1[index].change! < 0
                                            ? Colors.red
                                            : dataSource1[index].change! == 0
                                                ? Colors.yellow
                                                : Colors.green,
                                    fontWeight: fontWeight,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            String text = dataSource1[index].chgRate == null
                                ? ''
                                : dataSource1[index].chgRate! < 0
                                    ? formattaCurruns(
                                        dataSource1[index].chgRate!.toDouble() /
                                            100)
                                    : dataSource1[index].change! == 0 ||
                                            dataSource1[index].chgRate! == 0
                                        ? formattaCurruns(dataSource1[index]
                                                .chgRate!
                                                .toDouble() /
                                            100)
                                        : formattaCurruns(dataSource1[index]
                                                .chgRate!
                                                .toDouble() /
                                            100);

                            int maxLines = 1;
                            double fontSize = FontSizes.size12;
                            FontWeight fontWeight = FontWeight.bold;

                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(fontSize: fontSize),
                              ),
                              textDirection: TextDirection.ltr,
                            );

                            textPainter.layout(maxWidth: double.infinity);
                            if (text.length <= 5) {
                              fontSize = FontSizes.size12;
                            } else {
                              fontSize = FontSizes.size11;
                            }
                            return Text(
                              text.replaceAll(RegExp(r'-'), ''),
                              textAlign: TextAlign.right,
                              maxLines: maxLines,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: dataSource1[index].change == null
                                    ? null
                                    : dataSource1[index].change! < 0
                                        ? Colors.red
                                        : dataSource1[index].change! == 0
                                            ? Colors.yellow
                                            : Colors.green,
                                fontWeight: fontWeight,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            String text = dataSource1[index].volume == 0
                                ? ''
                                : formattaCurrun(
                                    dataSource1[index].volume!,
                                  );

                            int maxLines = 1;
                            double fontSize = FontSizes.size12;
                            FontWeight fontWeight = FontWeight.bold;

                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: text,
                                style: TextStyle(fontSize: fontSize),
                              ),
                              textDirection: TextDirection.ltr,
                            );

                            textPainter.layout(maxWidth: double.infinity);
                            if (text.length <= 5) {
                              fontSize = FontSizes.size12;
                            } else {
                              fontSize = FontSizes.size11;
                            }
                            return Text(
                              text,
                              textAlign: TextAlign.right,
                              maxLines: maxLines,
                              style: TextStyle(
                                fontSize: fontSize,
                                color: dataSource1[index].tradeFlag == null
                                    ? null
                                    : dataSource1[index].tradeFlag! == 0
                                        ? Colors.red
                                        : Colors.green,
                                fontWeight: fontWeight,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
        return MainTable(
          widthC: double.infinity,
          header: [
            HeaderModel(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              widthCol: FlexColumnWidth(0.8.w),
            ),
            HeaderModel(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Price',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              widthCol: FlexColumnWidth(0.5.w),
            ),
            HeaderModel(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              widthCol: FlexColumnWidth(0.6.w),
            ),
            HeaderModel(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  '%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              widthCol: FlexColumnWidth(0.6.w),
            ),
            HeaderModel(
              label: Align(
                alignment: Alignment.center,
                child: Text(
                  'Volume',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizes.size12,
                  ),
                ),
              ),
              widthCol: FlexColumnWidth(0.8.w),
            ),
          ],
          body: rows,
        );
      },
    );
  }
}

class getDataList {
  static late List<RunningTrades> dataARR;

  static Future<void> getArray(int lenght, List<RunningTrades> data) async {
    Future.sync(() {
      return dataARR = List.generate(
        lenght,
        (index) {
          if (index < data.length) {
            return data[index];
          } else {
            return RunningTrades()..lastTradedTime = 0;
          }
        },
      );
    });
  }
}
