// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/exercise_list.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/exercise_righ_warrant_info.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/right_warrant/exercise_list.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/right_warrant/rightwarrant_info.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:page_transition/page_transition.dart';

class RightWarrantMain extends StatelessWidget {
  RightWarrantMain({super.key});
  final RxInt _selectedIndex = 0.obs;
  void _onTabSelected(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    var controller = !Get.isRegistered<requestnewValController>()
        ? Get.put(requestnewValController())
        : Get.find<requestnewValController>();
    controller;
    return WillPopScope(
      onWillPop: () async {
        controller.setClearData();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              controller.setClearData();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: IconSizes.backArrowSize,
            ),
          ),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Right/Warrant",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3.h, left: 5.w),
                  height: 45.h,
                  width: 0.88.sw,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Pin.show(
                    onSelect: () async {
                      await Future.delayed(const Duration(milliseconds: 51),
                          () {
                        controller.reqNewVal();
                      });
                    },
                    onComplete: (text) async {
                      Get.find<PinSave>().pin.value = text;
                      controller.reqNewVal();
                      fokusNode.unfocus();
                    },
                    paddingcustom: EdgeInsets.zero,
                    color: bgabu,
                    border: Border.all(
                      width: 0,
                    ),
                    decoration1: BoxDecoration(
                      color: bgabu,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    decoration2: BoxDecoration(
                      color: bgabu,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fontstyleNameaccount: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    controller.setClearData();
                    fokusNode = FocusNode();
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: RightWarrantMain(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: FittedBox(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 35.h,
                  width: 0.97.sw,
                  decoration: BoxDecoration(
                    color: bgabu,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(children: [
                    _customButton("Exercise Right/Warrant", 0),
                    _customButton("Exercise List", 1),
                  ]),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 7.h),
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
                    "Cash Info",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 13.sp),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (listExerciseWarrantInfo.isEmpty) {
                return Center(
                  child: Text(
                    " - ",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 0.332.sw,
                          height: 25.h,
                          decoration: BoxDecoration(color: foregroundwidget),
                          child: Center(
                            child: Text(
                              dateAjaGarisMiring(
                                  listExerciseWarrantInfo.first.t0Date),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Container(
                          width: 0.332.sw,
                          height: 25.h,
                          decoration: BoxDecoration(color: foregroundwidget),
                          child: Center(
                            child: Text(
                              dateAjaGarisMiring(
                                  listExerciseWarrantInfo.first.t1Date),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Container(
                          width: 0.332.sw,
                          height: 25.h,
                          decoration: BoxDecoration(color: foregroundwidget),
                          child: Center(
                            child: Text(
                              dateAjaGarisMiring(
                                  listExerciseWarrantInfo.first.t2Date),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: 0.332.sw,
                          height: 25.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            formattaCurrun(
                                listExerciseWarrantInfo.first.t0Cash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 0.332.sw,
                          height: 25.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            formattaCurrun(
                                listExerciseWarrantInfo.first.t1Cash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 3.w),
                          alignment: Alignment.centerRight,
                          width: 0.332.sw,
                          height: 25.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Text(
                            formattaCurrun(
                                listExerciseWarrantInfo.first.t2Cash!),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            }),
            Obx(() {
              return Flexible(
                child: _selectedIndex.value == 0
                    ? RightWarrantInfo()
                    : const ExerciseList(),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _customButton(String title, int index) {
    return GestureDetector(
      onTap: () => _selectedIndex.value != index ? _onTabSelected(index) : null,
      child: Obx(() {
        return Column(
          children: [
            Container(
              height: 35.h,
              width: 0.485.sw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: _selectedIndex.value == index
                      ? foregroundwidget.withOpacity(0.9)
                      : bgabu),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: _selectedIndex.value == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _selectedIndex.value == index
                          ? Colors.white.withOpacity(0.85)
                          : Colors.grey,
                      fontSize: 13.sp),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class requestnewValController extends GetxController {
  void reqNewVal() {
    OrderMassage.reqExerciseRighwarrantInfo(
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
    );
    OrderMassage.reqExerciseRighwarrantList(
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
    );
  }

  void setClearData() {
    Get.find<PinSave>().pin.value = '';
    listExerciseWarrantInfo.clear();
    listExerciseList.clear();
  }
}
