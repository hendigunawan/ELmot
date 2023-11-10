import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/tradebook_model.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class BuildTableTradeBook {
  static List<HeaderModel> headers() {
    List<HeaderModel> header = [
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
        widthCol: FlexColumnWidth(0.4.w),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.center,
          child: Text(
            'Freq',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.45.w),
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
        widthCol: FlexColumnWidth(0.5.w),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.center,
          child: Text(
            'Value',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.95.w),
      ),
    ];

    return header;
  }

  static List<BodyModel> bodys(
      List<ArrayTradeBook> data, int prev, BuildContext contextsize) {
    List<ArrayTradeBook> datas = List.filled(
      data.length < 10 ? 10 : data.length,
      ArrayTradeBook(
        price: 0,
        freq: 0,
        value: 0,
        volume: 0,
      ),
    );
    int ints = 0;
    if (data.isEmpty) {
      for (int i = 0; i < 19; i++) {
        datas[ints] = ArrayTradeBook(
          price: 0,
          freq: 0,
          value: 0,
          volume: 0,
        );
      }
    } else {
      for (var e in data) {
        datas[ints] = e;
        ints++;
      }
    }

    return List.generate(
      datas.length,
      (index) {
        return BodyModel(
          body: [
            Padding(
              padding: EdgeInsets.all(5.w),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  String text = datas[index].price != 0
                      ? formattaCurrun(datas[index].price!.toInt())
                      : "";

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
                      color: Colorss(datas[index].price, prev),
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
                  String text = datas[index].freq != 0
                      ? formattaCurrun(datas[index].freq!.toInt())
                      : "           ";

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
                      color: Colorss(datas[index].price, prev),
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
                  String text = datas[index].volume != 0
                      ? formattaCurrun(datas[index].volume!.toInt())
                      : "           ";

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
                      color: Colorss(datas[index].price, prev),
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
                  String text = datas[index].value != 0
                      ? formattaCurrun(datas[index].value!.toInt())
                      : "           ";

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
                      color: Colorss(datas[index].price, prev),
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
  }

  static Widget createTable(
      List<ArrayTradeBook> data, int prev, BuildContext context) {
    return MainTable(
      isScroll: true,
      widthC: double.infinity,

      // border: 1,
      header: BuildTableTradeBook.headers(),
      body: BuildTableTradeBook.bodys(data, prev, context),
    );
  }
}
