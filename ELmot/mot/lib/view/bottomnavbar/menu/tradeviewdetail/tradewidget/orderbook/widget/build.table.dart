import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/orderbook_model.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class BuildTableKomponenOrderBook {
  static List<HeaderModel> headers() {
    List<HeaderModel> header = [
      HeaderModel(
        label: Align(
          alignment: Alignment.centerRight,
          child: Text(
            '#',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(
          0.75.w,
        ),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.center,
          child: Text(
            'B.Vol',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.75.w),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.center,
          child: Text(
            'Bid',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.75.w),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.center,
          child: Text(
            'Offer',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.75.w),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.center,
          child: Text(
            'O.Vol',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.75.w),
      ),
      HeaderModel(
        label: Align(
          alignment: Alignment.centerRight,
          child: Text(
            '#',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        widthCol: FlexColumnWidth(0.75.w),
      ),
    ];

    return header;
  }

  static List<BodyModel> buildRow(
      int total, List<Bid> bid, List<Offer> offer, int prevP,
      {void Function(String)? onTapBid, void Function(String)? onTapOffer}) {
    return List.generate(
      total,
      (index) {
        return BodyModel(
          body: [
            Padding(
              padding: EdgeInsets.all(5.w),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  String text =
                      bid[index].bidNqueue == 0 || bid[index].bidNqueue == null
                          ? ""
                          : formattaCurrun(bid[index].bidNqueue!.toInt());

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

                  if (text.length <= 3) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 3 && text.length <= 5) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 5 && text.length <= 7) {
                    fontSize = FontSizes.size10;
                  } else {
                    fontSize = 9.sp;
                  }
                  return Text(
                    text,
                    style: TextStyle(
                      color: Colorss(bid[index].bidPrice, prevP),
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                    maxLines: maxLines,
                    textAlign: TextAlign.right,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  String text = bid[index].bidPrice == 0
                      ? ""
                      : formattaCurrun(bid[index].bidVolume!.toInt());

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
                  if (text.length <= 3) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 3 && text.length <= 5) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 5 && text.length <= 7) {
                    fontSize = FontSizes.size10;
                  } else {
                    fontSize = 9.sp;
                  }
                  return Text(
                    text,
                    style: TextStyle(
                      color: Colorss(bid[index].bidPrice, prevP),
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                    maxLines: maxLines,
                    textAlign: TextAlign.right,
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                onTapBid == null
                    ? null
                    : onTapBid(formattaCurrun(bid[index].bidPrice!.toInt()));
              },
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    String text =
                        bid[index].bidPrice == 0 || bid[index].bidPrice == null
                            ? ""
                            : formattaCurrun(bid[index].bidPrice!.toInt());

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
                      style: TextStyle(
                        color: Colorss(bid[index].bidPrice, prevP),
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                      ),
                      maxLines: maxLines,
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onTapOffer == null
                    ? null
                    : onTapOffer(
                        formattaCurrun(offer[index].offerPrice!.toInt()),
                      );
              },
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    String text = offer[index].offerPrice == 0
                        ? ""
                        : formattaCurrun(offer[index].offerPrice!.toInt());

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
                      style: TextStyle(
                        color: Colorss(
                          offer[index].offerPrice,
                          prevP,
                        ),
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                      ),
                      maxLines: maxLines,
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  String text = offer[index].offerPrice == 0
                      ? ""
                      : formattaCurrun(offer[index].offerVolume!.toInt());

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
                  if (text.length <= 3) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 3 && text.length <= 5) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 5 && text.length <= 7) {
                    fontSize = FontSizes.size10;
                  } else {
                    fontSize = 9.sp;
                  }
                  return Text(
                    text,
                    style: TextStyle(
                      color: Colorss(
                        offer[index].offerPrice,
                        prevP,
                      ),
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                    maxLines: maxLines,
                    textAlign: TextAlign.right,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  String text = offer[index].offerNqueue == 0
                      ? ""
                      : formattaCurrun(offer[index].offerNqueue!.toInt());

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
                  if (text.length <= 3) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 3 && text.length <= 5) {
                    fontSize = FontSizes.size11;
                  } else if (text.length > 5 && text.length <= 7) {
                    fontSize = FontSizes.size10;
                  } else {
                    fontSize = 9.sp;
                  }
                  return Text(
                    text,
                    style: TextStyle(
                      color: Colorss(
                        offer[index].offerPrice,
                        prevP,
                      ),
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                    maxLines: maxLines,
                    textAlign: TextAlign.right,
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
    int total,
    List<Bid> bid,
    List<Offer> offer,
    int prevP, {
    void Function(String)? onTapBid,
    void Function(String)? onTapOffer,
  }) {
    return MainTable(
      isScroll: true,
      widthC: double.infinity,

      // border: 1,
      header: headers(),
      body: buildRow(
        total,
        bid,
        offer,
        prevP,
        onTapBid: onTapBid,
        onTapOffer: onTapOffer,
      ),
    );
  }
}
