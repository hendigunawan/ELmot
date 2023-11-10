import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/streamlist.trading.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class BuildTableRT {
  static List<HeaderModel> header() {
    List<HeaderModel> dataHeader = [
      HeaderModel(
        label: Text(
          'Time',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size12),
        ),
        widthCol: FlexColumnWidth(1.35.w),
        alignment: AlignmentDirectional.center,
      ),
      HeaderModel(
        label: Text(
          'Code',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size12),
        ),
        widthCol: FlexColumnWidth(1.5.w),
        alignment: AlignmentDirectional.center,
      ),
      HeaderModel(
        label: Text(
          'Last',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size12),
        ),
        alignment: AlignmentDirectional.center,
        widthCol: FlexColumnWidth(1.w),
      ),
      HeaderModel(
        label: Text(
          'Chg',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size12),
        ),
        widthCol: FlexColumnWidth(1.2.w),
        alignment: AlignmentDirectional.center,
      ),
      HeaderModel(
        label: Text(
          '%',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size12),
        ),
        widthCol: FlexColumnWidth(0.8.w),
        alignment: AlignmentDirectional.center,
      ),
      HeaderModel(
        label: Text(
          'Volume',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size12),
        ),
        widthCol: FlexColumnWidth(1.1.w),
        alignment: AlignmentDirectional.center,
      ),
    ];
    return dataHeader;
  }

  static List<BodyModel> dataBody(List<RunningTrades> data) {
    List<RunningTrades> datas = List.filled(
      data.isEmpty ? 50 : data.length,
      RunningTrades(
        stockCodeL: 0,
        stockCode: '',
        lastTradedTime: 0,
        tradeId: 0,
        lastPrice: 0,
        volume: 0,
        sectorFlag: 0,
        lastUpdated: 0,
      ),
    );

    int ints = 0;
    if (data.isEmpty) {
      for (int i = 0; i < datas.length; i++) {
        datas[ints] = RunningTrades(
          stockCodeL: 0,
          stockCode: '',
          lastTradedTime: 0,
          tradeId: 0,
          lastPrice: 0,
          volume: 0,
          sectorFlag: 0,
          lastUpdated: 0,
        );
      }
    } else {
      for (var e in data) {
        datas[ints] = e;
        ints++;
      }
    }

    return List.generate(
      datas.length < 10 ? datas.length : datas.length - 9,
      (index) => BodyModel(
        body: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: LayoutBuilder(
              builder: (context, constraints) {
                String text = datas[index].lastTradedTime == 0
                    ? ''
                    : formatJam(
                        datas[index].lastTradedTime.toString(),
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

                fontSize = FontSizes.size11;

                return Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: putihop85,
                    fontWeight: fontWeight,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: LayoutBuilder(
              builder: (context, constraints) {
                String text =
                    datas[index].stockCode == '' ? '' : datas[index].stockCode!;

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

                fontSize = FontSizes.size11;

                return Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: putihop85,
                    fontWeight: fontWeight,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: LayoutBuilder(
              builder: (context, constraints) {
                String text = datas[index].lastPrice == 0
                    ? ''
                    : formattaCurrun(datas[index].lastPrice!);

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

                fontSize = FontSizes.size11;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.right,
                      maxLines: maxLines,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: datas[index].change == null
                            ? null
                            : datas[index].change! < 0
                                ? Colors.red
                                : datas[index].change! == 0
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
            padding: EdgeInsets.all(2.w),
            child: LayoutBuilder(
              builder: (context, constraints) {
                String text = datas[index].change == null
                    ? ''
                    : datas[index].change! < 0
                        ? '${datas[index].change}'
                        : datas[index].change! == 0
                            ? '${datas[index].change}'
                            : '${datas[index].change}';

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

                fontSize = FontSizes.size11;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    datas[index].change == null
                        ? Container()
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              datas[index].change! < 0
                                  ? CupertinoIcons.arrowtriangle_down_fill
                                  : datas[index].change! == 0
                                      ? CupertinoIcons.equal
                                      : CupertinoIcons.arrowtriangle_up_fill,
                              color: datas[index].change == null
                                  ? null
                                  : datas[index].change! < 0
                                      ? Colors.red
                                      : datas[index].change! == 0
                                          ? Colors.yellow
                                          : Colors.green,
                              size: 15.sp,
                            ),
                          ),
                    const Spacer(),
                    Text(
                      text.replaceAll(RegExp(r'-'), ''),
                      textAlign: TextAlign.right,
                      maxLines: maxLines,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: datas[index].change == null
                            ? Colors.white
                            : datas[index].change! < 0
                                ? Colors.red
                                : datas[index].change! == 0
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
            padding: EdgeInsets.all(2.w),
            child: LayoutBuilder(
              builder: (context, constraints) {
                String text = datas[index].chgRate == null
                    ? ''
                    : datas[index].chgRate! < 0
                        ? formattaCurruns(
                            datas[index].chgRate!.toDouble() / 100)
                        : datas[index].change! == 0 ||
                                datas[index].chgRate! == 0
                            ? formattaCurruns(
                                datas[index].chgRate!.toDouble() / 100)
                            : formattaCurruns(
                                datas[index].chgRate!.toDouble() / 100);

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

                fontSize = FontSizes.size11;

                return Text(
                  text.replaceAll(RegExp(r'-'), ''),
                  textAlign: TextAlign.right,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: datas[index].change == null
                        ? null
                        : datas[index].change! < 0
                            ? Colors.red
                            : datas[index].change! == 0
                                ? Colors.yellow
                                : Colors.green,
                    fontWeight: fontWeight,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: LayoutBuilder(
              builder: (context, constraints) {
                String text = datas[index].volume == 0
                    ? ''
                    : formattaCurrun(
                        datas[index].volume!,
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

                fontSize = FontSizes.size11;
                return Text(
                  text,
                  textAlign: TextAlign.right,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: datas[index].tradeFlag == null
                        ? null
                        : datas[index].tradeFlag! == 0
                            ? Colors.red
                            : Colors.green,
                    fontWeight: fontWeight,
                  ),
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: LayoutBuilder(
          //     builder: (context, constraints) {
          //       String text = datas[index].tradeFlag == null
          //           ? ''
          //           : datas[index].tradeFlag == 1
          //               ? 'BID'
          //               : 'OFFER';

          //       int maxLines = 1;
          //       double fontSize = 15;
          //       double scale = 1.0;
          //       FontWeight fontWeight = FontWeight.bold;

          //       final textPainter = TextPainter(
          //         text: TextSpan(
          //             text: text, style: TextStyle(fontSize: fontSize)),
          //         textDirection: TextDirection.ltr,
          //       );

          //       textPainter.layout(maxWidth: double.infinity);

          //       if (constraints.maxWidth < textPainter.width) {
          //         scale = fontSize / 14;
          //       }

          //       return Text(
          //         text,
          //         textAlign: TextAlign.right,
          //         maxLines: maxLines,
          //         style: TextStyle(
          //           fontSize: fontSize,
          //           color: datas[index].change == null
          //               ? null
          //               : datas[index].change! < 0
          //                   ? Colors.red
          //                   : datas[index].change! == 0
          //                       ? Colors.yellow
          //                       : Colors.green,
          //           fontWeight: fontWeight,
          //         ),
          //         textScaleFactor: scale,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
