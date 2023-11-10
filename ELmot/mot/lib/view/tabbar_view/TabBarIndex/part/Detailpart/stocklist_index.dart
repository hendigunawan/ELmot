import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/GetxController/stockmember_indexcontroller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/helper.dart';

class StockListIndex extends StatelessWidget {
  final String indexCode;
  const StockListIndex({super.key, required this.indexCode});

  @override
  Widget build(BuildContext context) {
    StockMemberIndexController con = Get.put(StockMemberIndexController());

    return con.obx(
      (state) {
        var data = con.dataQuotesselected;
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
            leftHandSideColumnWidth: 0.5.sw,
            rightHandSideColumnWidth: 1.05.sw,
            isFixedHeader: true,
            headerWidgets: _getHeaderWidget(),
            leftSideItemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: 0.3.sw,
                      height: 20.h,
                      color: Colors.black,
                      child: Text(
                        data[index].stockCode.toString(),
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 0.2.sw,
                    height: 20.h,
                    color: Colors.black,
                    child: Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Icon(
                            data[index].change!.toInt() == 0
                                ? CupertinoIcons.equal
                                : data[index].change!.toInt() > 0
                                    ? CupertinoIcons.arrowtriangle_up_fill
                                    : CupertinoIcons.arrowtriangle_down_fill,
                            color: data[index].change!.toInt() < 0
                                ? Colors.red
                                : data[index].change!.toInt() == 0
                                    ? Colors.yellow
                                    : Colors.green,
                            size: 13.sp,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          maxLines: 1,
                          formattaCurrun(
                            data[index].lastPrice!.toInt(),
                          ),
                          style: TextStyle(
                            color: Colorss(
                              data[index].lastPrice,
                              data[index].prevPrice,
                            ),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  )
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
                        width: 0.3.sw,
                        height: 20.h,
                        color: Colors.black,
                        child: Text(
                          "${formattaCurrun(data[index].change!.toInt())} (${formataCurrun(data[index].chgRate!.toInt())}%)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: 0.15.sw,
                          height: 20.h,
                          color: Colors.black,
                          child: Text(
                            formattaCurrun(
                              data[index].bestBidPrice!.toInt(),
                            ),
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: 0.15.sw,
                          height: 20.h,
                          color: Colors.black,
                          child: Text(
                            formattaCurrun(
                              data[index].bestOfferPrice!.toInt(),
                            ),
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: 0.15.sw,
                          height: 20.h,
                          color: Colors.black,
                          child: Text(
                            formattaCurrun(
                              data[index].openPrice!.toInt(),
                            ),
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          width: 0.15.sw,
                          height: 20.h,
                          color: Colors.black,
                          child: Text(
                            formattaCurrun(
                              data[index].hiPrice!.toInt(),
                            ),
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                      Container(
                          padding: EdgeInsets.only(right: 3.w),
                          alignment: Alignment.centerRight,
                          width: 0.15.sw,
                          height: 20.h,
                          color: Colors.black,
                          child: Text(
                            formattaCurrun(
                              data[index].loPrice!.toInt(),
                            ),
                            maxLines: 1,
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )),
                    ],
                  );
                }),
              );
            },
            itemCount: data.length,
            rightHandSideColBackgroundColor: Colors.black,
          ),
        );
      },
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
          width: 0.3.sw,
          color: foregroundwidget,
          child: Text(
            'Code',
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
            'Price',
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
      width: 0.3.sw,
      height: 33.h,
      color: foregroundwidget,
      child: Text(
        'Change',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      width: 0.15.sw,
      height: 33.h,
      color: foregroundwidget,
      child: Text(
        'Bid',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      width: 0.15.sw,
      height: 33.h,
      color: foregroundwidget,
      child: Text(
        'Offer',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      width: 0.15.sw,
      height: 33.h,
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
      width: 0.15.sw,
      height: 33.h,
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
      width: 0.15.sw,
      height: 33.h,
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
  ];
}
