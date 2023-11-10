import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:shimmer/shimmer.dart';

class CardVerticalShimmer extends StatelessWidget {
  const CardVerticalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            for (int i = 0; i < 5; i++)
              Card(
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
          ],
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
                      Shimmer.fromColors(
                        period: const Duration(milliseconds: 1000),
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
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Shimmer.fromColors(
                    period: const Duration(milliseconds: 1300),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 1000),
                  baseColor: bgabu,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.25.sw,
                      height: 13.h,
                      decoration: BoxDecoration(
                        color: foregroundwidget,
                        borderRadius: BorderRadius.circular(5.r),
                      )),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 1250),
                  baseColor: bgabu,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.25.sw,
                      height: 13.h,
                      decoration: BoxDecoration(
                        color: foregroundwidget,
                        borderRadius: BorderRadius.circular(5.r),
                      )),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 1500),
                  baseColor: bgabu,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.25.sw,
                      height: 13.h,
                      decoration: BoxDecoration(
                        color: foregroundwidget,
                        borderRadius: BorderRadius.circular(5.r),
                      )),
                ),
              ],
            )),
        SizedBox(
          width: 10.w,
        ),
        Container(
            alignment: Alignment.center,
            width: 0.35.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 1000),
                  baseColor: bgabu,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.25.sw,
                      height: 13.h,
                      decoration: BoxDecoration(
                        color: foregroundwidget,
                        borderRadius: BorderRadius.circular(5.r),
                      )),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 1250),
                  baseColor: bgabu,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.25.sw,
                      height: 13.h,
                      decoration: BoxDecoration(
                        color: foregroundwidget,
                        borderRadius: BorderRadius.circular(5.r),
                      )),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 1500),
                  baseColor: bgabu,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 0.25.sw,
                      height: 13.h,
                      decoration: BoxDecoration(
                        color: foregroundwidget,
                        borderRadius: BorderRadius.circular(5.r),
                      )),
                ),
              ],
            )),
      ],
    );
  }
}
