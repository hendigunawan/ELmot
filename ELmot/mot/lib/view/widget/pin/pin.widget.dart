import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/info/trading_limit.model.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';

RxString account = ''.obs;
RxString accountId = ''.obs;
RxString accountName = ''.obs;
FocusNode fokusNode = FocusNode();

class Pin {
  static Widget show({
    required Function(String) onComplete,
    void Function()? onSelect,
    Color? color,
    BoxBorder? border,
    Decoration? decoration1,
    Decoration? decoration2,
    TextStyle? fontstyleNameaccount,
    EdgeInsetsGeometry? paddingcustom,
  }) {
    return Container(
      height: 30.h,
      width: 1.sw,
      padding: paddingcustom ??
          EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
      alignment: Alignment.center,
      margin: paddingcustom ??
          EdgeInsets.only(bottom: 5.h, left: 19.h, right: 19.h),
      decoration: BoxDecoration(
        border: border ??
            Border.all(
              width: 0.5.w,
              color: Colors.grey.withOpacity(0.5),
            ),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () {
              var getAccount = Get.find<LoginOrderController>();
              return Container(
                padding: EdgeInsets.only(left: 5.w),
                constraints: BoxConstraints.expand(
                  width: 0.5.sw,
                  height: 30.h,
                ),
                decoration: decoration1,
                alignment: Alignment.centerRight,
                child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  constraints:
                      BoxConstraints.tightFor(width: 0.5.sw, height: 150.h),
                  padding: EdgeInsets.zero,
                  color: foregroundwidget,
                  itemBuilder: (d) => getAccount.order!.value.account!
                      .map(
                        (e) => PopupMenuItem(
                          height: 40.h,
                          value: e,
                          onTap: Get.find<PinSave>().pin.value == ''
                              ? null
                              : onSelect,
                          child: Text(
                            '${e.accountId} - ${e.accountName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSizes.size11,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onSelected: (value) {
                    account.value = '${value.accountId} - ${value.accountName}';
                    accountId.value = value.accountId!;
                    accountName.value = '${value.accountName}';
                    accountId.refresh();
                    account.refresh();
                    accountName.refresh();
                  },
                  child: Text(
                    account.value == ''
                        ? '${getAccount.order!.value.account!.first.accountId} - ${getAccount.order!.value.account!.first.accountName}'
                        : account.value,
                    maxLines: 1,
                    style: fontstyleNameaccount ??
                        TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size12,
                        ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              fokusNode.requestFocus();
            },
            child: Container(
              decoration: decoration2,
              constraints: BoxConstraints.expand(width: 0.35.sw, height: 30.h),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                children: [
                  Text(
                    'PIN: ',
                    style: fontstyleNameaccount ??
                        TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size12,
                        ),
                  ),
                  SizedBox(
                    width: 0.25.sw,
                    height: 0.2.sh,
                    child: PinCodeFields(
                      autoHideKeyboard: false,
                      // controller: pinController,
                      focusNode: fokusNode,
                      length: 6,
                      fieldHeight: 0.2.sh,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(
                        fontSize: FontSizes.size12,
                        color: Colors.white,
                      ),
                      borderWidth: 0,
                      obscureCharacter: '•',
                      obscureText: true,
                      margin: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      padding: EdgeInsets.zero,
                      onComplete: onComplete,
                      autofillHints: Get.put(PinSave()).pin.value == ''
                          ? null
                          : Get.put(PinSave()).pin.value.split(''),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget showLimit({required String stockCode}) {
    final controllerPin = Get.put(PinSave());
    Future.delayed(
      Duration.zero,
      () {
        controllerPin.stockCode.value = stockCode;
        controllerPin.stockCode.refresh();
      },
    );

    return Container(
        height: 35.h,
        width: 0.9.sw,
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 7.h),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5.w,
            color: Colors.grey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 0.3.sw,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'T+2: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controllerPin.limit.value.cashonT3 == null
                          ? '-'
                          : formattaCurrun(
                              controllerPin.limit.value.cashonT3!,
                            ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.3.sw,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      ' RTL:',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controllerPin.limit.value.remainTradingLimit == null
                          ? '- '
                          : "${formattaCurrun(
                              controllerPin.limit.value.remainTradingLimit!,
                            )} ",
                      style: TextStyle(
                        color: controllerPin.limit.value.remainTradingLimit ==
                                null
                            ? putihop85
                            : controllerPin.limit.value.remainTradingLimit! < 0
                                ? Colors.red
                                : controllerPin.limit.value
                                                .remainTradingLimit! /
                                            100 ==
                                        0
                                    ? Colors.yellow
                                    : Colors.green,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.25.sw,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'RATIO: ',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controllerPin.limit.value.currentRatio == null
                          ? '-'
                          : '${formattaCurruns(
                              controllerPin.limit.value.currentRatio! /
                                  Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .lot!,
                            )}%',
                      style: TextStyle(
                        color: controllerPin.limit.value.currentRatio == null
                            ? putihop85
                            : controllerPin.limit.value.currentRatio! /
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .lot! <
                                    0
                                ? Colors.red
                                : controllerPin.limit.value.currentRatio! /
                                            100 ==
                                        0
                                    ? Colors.yellow
                                    : Colors.green,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}

class PinSave extends GetxController {
  RxString pin = ''.obs;
  RxString stockCode = ''.obs;
  Rx<TradingLimit> limit = TradingLimit().obs;

  void request() {
    OrderMassage.reqTradinglimit(
      pin: pin.value,
      stockCode: stockCode.value,
    );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   pin.value = '';
  //   limit = TradingLimit().obs;
  //   Get.delete<PinSave>();
  //   super.dispose();
  // }

  void onPop() {
    Future.delayed(
      Duration.zero,
      () {
        pin.value = '';
        limit = TradingLimit().obs;
      },
    );
  }

  void savePin(String pins, {String? stockCodes}) {
    if (pins != '') pin.value = pins;
    if (stockCodes != null || stockCodes != '') stockCode.value = stockCodes!;
    if (pins != '') pin.refresh();
  }
}
