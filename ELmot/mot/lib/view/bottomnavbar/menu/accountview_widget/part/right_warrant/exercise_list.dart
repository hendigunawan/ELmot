import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/exercise_list.pkg.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

import '../../../tradeviewdetail/tradewidget/candle/candle.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List of Exercise",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
                  ),
                  Obx(() {
                    return Text(
                      "Total : ${listExerciseList.isEmpty ? '0' : listExerciseList.first.array!.length}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13.sp),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (listExerciseList.isEmpty) {
            return Center(
              child: Text(
                " - ",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
            );
          } else {
            return Expanded(
                child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 0.45.sw,
                rightHandSideColumnWidth: 1.5.sw,
                isFixedHeader: true,
                leftHandSideColBackgroundColor: Colors.black,
                rightHandSideColBackgroundColor: Colors.black,
                headerWidgets: _getHeaderWidget(),
                itemCount: listExerciseList.isEmpty
                    ? 0
                    : listExerciseList.first.array!.length,
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
                        alignment: Alignment.center,
                        height: 66.h,
                        width: 0.1.sw,
                        color: index % 2 == 0
                            ? Colors.black
                            : bgabu.withOpacity(0.6),
                        child: listExerciseList.first.array![index].status == 1
                            ? GestureDetector(
                                onTap: () {
                                  NotifikasiPopup.showCANCEL(
                                    onSubmit: () {
                                      Navigator.pop(context);
                                      OrderMassage.reqCancelExercisedData(
                                        pin: Get.find<PinSave>().pin.value,
                                        accountId: accountId.value == ""
                                            ? Get.find<LoginOrderController>()
                                                .order!
                                                .value
                                                .account!
                                                .first
                                                .accountId
                                                .toString()
                                            : accountId.value,
                                        exerciseId: listExerciseList
                                            .first.array![index].exerciseId!,
                                      );
                                    },
                                    text:
                                        "Are you sure want to\ncancel this Exercise?\nExercise Id: ${listExerciseList.first.array![index].exerciseId}",
                                  );
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: 18.sp,
                                  color: Colors.red,
                                ),
                              )
                            : null,
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
                                listExerciseList.first.array![index].status == 0
                                    ? 'Rejected'
                                    : listExerciseList
                                                .first.array![index].status ==
                                            1
                                        ? 'Open'
                                        : listExerciseList.first.array![index]
                                                    .status ==
                                                2
                                            ? 'Transfering'
                                            : listExerciseList.first
                                                        .array![index].status ==
                                                    3
                                                ? 'Transferred'
                                                : 'Canceled',
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
                                dateAjaGarisMiring(listExerciseList
                                    .first.array![index].subscribeDate),
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
                                "${listExerciseList.first.array![index].stockcode}",
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
                                listExerciseList
                                            .first.array![index].executedDate ==
                                        0
                                    ? ''
                                    : dateAjaGarisMiring(listExerciseList
                                        .first.array![index].executedDate),
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
                        width: 0.3.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattaCurrun(listExerciseList
                                    .first.array![index].exercisePrice!),
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
                                formattaCurrun(listExerciseList
                                    .first.array![index].exerciseQty!),
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
                        width: 0.3.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattaCurrun(listExerciseList
                                    .first.array![index].exerciseAmount!),
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
                                formattaCurrun(listExerciseList
                                    .first.array![index].exerciseFee!),
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
                                dateAjaGarisMiring(listExerciseList
                                    .first.array![index].subscribeDate),
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
                                dateTimeAJa(listExerciseList
                                    .first.array![index].subscribeTime),
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
                        width: 0.4.sw,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 33.h,
                              alignment: Alignment.center,
                              child: Text(
                                listExerciseList.first.array![index].inputBy!,
                                maxLines: 1,
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 3.w),
                                  height: 33.h,
                                  width: 0.35.sw,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${listExerciseList.first.array![index].message}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 5.w),
                                  height: 33.h,
                                  width: 0.05.sw,
                                  alignment: Alignment.center,
                                  child: listExerciseList
                                              .first.array![index].message ==
                                          ''
                                      ? null
                                      : GestureDetector(
                                          onTap: () {
                                            NotifikasiPopup.showINFO(
                                                text:
                                                    "${listExerciseList.first.array![index].message}");
                                          },
                                          child: const FittedBox(
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ));
          }
        })
      ],
    );
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
          width: 0.1.sw,
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
                  right: BorderSide(
                    color: Colors.black,
                    width: 1.w,
                  ),
                )),
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
                )),
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
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  'Status',
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
                  'Exercise Date',
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
              'Executed Date',
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
      width: 0.3.sw,
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
              'Exercise Price',
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
              'Exercise Qty',
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
      width: 0.3.sw,
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
              'Exercise Amount',
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
              'Exercise Fee',
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
              'Subs Date',
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
              'Subs Time',
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
      width: 0.4.sw,
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
              'Input By',
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
              'Message',
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
