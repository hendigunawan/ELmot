// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/pkg/info/fund_withdraw_info.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cash_withdraw_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

class FundWithdrawInfoMain extends StatelessWidget {
  const FundWithdrawInfoMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WithDrawInfoController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          alignment: Alignment.center,
          width: 1.sw,
          height: 30.h,
          decoration: BoxDecoration(
            color: bgabu,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Cash",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
            ),
          ),
        ),
        Obx(() {
          if (listfundwithdrawInfo.isEmpty) {
            return Text(
              " - ",
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 0.332.sw,
                      height: 25.h,
                      decoration: BoxDecoration(color: foregroundwidget),
                      child: Center(
                        child: Text(
                          listfundwithdrawInfo.isEmpty
                              ? ""
                              : dateAjaGarisMiring(
                                  listfundwithdrawInfo.first.t0Date),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.332.sw,
                      height: 25.h,
                      decoration: BoxDecoration(color: foregroundwidget),
                      child: Center(
                        child: Text(
                          listfundwithdrawInfo.isEmpty
                              ? ""
                              : dateAjaGarisMiring(
                                  listfundwithdrawInfo.first.t1Date),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.332.sw,
                      height: 25.h,
                      decoration: BoxDecoration(color: foregroundwidget),
                      child: Center(
                        child: Text(
                          listfundwithdrawInfo.isEmpty
                              ? ""
                              : dateAjaGarisMiring(
                                  listfundwithdrawInfo.first.t2Date),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 0.332.sw,
                      height: 25.h,
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            listfundwithdrawInfo.isEmpty
                                ? ""
                                : formattaCurrun(
                                    listfundwithdrawInfo.first.t0Cash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.332.sw,
                      height: 25.h,
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            listfundwithdrawInfo.isEmpty
                                ? ""
                                : formattaCurrun(
                                    listfundwithdrawInfo.first.t1Cash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.332.sw,
                      height: 25.h,
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            listfundwithdrawInfo.isEmpty
                                ? ""
                                : formattaCurrun(
                                    listfundwithdrawInfo.first.t2Cash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        }),
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
              child: Text(
                "Bank Information",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
            ),
          ),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.all(5.w),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Account Id",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12.sp),
                    ),
                    Text(
                      listfundwithdrawInfo.isEmpty
                          ? "-"
                          : "${listfundwithdrawInfo.first.bankAccountId}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Account Name",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12.sp),
                    ),
                    Text(
                      listfundwithdrawInfo.isEmpty
                          ? "-"
                          : listfundwithdrawInfo.first.bankAccountName
                              .toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Name",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12.sp),
                    ),
                    Text(
                      listfundwithdrawInfo.isEmpty
                          ? "-"
                          : listfundwithdrawInfo.first.bankName.toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Branch",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 12.sp),
                    ),
                    Text(
                      listfundwithdrawInfo.isEmpty
                          ? "-"
                          : listfundwithdrawInfo.first.bankBranch == ""
                              ? "-"
                              : listfundwithdrawInfo.first.bankBranch
                                  .toString(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
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
              child: Text(
                "Fund Withdraw",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.w),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Withdraw Date",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
                  ),
                  Obx(() {
                    Get.find<WithDrawInfoController>().selectedDate.value;
                    return Container(
                      margin: EdgeInsets.only(right: 3.w),
                      child: PopupMenuButton(
                        position: PopupMenuPosition.under,
                        color: foregroundwidget,
                        constraints: BoxConstraints.tightFor(
                          height: 80.h,
                          width: 0.3.sw,
                        ),
                        itemBuilder: (BuildContext context) {
                          if (listfundwithdrawInfo.isEmpty) return [];
                          return [
                            PopupMenuItem(
                              padding: EdgeInsets.only(bottom: 3.h),
                              height: 30.h,
                              value: '${listfundwithdrawInfo.first.t1Date}',
                              child: Center(
                                  child: Text(
                                dateAjaGarisMiring(
                                    listfundwithdrawInfo.first.t1Date),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size11),
                              )),
                            ),
                            PopupMenuItem(
                              height: 30.h,
                              value: '${listfundwithdrawInfo.first.t2Date}',
                              child: Center(
                                  child: Text(
                                dateAjaGarisMiring(
                                    listfundwithdrawInfo.first.t2Date),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size11),
                              )),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          Get.find<WithDrawInfoController>()
                              .selectedDate
                              .value = value.toString();
                          Get.find<WithDrawInfoController>()
                              .selectedDate
                              .refresh();

                          // set selectedTcash dan selectedCash

                          if (listfundwithdrawInfo.first.t1Date.toString() ==
                              value.toString()) {
                            Get.find<WithDrawInfoController>()
                                    .selectedCash
                                    .value =
                                listfundwithdrawInfo.first.t1Cash!.toInt();
                            Get.find<WithDrawInfoController>()
                                .selectedTcash
                                .value = "T1";
                          } else {
                            Get.find<WithDrawInfoController>()
                                    .selectedCash
                                    .value =
                                listfundwithdrawInfo.first.t2Cash!.toInt();
                            Get.find<WithDrawInfoController>()
                                .selectedTcash
                                .value = "T2";
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
                                  bottomLeft: Radius.circular(3.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Obx(() {
                                      return Text(
                                        listfundwithdrawInfo.isEmpty
                                            ? ""
                                            : Get.find<WithDrawInfoController>()
                                                        .selectedDate
                                                        .value ==
                                                    ''
                                                ? dateAjaGarisMiring(
                                                    listfundwithdrawInfo
                                                        .first.t1Date)
                                                : dateAjaGarisMiring(Get.find<
                                                        WithDrawInfoController>()
                                                    .selectedDate
                                                    .value),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: FontSizes.size13,
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
                                  bottomRight: Radius.circular(3.r),
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
                    );
                  }),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Amount ",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                      Obx(() {
                        if (listfundwithdrawInfo.isEmpty) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () {
                              NotifikasiPopup.showINFO(
                                text:
                                    "Minimum transfer amount must \nbigger than Rp. ${formattaCurrun(listfundwithdrawInfo.first.minimumAmmount!)}",
                              );
                            },
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.blue,
                              size: 17.sp,
                            ),
                          );
                        }
                      })
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 3.w),
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    alignment: Alignment.center,
                    height: 22.h,
                    width: 0.4.sw,
                    decoration: BoxDecoration(
                      color: putihop85,
                      borderRadius: BorderRadius.circular(
                        3.r,
                      ),
                    ),
                    child: Obx(() {
                      return TextField(
                        readOnly: listfundwithdrawInfo.isEmpty ? true : false,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            int val = int.parse(value);
                            if (val < 1) {
                              ammount_controller.text = '';
                            } else {
                              controller.increaseCash(val);
                              if (val >= 100000000) {
                                controller.isActiveRTGS.value = true;
                                controller.isTabRTGS.value = false;
                                controller.isActiveRTGSToggle(
                                  listfundwithdrawInfo.first.rtgsFee!.toInt(),
                                  controller.isActiveRTGS.value,
                                );
                              } else {
                                if (controller.isTabRTGS.value == false) {
                                  controller.isActiveRTGS.value = false;
                                  controller.isActiveRTGSToggle(
                                    controller.rtgsValue.value,
                                    controller.isActiveRTGS.value,
                                  );
                                }
                              }
                            }
                          } else {
                            controller.increaseCash(
                              0,
                            );
                          }
                        },
                        controller: ammount_controller,
                        maxLines: 1,
                        minLines: 1,
                        maxLength: 15,
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.ltr,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
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
              child: Text(
                "Detail Fee",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
              ),
            ),
          ),
        ),
        Obx(
          () {
            return Container(
              padding: EdgeInsets.all(5.w),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Clearing Fee",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                      Text(
                        listfundwithdrawInfo.isEmpty
                            ? "-"
                            : formattaCurrun(
                                listfundwithdrawInfo.first.clearingFee!),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "RTGS ",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 12.sp),
                          ),
                          GestureDetector(
                            onTap: () {
                              NotifikasiPopup.showINFO(
                                text:
                                    "If the amount exceeds Rp 100,000,000,\nthe checkbox will be automatically selected",
                              );
                            },
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.blue,
                              size: 18.sp,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (listfundwithdrawInfo.isEmpty) {
                                NotifikasiPopup.showWarning(
                                    "Please insert PIN");
                              } else if (ammount_controller.text == '') {
                                NotifikasiPopup.showWarning(
                                  "Please input correct\namount value",
                                );
                              } else if (int.parse(ammount_controller.text) <
                                  100000000) {
                                controller.isActiveRTGS.value =
                                    !controller.isActiveRTGS.value;
                                controller.isTabRTGS.value =
                                    !controller.isTabRTGS.value;
                                controller.ontapRTGS();
                              }
                            },
                            child: Obx(() {
                              if (Get.find<WithDrawInfoController>()
                                      .isActiveRTGS
                                      .value ==
                                  true) {
                                return Icon(
                                  Icons.check_box,
                                  color: Colors.white,
                                  size: 18.sp,
                                );
                              } else {
                                return Icon(
                                  Icons.square_sharp,
                                  color: Colors.white,
                                  size: 18.sp,
                                );
                              }
                            }),
                          ),
                        ],
                      ),
                      Obx(() {
                        return Text(
                          listfundwithdrawInfo.isEmpty
                              ? "-"
                              : Get.find<WithDrawInfoController>()
                                          .isActiveRTGS
                                          .value ==
                                      true
                                  ? formattaCurrun(
                                      listfundwithdrawInfo.first.rtgsFee!)
                                  : "0",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12.sp),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overbooking Fee",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                      Text(
                        listfundwithdrawInfo.isEmpty
                            ? "-"
                            : formattaCurrun(
                                listfundwithdrawInfo.first.pindahBukuFee!,
                              ),
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
