import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

class CardVertical extends StatelessWidget {
  final String? time;
  final String? stockCode;
  final String? stockName;
  final String? spesialnotasi;

  final String? detailspesialnotasi;
  final int? last;
  final int? prev;
  final int? change;
  final int? freq;
  final int? vol;
  final int? high;
  final int? low;
  final int? changerate;

  const CardVertical({
    this.stockCode = '',
    this.stockName = '',
    this.last,
    this.freq,
    this.prev,
    this.change = 0,
    super.key,
    this.spesialnotasi = '',
    this.detailspesialnotasi = '',
    this.vol,
    this.changerate = 0,
    this.high,
    this.low,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final openBox = ObjectBoxDatabase.stockList;
    String getTitile() {
      var query = openBox
          .query(PackageStockList_.stcokCode.equals(stockCode!))
          .build()
          .findFirst();
      if (query != null) {
        return query.stockName!;
      } else {
        return '';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/detailview',
          arguments: <String, String>{
            'title': stockCode.toString(),
            'subtitle': stockName == '' ? getTitile() : stockName.toString(),
            'board': 'RG',
          },
        );
      },
      child: Card(
        color: bgabu,
        borderOnForeground: true,
        child: Container(
          height: 60.h,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: [
              time == null
                  ? Container()
                  : Center(
                      child: Text(
                        time!,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: FontSizes.size11,
                        ),
                      ),
                    ),
              Flexible(
                child: cardSebelahKiri(context),
              ),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                flex: 2,
                child: cardSebelahKanan(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardSebelahKiri(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (context) {
            return Container(
              alignment: Alignment.center,
              width: 0.22.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        stockCode.toString(),
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size11),
                      ),
                      const Spacer(),
                      detailspesialnotasi == null || detailspesialnotasi == ''
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                NotifikasiPopup.showINFO(
                                  text: detailspesialnotasi.toString(),
                                );
                              },
                              child: Icon(
                                Icons.info_outline,
                                color: Colors.lightBlue,
                                size: 14.sp,
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    stockName.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size11),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget cardSebelahKanan(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 0.25.sw,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "High:",
                      style: TextStyle(
                          color: high == null || prev == null
                              ? putihop85
                              : ColorsAvg(
                                  high!.toDouble(),
                                  prev!.toDouble(),
                                ),
                          fontSize: FontSizes.size11),
                    ),
                    const Spacer(),
                    Text(
                      high == null ? '' : formattaCurrun(high!),
                      style: TextStyle(
                        color: high == null || prev == null
                            ? putihop85
                            : ColorsAvg(
                                high!.toDouble(),
                                prev!.toDouble(),
                              ),
                        fontSize: FontSizes.size11,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last:',
                      style: TextStyle(
                          color: last == null || prev == null
                              ? putihop85
                              : ColorsAvg(
                                  last!.toDouble(),
                                  prev!.toDouble(),
                                ),
                          fontSize: FontSizes.size11),
                    ),
                    const Spacer(),
                    Text(
                      last == null
                          ? ''
                          : formattaCurrun(last == null ? 0 : last!),
                      style: TextStyle(
                          color: last == null || prev == null
                              ? putihop85
                              : ColorsAvg(
                                  last!.toDouble(),
                                  prev!.toDouble(),
                                ),
                          fontSize: FontSizes.size11),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Freq:',
                      style: TextStyle(
                          color: putihop85, fontSize: FontSizes.size11),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Get.width * 0.1,
                      child: Text(
                        formattaCurrun(freq == null ? 0 : freq!),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size11),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          alignment: Alignment.center,
          width: 0.35.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Low:",
                    style: TextStyle(
                        color: low == null || prev == null
                            ? putihop85
                            : ColorsAvg(
                                low!.toDouble(),
                                prev!.toDouble(),
                              ),
                        fontSize: FontSizes.size11),
                  ),
                  const Spacer(),
                  Text(
                    low == null ? '' : formattaCurrun(low!),
                    style: TextStyle(
                      color: low == null || prev == null
                          ? putihop85
                          : ColorsAvg(
                              low!.toDouble(),
                              prev!.toDouble(),
                            ),
                      fontSize: FontSizes.size11,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Chg: ",
                    style: TextStyle(
                        color: changerate!.toInt() < 0
                            ? Colors.red
                            : changerate!.toInt() == 0
                                ? Colors.yellow
                                : Colors.green,
                        fontSize: FontSizes.size11),
                  ),
                  const Spacer(),
                  Text(
                    change! > 0 || changerate! > 0
                        ? '+$change (+${changerate!.toDouble() / 100}%)'
                        : '$change (${changerate!.toDouble() / 100}%)',
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: changerate!.toInt() < 0
                            ? Colors.red
                            : changerate!.toInt() == 0
                                ? Colors.yellow
                                : Colors.green,
                        fontSize: FontSizes.size11),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Vol:",
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size11),
                  ),
                  const Spacer(),
                  Text(
                    vol == null ? '' : formattaCurrun(vol == null ? 0 : vol!),
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
