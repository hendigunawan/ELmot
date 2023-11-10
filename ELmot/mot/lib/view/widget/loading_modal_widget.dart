import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class loading {
  loading({Key? key});

  void loadingModal(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  const CircularProgressIndicator(),
                  SizedBox(
                    height: 15.h,
                  ),
                  // Some text
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: FontSizes.size13),
                  )
                ],
              ),
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class LoadingScreen {
  LoadingScreen._();

  static show(String text) {
    return Get.dialog(
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _customDialog(text),
      ),
      barrierDismissible: false,
    );
  }

  static hide() {
    Get.back();
  }

  static _customDialog(String text) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.all(30.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 10.w,
                valueColor: const AlwaysStoppedAnimation(Colors.black),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizes.size15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
