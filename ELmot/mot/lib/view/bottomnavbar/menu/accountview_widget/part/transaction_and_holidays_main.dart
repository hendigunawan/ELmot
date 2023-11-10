// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/pkg/info/transaction_n_holidays.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';

class TransactionHolidaysMain extends StatelessWidget {
  const TransactionHolidaysMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
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
          "Transaction and Holidays",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Transaction Day",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() {
              if (listRemainTransactionnHolidays.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: listRemainTransactionnHolidays.isEmpty
                      ? 0
                      : listRemainTransactionnHolidays.first.array!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      height: 35.h,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                          color: bgabu,
                          borderRadius: BorderRadius.circular(5.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 0.5,
                                offset: const Offset(1, 1),
                                blurRadius: 0.5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            listRemainTransactionnHolidays.isEmpty ||
                                    listRemainTransactionnHolidays
                                        .first.array!.isEmpty
                                ? ''
                                : dateAjaGarisMiringWithDay(
                                    listRemainTransactionnHolidays
                                        .first.array![index].tradingDate),
                            style: TextStyle(color: putihop85),
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.blue,
                            size: 20.sp,
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            }),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "Holidays",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() {
              if (listHoliday.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      listHoliday.isEmpty || listHoliday.first.array!.isEmpty
                          ? 0
                          : listHoliday.first.array!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      height: 35.h,
                      width: 0.9.sw,
                      decoration: BoxDecoration(
                          color: bgabu,
                          borderRadius: BorderRadius.circular(5.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 0.5,
                                offset: const Offset(1, 1),
                                blurRadius: 0.5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            listHoliday.isEmpty ||
                                    listHoliday.first.array!.isEmpty
                                ? ''
                                : dateAjaGarisMiringWithDay(
                                    listHoliday.first.array![index].holiday),
                            style: TextStyle(color: putihop85),
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.blue,
                            size: 20.sp,
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
