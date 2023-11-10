// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:shimmer/shimmer.dart';

class CardHorizontalShimmer extends StatelessWidget {
  const CardHorizontalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
          margin: EdgeInsets.symmetric(horizontal: 3.5.w),
          width: 150.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: bgabu,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundwidget,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        period: const Duration(milliseconds: 1120),
                        baseColor: bgabu,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Container(
                            alignment: Alignment.topCenter,
                            width: 0.13.sw,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: foregroundwidget,
                              borderRadius: BorderRadius.circular(5.r),
                            )),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Shimmer.fromColors(
                        period: const Duration(milliseconds: 1500),
                        baseColor: bgabu,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Container(
                            alignment: Alignment.topCenter,
                            width: 0.16.sw,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: foregroundwidget,
                              borderRadius: BorderRadius.circular(5.r),
                            )),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1300),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.10.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 800),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.10.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1700),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.10.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1100),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.10.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1500),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.10.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1300),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.10.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1250),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.11.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                          Shimmer.fromColors(
                            period: const Duration(milliseconds: 1500),
                            baseColor: bgabu,
                            highlightColor: Colors.grey,
                            enabled: true,
                            child: Container(
                                alignment: Alignment.topCenter,
                                width: 0.15.sw,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  color: foregroundwidget,
                                  borderRadius: BorderRadius.circular(5.r),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          width: 150.w,
          height: 90.h,
          decoration: BoxDecoration(
            color: bgabu,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        period: const Duration(milliseconds: 1000),
                        baseColor: bgabu,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Container(
                            alignment: Alignment.topCenter,
                            width: 0.12.sw,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: foregroundwidget,
                              borderRadius: BorderRadius.circular(5.r),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    period: const Duration(milliseconds: 1300),
                    baseColor: bgabu,
                    highlightColor: Colors.grey,
                    enabled: true,
                    child: Container(
                        alignment: Alignment.topCenter,
                        width: 0.3.sw,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: foregroundwidget,
                          borderRadius: BorderRadius.circular(5.r),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Shimmer.fromColors(
                period: const Duration(milliseconds: 1300),
                baseColor: bgabu,
                highlightColor: Colors.grey,
                enabled: true,
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: ConstantStyle.oren,
                      borderRadius: BorderRadius.circular(15.r)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
