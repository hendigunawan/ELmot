// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/exercise_righ_warrant_info.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class RightWarrantInfo extends StatelessWidget {
  RightWarrantInfo({super.key});
  RxString selectedDate = ''.obs;
  RxInt selectedCash = 0.obs;
  RxInt valueTotal = 0.obs;
  RxString selectedTcash = ''.obs;
  final TextEditingController balance = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void showDialogConfirmation(
        {required String name,
        required int ns,
        required int os,
        required int ep,
        required int volumeBalance}) {
      balance.text = volumeBalance.toString();
      valueTotal.value = volumeBalance * ep;

      showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        useSafeArea: true,
        backgroundColor: bgabu,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                height: 360.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 3.h, bottom: 5.h),
                      width: 0.25.sw,
                      height: 10.h,
                      child: Divider(
                        color: foregroundwidget2,
                        thickness: 2.h,
                        height: 3.h,
                      ),
                    ),
                    Text(
                      "Confirmation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: putihop85,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h, bottom: 2.h),
                      child: Divider(
                        color: foregroundwidget,
                        thickness: 1.5.h,
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(children: [
                        Table(
                          columnWidths: {
                            0: FixedColumnWidth(0.35.sw),
                            1: FixedColumnWidth(0.05.sw),
                            2: FixedColumnWidth(0.5.sw),
                          },
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      'Stockcode',
                                      style: TextStyle(
                                        color: putihop85,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      'New Shares',
                                      style: TextStyle(
                                        color: putihop85,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      formattaCurrun(ns),
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      'Old Shares',
                                      style: TextStyle(
                                        color: putihop85,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      formattaCurrun(os),
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      'Exercise Price',
                                      style: TextStyle(
                                        color: putihop85,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      formattaCurrun(ep),
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      'Exercise Date',
                                      style: TextStyle(
                                        color: putihop85,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: PopupMenuButton(
                                      position: PopupMenuPosition.under,
                                      color: foregroundwidget,
                                      constraints: BoxConstraints.tightFor(
                                          height: 80.h, width: 0.305.sw),
                                      itemBuilder: (BuildContext context) {
                                        if (listExerciseWarrantInfo.isEmpty) {
                                          return [];
                                        }
                                        return [
                                          PopupMenuItem(
                                            padding:
                                                EdgeInsets.only(bottom: 3.h),
                                            height: 30.h,
                                            value:
                                                '${listExerciseWarrantInfo.first.t1Date}',
                                            child: Center(
                                                child: Text(
                                              dateAjaGarisMiring(
                                                  listExerciseWarrantInfo
                                                      .first.t1Date),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.sp),
                                            )),
                                          ),
                                          PopupMenuItem(
                                            padding:
                                                EdgeInsets.only(bottom: 3.h),
                                            height: 30.h,
                                            value:
                                                '${listExerciseWarrantInfo.first.t2Date}',
                                            child: Center(
                                                child: Text(
                                              dateAjaGarisMiring(
                                                  listExerciseWarrantInfo
                                                      .first.t2Date),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.sp),
                                            )),
                                          ),
                                        ];
                                      },
                                      onSelected: (value) {
                                        selectedDate.value = value.toString();
                                        selectedDate.refresh();
                                        int val = int.parse(value.toString());
                                        if (val ==
                                            listExerciseWarrantInfo
                                                .first.t1Date) {
                                          selectedCash.value =
                                              listExerciseWarrantInfo
                                                  .first.t1Cash!;
                                          selectedCash.refresh();
                                          selectedTcash.value = 'T1';
                                          selectedTcash.refresh();
                                        } else {
                                          selectedCash.value =
                                              listExerciseWarrantInfo
                                                  .first.t2Cash!;
                                          selectedCash.refresh();
                                          selectedTcash.value = 'T2';
                                          selectedTcash.refresh();
                                        }
                                      },
                                      child: Wrap(
                                        children: [
                                          Container(
                                            height: 22.h,
                                            width: 0.25.sw,
                                            decoration: BoxDecoration(
                                              color: putihop85,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(3.r),
                                                bottomLeft:
                                                    Radius.circular(3.r),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.w),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(() {
                                                    selectedDate.value;
                                                    return Text(
                                                      selectedDate.value == ''
                                                          ? dateAjaGarisMiring(
                                                              listExerciseWarrantInfo
                                                                  .first
                                                                  .t1Date!)
                                                          : dateAjaGarisMiring(
                                                              selectedDate
                                                                  .value),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13.sp,
                                                      ),
                                                    );
                                                  })),
                                            ),
                                          ),
                                          Container(
                                            height: 22.h,
                                            width: 0.055.sw,
                                            decoration: BoxDecoration(
                                              color: foregroundwidget,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(3.r),
                                                bottomRight:
                                                    Radius.circular(3.r),
                                              ),
                                            ),
                                            child: const FittedBox(
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Text(
                                      'Balance (in shares)',
                                      style: TextStyle(
                                        color: putihop85,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: 30.h,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 5.w, right: 5.w),
                                            width: 0.37.sw,
                                            height: 22.h,
                                            decoration: BoxDecoration(
                                              color: putihop85,
                                              borderRadius:
                                                  BorderRadius.circular(3.r),
                                            ),
                                            alignment: Alignment.center,
                                            child: TextField(
                                              onChanged: (value) {
                                                int vall =
                                                    int.tryParse(value) ?? 0;
                                                if (vall <= 0) {
                                                  valueTotal.value = ep;
                                                  balance.text = '';
                                                } else if (vall >
                                                    volumeBalance) {
                                                  NotifikasiPopup.showWarning(
                                                      "Balance (in shares) can't bigger than ${formattaCurrun(volumeBalance)}");
                                                  balance.text =
                                                      volumeBalance.toString();
                                                } else {
                                                  valueTotal.value =
                                                      int.parse(value) * ep;
                                                }
                                              },
                                              controller: balance,
                                              maxLines: 1,
                                              minLines: 1,
                                              maxLength: 15,
                                              textAlign: TextAlign.end,
                                              textDirection: TextDirection.ltr,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]'))
                                              ],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Value ',
                                          style: TextStyle(
                                            color: putihop85,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            NotifikasiPopup.showINFO(
                                                text:
                                                    "Total value = balance(in shares) * exercise price");
                                          },
                                          child: Icon(
                                            Icons.info_outline,
                                            color: Colors.blue,
                                            size: 15.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30.h,
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          color: putihop85, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 30.h,
                                    child: Obx(() {
                                      return Text(
                                        formattaCurrun(valueTotal.value),
                                        style: TextStyle(
                                            color: putihop85, fontSize: 13.sp),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 0.3.sw,
                              height: 30.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.sp),
                                    ),
                                  )),
                            ),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 0.3.sw,
                              height: 30.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      backgroundColor: Colors.blue),
                                  onPressed: () async {
                                    selectedCash.value = selectedCash.value == 0
                                        ? listExerciseWarrantInfo.first.t1Cash!
                                        : selectedCash.value;
                                    selectedDate.value = selectedDate.value ==
                                            ''
                                        ? listExerciseWarrantInfo.first.t1Date!
                                            .toString()
                                        : selectedDate.value;
                                    int bal = int.tryParse(balance.text) ?? 0;
                                    if (valueTotal.value > selectedCash.value) {
                                      NotifikasiPopup.showWarning(
                                        "Your cash on ${selectedTcash.value} is not enought",
                                      );
                                    } else if (bal == 0) {
                                      NotifikasiPopup.showWarning(
                                        "Balance can't lower than 0",
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      await OrderMassage.reqExercisingData(
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
                                          exerciseDate:
                                              int.parse(selectedDate.value),
                                          exerciseVolume:
                                              int.parse(balance.text),
                                          stockcode: name);
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      "Subscribe",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.sp),
                                    ),
                                  )),
                            )
                          ],
                        )
                      ]),
                    ))
                  ],
                ),
              ),
            );
          });
        },
      );
    }

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
                    "List of Right and Warrant",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
                  ),
                  Obx(() {
                    return Text(
                      "Total : ${listExerciseWarrantInfo.isEmpty ? '0' : listExerciseWarrantInfo.first.array!.length}",
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
          if (listExerciseWarrantInfo.isEmpty) {
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
                  rightHandSideColumnWidth: 0.85.sw,
                  isFixedHeader: true,
                  leftHandSideColBackgroundColor: Colors.black,
                  rightHandSideColBackgroundColor: Colors.black,
                  headerWidgets: _getHeaderWidget(),
                  itemCount: listExerciseWarrantInfo.isEmpty
                      ? 0
                      : listExerciseWarrantInfo.first.array!.length,
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
                            child: GestureDetector(
                              onTap: () async {
                                showDialogConfirmation(
                                  name: listExerciseWarrantInfo
                                      .first.array![index].stockCode!,
                                  ep: listExerciseWarrantInfo
                                      .first.array![index].exercisePrice!,
                                  ns: listExerciseWarrantInfo
                                      .first.array![index].newShares!,
                                  os: listExerciseWarrantInfo
                                      .first.array![index].oldShares!,
                                  volumeBalance: listExerciseWarrantInfo
                                      .first.array![index].volumeBalance!,
                                );
                              },
                              child: Icon(
                                Icons.payment,
                                size: 18.sp,
                                color: Colors.blue,
                              ),
                            )),
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
                                height: 66.h,
                                alignment: Alignment.center,
                                child: Text(
                                  listExerciseWarrantInfo
                                      .first.array![index].stockCode
                                      .toString(),
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
                                  formattaCurrun(listExerciseWarrantInfo
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
                                  formattaCurrun(listExerciseWarrantInfo
                                      .first.array![index].volumeBalance!),
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
                                  formattaCurrun(listExerciseWarrantInfo
                                      .first.array![index].oldShares!),
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
                                  formattaCurrun(listExerciseWarrantInfo
                                      .first.array![index].newShares!),
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
                                  dateAjaGarisMiring(listExerciseWarrantInfo
                                      .first.array![index].exerciseDateBegin!),
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
                                  dateAjaGarisMiring(listExerciseWarrantInfo
                                      .first.array![index].exerciseDateEnd!),
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
                ),
              ),
            );
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
          child: Container(
            height: 66.h,
            alignment: Alignment.center,
            child: Text(
              'Stockcode',
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
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
              'Volume Balance',
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
              'Old Shares',
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
              'New Shares',
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
              'Date Begin',
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
              'Date End',
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
