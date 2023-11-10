import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JudulTitle extends StatelessWidget {
  final String title;

  final Color colorText;
  const JudulTitle({
    required this.title,
    required this.colorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.6.sw,
      padding: EdgeInsets.only(top: 10.h, left: 18.w, bottom: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35.sp),
          ),
        ],
      ),
    );
  }
}
