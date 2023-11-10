import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:lottie/lottie.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class NotifikasiPopup {
  NotifikasiPopup._();

  static show(String text, {void Function()? onTap}) {
    return Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
          onTap;
        },
        child: Dialog(
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          child: _customDialog(text),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static showSucess(String text, {void Function()? onTap}) {
    return Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
          onTap;
        },
        child: Dialog(
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          child: _customDialogSuccess(text),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static showSUCCESS(String text,
      {void Function()? onTap,
      void Function()? onClose,
      bool isEnable = true}) {
    return Get.dialog(
      GestureDetector(
          onTap: onTap ??
              () {
                Get.back();
              },
          child: WillPopScope(
            onWillPop: () async {
              return isEnable;
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
              backgroundColor: bgabu,
              title: SizedBox(
                height: 100.h,
                width: 0.3.sw,
                child: Lottie.asset(
                  'assets/successB.json',
                  repeat: true,
                  animate: true,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 0.35.sw,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: putihop85, fontSize: FontSizes.size12),
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: EdgeInsets.only(top: 5.h, bottom: 10.h),
              actions: <Widget>[
                SizedBox(
                  height: 22.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: onClose ??
                        () {
                          Get.back();
                        },
                    child: Text(
                      'Close',
                      style: TextStyle(
                          color: putihop85, fontSize: FontSizes.size10),
                    ),
                  ),
                ),
              ],
            ),
          )),
      barrierDismissible: isEnable,
    );
  }

  static showFAILED(String text,
      {void Function()? onTap,
      bool? barrierDismissible,
      void Function()? onClose}) {
    return Get.dialog(
      GestureDetector(
          onTap: onTap ??
              () {
                Get.back();
              },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            backgroundColor: bgabu,
            title: SizedBox(
              height: 100.h,
              width: 0.3.sw,
              child: Lottie.asset(
                'assets/gagal.json',
                repeat: true,
                animate: true,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 0.35.sw,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size12),
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: EdgeInsets.only(top: 5.h, bottom: 10.h),
            actions: <Widget>[
              SizedBox(
                height: 22.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r))),
                  onPressed: onClose ??
                      () {
                        Get.back();
                      },
                  child: Text(
                    'Close',
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size10),
                  ),
                ),
              ),
            ],
          )),
      barrierDismissible: barrierDismissible ?? true,
    );
  }

  static showWarning(String text) {
    return Get.dialog(
      GestureDetector(
          onTap: () {
            Get.back();
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            backgroundColor: bgabu,
            title: SizedBox(
              height: 50.h,
              width: 0.3.sw,
              child: Lottie.asset(
                'assets/warning.json',
                repeat: true,
                animate: true,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 0.35.sw,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size12),
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: EdgeInsets.only(top: 5.h, bottom: 10.h),
            actions: <Widget>[
              SizedBox(
                height: 22.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r))),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Close',
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size10),
                  ),
                ),
              ),
            ],
          )),
      barrierDismissible: true,
    );
  }

  static showCANCEL(
      {String? text,
      required void Function() onSubmit,
      void Function()? isCancel,
      String? customText}) {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
        backgroundColor: bgabu,
        title: SizedBox(
          height: 50.h,
          width: 0.3.sw,
          child: Lottie.asset(
            'assets/warning.json',
            repeat: true,
            animate: true,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 0.35.sw,
              child: Text(
                text!,
                textAlign: TextAlign.center,
                style: TextStyle(color: putihop85, fontSize: FontSizes.size12),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.only(top: 5.h, bottom: 10.h),
        actions: <Widget>[
          isCancel == null
              ? SizedBox(
                  height: 22.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: putihop85, fontSize: FontSizes.size10),
                    ),
                  ),
                )
              : SizedBox(
                  height: 22.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: isCancel,
                    child: Text(
                      'No',
                      style: TextStyle(
                          color: putihop85, fontSize: FontSizes.size10),
                    ),
                  ),
                ),
          SizedBox(
            height: 22.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r))),
              onPressed: onSubmit,
              child: Text(
                customText ?? 'Ok',
                style: TextStyle(color: putihop85, fontSize: FontSizes.size10),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static showINFO({required String text}) {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
        backgroundColor: bgabu,
        title: SizedBox(
          height: 40.h,
          width: 0.3.sw,
          child: Lottie.asset(
            'assets/infoB.json',
            repeat: true,
            animate: true,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 0.35.sw,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: putihop85, fontSize: FontSizes.size12),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.only(top: 5.h, bottom: 10.h),
        actions: <Widget>[
          SizedBox(
            height: 22.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r))),
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Close',
                style: TextStyle(color: putihop85, fontSize: FontSizes.size10),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static showLOADING({bool? isEnable}) {
    return Get.dialog(
      AlertDialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        content: Container(
          height: 0.3.sh,
          width: 0.5.sw,
          alignment: Alignment.center,
          child: Lottie.asset(
            'assets/loading.json',
            repeat: true,
            animate: true,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
        ),
      ),
      barrierDismissible: isEnable == true ? true : false,
    );
  }

  static showLOADINGWITHDISABLE() {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: AlertDialog(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          content: Container(
            height: 0.3.sh,
            width: 0.5.sw,
            alignment: Alignment.center,
            child: Lottie.asset('assets/loading.json',
                repeat: true,
                animate: true,
                width: double.maxFinite,
                height: double.maxFinite),
          ),
        ),
      ),
      barrierDismissible: true,
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
          padding: EdgeInsets.all(30.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp),
              )
            ],
          ),
        ),
      ),
    );
  }

  static _customDialogSuccess(String text) {
    return Center(
      child: Container(
        height: 130.h,
        width: 0.6.sw,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.all(30.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormPopup {
  FormPopup._();

  static show(Widget widget) {
    return Get.dialog(
      barrierDismissible: true,
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Dialog(
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          child: _customDialog(widget),
        ),
      ),
    );
  }

  static hide() {
    Get.back();
  }

  static _customDialog(Widget widget) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: foregroundwidget,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: widget,
        ),
      ),
    );
  }
}
