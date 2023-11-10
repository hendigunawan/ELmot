import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/model/info/portopolioreturn.model.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolioreturn.pkg.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';

// ignore: must_be_immutable
class PortopolioReturnWidget extends StatelessWidget {
  PortopolioReturnWidget({super.key});
  RxString val = 'Monthly'.obs;
  String dateFull = '';
  int tahun = 0;
  String bulan = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: PopupMenuButton(
            elevation: 0,
            offset: const Offset(0, 0),
            position: PopupMenuPosition.under,
            constraints: BoxConstraints.tightFor(
              height: 90.h,
              width: 0.23.sw,
            ),
            color: foregroundwidget,
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 35.h,
                value: 'DY',
                child: Center(
                    child: Text(
                  'Daily',
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                )),
              ),
              PopupMenuItem(
                value: 'MY',
                height: 35.h,
                child: Center(
                    child: Text(
                  'Monthly',
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                )),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'DY':
                  val.value = 'Daily';
                  val.refresh();
                case 'MY':
                  val.value = 'Monthly';
                  val.refresh();
              }
            },
            child: Container(
                alignment: Alignment.center,
                width: 0.23.sw,
                height: 25.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(
                    3.r,
                  ),
                ),
                child: Obx(
                  () => Text(
                    val.value,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizes.size12),
                  ),
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.h),
          padding: EdgeInsets.only(left: 5.w),
          alignment: Alignment.center,
          width: 1.sw,
          height: 30.h,
          decoration: BoxDecoration(
            color: bgabu,
          ),
          child: Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Portopolio Return",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
            ),
          ),
        ),
        Obx(() {
          List<PortopolioReturn>? data = listPortopolioreturn;
          return Expanded(
            child: HorizontalDataTable(
              elevation: 0,
              rowSeparatorWidget: Divider(
                height: 2.h,
                thickness: 0.05,
              ),
              leftHandSideColumnWidth: 0.3.sw,
              rightHandSideColumnWidth: 1.3.sw,
              isFixedHeader: true,
              isFixedFooter: true,
              footerWidgets: [
                Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  width: 0.3.sw,
                  color: foregroundwidget,
                  child: Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 20.h,
                  width: 0.3.sw,
                  color: foregroundwidget,
                  child: Text(
                    listPortopolioreturn!.isEmpty ||
                            listPortopolioreturn!
                                .first.arrayPortoReturn!.isEmpty
                        ? ""
                        : formattaCurrun(
                            listPortopolioreturn!.first.totalAssetValue!),
                    style: TextStyle(
                        color: listPortopolioreturn!.isEmpty ||
                                listPortopolioreturn!
                                    .first.arrayPortoReturn!.isEmpty
                            ? null
                            : listPortopolioreturn!.first.totalAssetValue! == 0
                                ? Colors.yellow
                                : listPortopolioreturn!.first.totalAssetValue!
                                            .toInt() >=
                                        0
                                    ? Colors.green
                                    : Colors.red,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 20.h,
                  width: 0.25.sw,
                  color: foregroundwidget,
                  child: Text(
                    listPortopolioreturn!.isEmpty ||
                            listPortopolioreturn!
                                .first.arrayPortoReturn!.isEmpty
                        ? ""
                        : formattaCurrun(
                            listPortopolioreturn!.first.totalDeposit!),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 20.h,
                  width: 0.25.sw,
                  color: foregroundwidget,
                  child: Text(
                    listPortopolioreturn!.isEmpty ||
                            listPortopolioreturn!
                                .first.arrayPortoReturn!.isEmpty
                        ? ""
                        : formattaCurrun(
                            listPortopolioreturn!.first.totalWithdraw!),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 20.h,
                  width: 0.25.sw,
                  color: foregroundwidget,
                  child: Text(
                    listPortopolioreturn!.isEmpty ||
                            listPortopolioreturn!
                                .first.arrayPortoReturn!.isEmpty
                        ? ""
                        : formattaCurrun(listPortopolioreturn!
                            .first.totalUnrealizedGainLoss!),
                    style: TextStyle(
                        color: listPortopolioreturn!.isEmpty ||
                                listPortopolioreturn!
                                    .first.arrayPortoReturn!.isEmpty
                            ? null
                            : listPortopolioreturn!
                                        .first.totalUnrealizedGainLoss! ==
                                    0
                                ? Colors.yellow
                                : listPortopolioreturn!
                                            .first.totalUnrealizedGainLoss!
                                            .toInt() >=
                                        0
                                    ? Colors.green
                                    : Colors.red,
                        fontSize: 12.sp),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 5.w),
                  alignment: Alignment.centerRight,
                  height: 20.h,
                  width: 0.25.sw,
                  color: foregroundwidget,
                  child: Text(
                    listPortopolioreturn!.isEmpty ||
                            listPortopolioreturn!
                                .first.arrayPortoReturn!.isEmpty
                        ? ""
                        : "${formatIndex2k(listPortopolioreturn!.first.totalYieldPercentage!.toDouble()).toString()}%",
                    style: TextStyle(
                        color: listPortopolioreturn!.isEmpty ||
                                listPortopolioreturn!
                                    .first.arrayPortoReturn!.isEmpty
                            ? null
                            : listPortopolioreturn!
                                        .first.totalYieldPercentage! ==
                                    0
                                ? Colors.yellow
                                : listPortopolioreturn!
                                            .first.totalYieldPercentage!
                                            .toInt() >=
                                        0
                                    ? Colors.green
                                    : Colors.red,
                        fontSize: 12.sp),
                  ),
                ),
              ],
              leftHandSideColBackgroundColor: Colors.black,
              headerWidgets: _getHeaderWidget(),
              leftSideItemBuilder: (context, index) {
                if (data!.isNotEmpty) {
                  int dateAsInt =
                      data.first.arrayPortoReturn![index].date!.toInt();
                  tahun = dateAsInt ~/ 100;
                  bulan = (dateAsInt % 100).toString();
                  if (bulan.length < 2) bulan = '0$bulan';
                  dateFull = '$tahun/$bulan';
                }

                return Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      width: 0.3.sw,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.isEmpty ? "0" : dateFull,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              rightHandSideColBackgroundColor: Colors.black,
              rightSideItemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.3.sw,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data!.isEmpty
                                ? "0"
                                : formattaCurrun(data.first
                                    .arrayPortoReturn![index].assetValue!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: data.first.arrayPortoReturn![index]
                                            .assetValue! ==
                                        0
                                    ? putihop85
                                    : data.first.arrayPortoReturn![index]
                                                .assetValue! <
                                            0
                                        ? Colors.red
                                        : Colors.green,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.25.sw,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.isEmpty
                                ? "0"
                                : formattaCurrun(data
                                    .first.arrayPortoReturn![index].deposit!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.25.sw,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.isEmpty
                                ? "0"
                                : formattaCurrun(data
                                    .first.arrayPortoReturn![index].withdraw!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.25.sw,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.isEmpty
                                ? "0"
                                : formattaCurrun(data
                                    .first
                                    .arrayPortoReturn![index]
                                    .unrealizedGainLoss!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: data.first.arrayPortoReturn![index]
                                            .unrealizedGainLoss! ==
                                        0
                                    ? putihop85
                                    : data.first.arrayPortoReturn![index]
                                                .unrealizedGainLoss! <
                                            0
                                        ? Colors.red
                                        : Colors.green,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 5.w),
                      alignment: Alignment.centerRight,
                      height: 20.h,
                      width: 0.25.sw,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.isEmpty
                                ? "0"
                                : "${formatIndex2k(data.first.arrayPortoReturn![index].yieldPercentage!.toDouble()).toString()}%",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: listPortopolioreturn!.isEmpty
                  ? 0
                  : listPortopolioreturn!.first.arrayPortoReturn!.length,
            ),
          );
        }),
      ],
    );
  }
}

List<Widget> _getHeaderWidget() {
  return [
    Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 20.h,
          width: 0.3.sw,
          color: foregroundwidget,
          child: Text(
            'Date',
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
          ),
        ),
      ],
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Asset Val',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget,
      child: Text(
        'Deposit',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget,
      child: Text(
        'Withdraw',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget,
      child: Text(
        'G/L',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 20.h,
      width: 0.25.sw,
      color: foregroundwidget,
      child: Text(
        'Yield(%)',
        style:
            TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
      ),
    ),
  ];
}
