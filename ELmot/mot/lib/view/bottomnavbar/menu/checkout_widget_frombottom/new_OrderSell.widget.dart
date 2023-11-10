// ignore_for_file: must_be_immutable, void_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
import 'package:online_trading/view/bottomnavbar/maincheckout_frombotttomview.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/tradelist/widget/widget.tradelist.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/orderList.widget.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

RxBool onTapConfirm = true.obs;

class NewOrderSellWidget extends StatelessWidget {
  NewOrderSellWidget({super.key, required this.title});
  String title;

  var controller = Get.find<BodyController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 5.w,
        right: 5.w,
        top: 5.w,
        bottom: 5.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text(
                  'Price: ',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size11,
                  ),
                ),
              ),
              SizedBox(
                width: 0.385.sw,
                height: 26.h,
                child: TextField(
                  controller: controller.priceController,
                  maxLength: 9,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    counterText: '',
                    fillColor: Colors.white.withOpacity(0.25),
                    border: const OutlineInputBorder(),
                    suffixIcon: SizedBox(
                      width: 0.12.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                            onTap: () {
                              var priceReg = controller.priceController.text
                                  .replaceAll(RegExp(r','), '');
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }
                              int frac = controller.fraksiPrice(
                                  (int.parse(priceReg) - 1).toString());
                              controller.priceController.text =
                                  formattaCurrun(int.parse(priceReg) - frac);
                              controller.stockEstimasiData.value =
                                  controller.stockEstimasi();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.priceController.text == '0' ||
                                  controller.priceController.text == '') {
                                controller.priceController.text =
                                    Get.find<DetailSahamController>()
                                        .previousPrice
                                        .value
                                        .toString();
                              }
                              var priceReg = controller.priceController.text
                                  .replaceAll(RegExp(r','), '');
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }

                              int frac = controller.fraksiPrice(
                                (int.parse(priceReg) + 1).toString(),
                              );
                              controller.priceController.text =
                                  formattaCurrun(int.parse(priceReg) + frac);
                              controller.stockEstimasiData.value =
                                  controller.stockEstimasi();
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.priceController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          controller.priceController.value.text.length,
                    );
                  },
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size12,
                  ),
                  onChanged: (a) => a,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (Get.find<PinSave>().limit.value.cashonT3 == null) {
                    NotifikasiPopup.showWarning("Please Insert Pin");
                  } else if (controller.priceController.text == '0' ||
                      controller.priceController.text == '') {
                    NotifikasiPopup.showWarning('Please input price');
                  } else {
                    controller.max(
                      false,
                      int.parse(
                        controller.priceController.text
                            .replaceAll(RegExp(r','), ''),
                      ),
                      0,
                    );
                    controller.stockEstimasiData.value =
                        controller.stockEstimasi();
                  }
                },
                child: Container(
                  width: 0.17.sw,
                  height: 26.h,
                  margin: EdgeInsets.only(bottom: 3.h, right: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(
                      3.r,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Max Cash',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size11,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Get.find<PinSave>().limit.value.cashonT3 == null) {
                    NotifikasiPopup.showWarning("Please Insert Pin");
                  } else if (controller.priceController.text == '0' ||
                      controller.priceController.text == '') {
                    NotifikasiPopup.showWarning('Please input price');
                  } else {
                    controller.max(
                      false,
                      int.parse(
                        controller.priceController.text
                            .replaceAll(RegExp(r','), ''),
                      ),
                      1,
                    );
                    controller.stockEstimasiData.value =
                        controller.stockEstimasi();
                  }
                },
                child: Container(
                  width: 0.17.sw,
                  height: 26.h,
                  margin: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(
                      3.r,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Max Limit',
                    style: TextStyle(
                      color: putihop85,
                      fontSize: FontSizes.size11,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 35.w,
                child: Text(
                  'QTY :  ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size11,
                  ),
                ),
              ),
              Container(
                width: 0.385.sw,
                height: 26.h,
                margin: EdgeInsets.only(
                  bottom: 3.h,
                ),
                padding: EdgeInsets.zero,
                child: TextField(
                  onTap: () {
                    controller.qtyController.text =
                        controller.qtyController.text.replaceAll(
                      RegExp(r','),
                      '',
                    );
                    controller.qtyController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.qtyController.value.text.length,
                    );
                  },
                  maxLength: 9,
                  textAlign: TextAlign.right,
                  controller: controller.qtyController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.25),
                    border: const OutlineInputBorder(),
                    suffixIcon: SizedBox(
                      width: 0.12.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }
                              controller.qtyController.text == '0'
                                  ? null
                                  : controller.qtyController.text = (int.parse(
                                              controller.qtyController.text
                                                  .replaceAll(
                                                      RegExp(r','), '')) -
                                          1)
                                      .toString();
                              controller.stockEstimasiData.value =
                                  controller.stockEstimasi();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<PinSave>()
                                      .limit
                                      .value
                                      .remainTradingLimit ==
                                  null) {
                                NotifikasiPopup.showWarning(
                                    "Please Insert Pin");
                                return;
                              }
                              controller.qtyController.text == '0'
                                  ? controller.qtyController.text = '1'
                                  : controller.qtyController.text = (int.parse(
                                              controller.qtyController.text
                                                  .replaceAll(
                                                      RegExp(r','), '')) +
                                          1)
                                      .toString();
                              controller.stockEstimasiData.value =
                                  controller.stockEstimasi();
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size12,
                  ),
                  onChanged: (a) async {
                    int val = int.tryParse(a) ?? 0;
                    if (val > int.parse(controller.qtyController.value.text)) {
                      NotifikasiPopup.showWarning(
                          'Your balance in not enought');
                    }
                  },
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  isMore.toggle();
                  isMore.refresh();
                },
                child: Container(
                  width: 0.355.sw,
                  height: 26.h,
                  margin: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(
                      5.r,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        color: putihop85,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        !isMore.value ? 'Advance Option' : 'Minimize Option',
                        style: TextStyle(
                          color: putihop85,
                          fontSize: FontSizes.size11,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            margin: EdgeInsets.only(right: 5.5.w, left: 5.5.w),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.find<PinSave>().pin.value == ''
                        ? () => NotifikasiPopup.showWarning("Please Insert Pin")
                        : () {
                            OrderMassage.stockBalance(
                              pin: Get.find<PinSave>().pin.value,
                              accountId: accountId.value == ''
                                  ? Get.find<LoginOrderController>()
                                      .order!
                                      .value
                                      .account!
                                      .first
                                      .accountId!
                                  : accountId.value,
                            );

                            showStockbalance(
                              onTapCode: (a) {
                                if (!delistingStock(a.stockCode!)) {
                                  NotifikasiPopup.showWarning(
                                    'Sorry, but the stock you have selected is not available in the market or has been delisted. Please contact customer service for more detailed information.',
                                  );
                                  return;
                                }
                                Navigator.of(context).pop();

                                controller.qtyController.text = (a.balance! ~/
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .lot!)
                                    .toString();

                                controller.stockEstimasiData.value = 0;
                                Future.delayed(
                                    Duration.zero,
                                    () => controller.stockEstimasiData.value =
                                        controller.stockEstimasi());
                                if (a.stockCode != title) {
                                  selectedCode.value = a.stockCode!;
                                  Get.find<DetailSahamController>()
                                      .requestDataDetail(
                                    iyadong: true,
                                    a.stockCode!,
                                    Get.find<ControllerBoard>().boards.value,
                                  );
                                }
                              },
                            );
                          },
                    child: Container(
                      constraints: BoxConstraints.expand(
                        width: 0.3.sw,
                        height: 27.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Stock Balance',
                        style: TextStyle(
                          color: putihop85,
                          fontSize: FontSizes.size11,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.45.sw,
                    child: Row(
                      children: [
                        Text(
                          'Prevent Same Order: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size11,
                          ),
                        ),
                        const Spacer(),
                        FlutterSwitch(
                          value: controller.sameOrder.value,
                          valueFontSize: FontSizes.size10,
                          // showOnOff: true,
                          padding: 2.1.sp,
                          width: 50.w,
                          height: 25.h,
                          onToggle: (a) {
                            controller.sameOrder.value = a;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          Obx(
            () => !isMore.value
                ? Container()
                : Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //       width: 0.25.sw,
                          //       child: Text(
                          //         'Randomize Split: ',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: FontSizes.size11,
                          //         ),
                          //       ),
                          //     ),
                          //     FlutterSwitch(
                          //       valueFontSize: FontSizes.size10,
                          //       // showOnOff: true,
                          //       padding: 2.1.sp,
                          //       width: 50.w,
                          //       height: 25.h,
                          //       value: controller.randomSlit.value,
                          //       onToggle: (a) {
                          //         controller.randomSlit.value = a;
                          //         if (a == false) {
                          //           controller.splitTo.text = '0';
                          //         }
                          //       },
                          //     ),
                          //     SizedBox(
                          //       height: 25.h,
                          //       width: 0.4.sw,
                          //       child: TextField(
                          //         textAlign: TextAlign.right,
                          //         controller: controller.splitTo,
                          //         inputFormatters: [
                          //           FilteringTextInputFormatter.allow(
                          //             RegExp(
                          //               r'[0-9]',
                          //             ),
                          //           ),
                          //         ],
                          //         onTap: () {
                          //           controller.splitTo.selection =
                          //               TextSelection(
                          //             baseOffset: 0,
                          //             extentOffset:
                          //                 controller.splitTo.value.text.length,
                          //           );
                          //         },
                          //         maxLength: 2,
                          //         decoration: InputDecoration(
                          //           counterText: '',
                          //           contentPadding: EdgeInsets.zero,
                          //           filled: true,
                          //           fillColor: Colors.white.withOpacity(0.25),
                          //           border: const OutlineInputBorder(),
                          //           suffixIcon: SizedBox(
                          //             width: 0.12.sw,
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.end,
                          //               children: [
                          //                 GestureDetector(
                          //                   child: Icon(
                          //                     Icons.remove,
                          //                     color: Colors.white,
                          //                     size: 18.sp,
                          //                   ),
                          //                   onTap: () {
                          //                     controller.splitTo.text == '0'
                          //                         ? null
                          //                         : controller.splitTo.text =
                          //                             (int.parse(controller
                          //                                         .splitTo
                          //                                         .text) -
                          //                                     1)
                          //                                 .toString();
                          //                   },
                          //                 ),
                          //                 GestureDetector(
                          //                   onTap: () {
                          //                     controller.splitTo.text =
                          //                         (int.parse(controller
                          //                                     .splitTo.text) +
                          //                                 1)
                          //                             .toString();
                          //                   },
                          //                   child: Icon(
                          //                     Icons.add,
                          //                     color: Colors.white,
                          //                     size: 18.sp,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         enabled: controller.randomSlit.value,
                          //         maxLines: 1,
                          //         textDirection: TextDirection.ltr,
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: FontSizes.size11,
                          //         ),
                          //         onChanged: (a) => a,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //       width: 0.25.sw,
                          //       child: Text(
                          //         'Activ PriceStep: ',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: FontSizes.size11,
                          //         ),
                          //       ),
                          //     ),
                          //     FlutterSwitch(
                          //       valueFontSize: FontSizes.size10,
                          //       // showOnOff: true,
                          //       padding: 2.1.sp,
                          //       width: 50.w,
                          //       height: 25.h,
                          //       value: controller.aPriceStap.value,
                          //       onToggle: (a) {
                          //         controller.aPriceStap.value = a;
                          //         if (a == false) {
                          //           controller.priceStap.text = '0';
                          //         }
                          //       },
                          //     ),
                          //     SizedBox(
                          //       height: 25.h,
                          //       width: 0.4.sw,
                          //       child: TextField(
                          //         textAlign: TextAlign.right,
                          //         controller: controller.priceStap,
                          //         inputFormatters: [
                          //           FilteringTextInputFormatter.allow(
                          //               RegExp(r'[0-9]')),
                          //         ],
                          //         onTap: () {
                          //           controller.priceStap.selection =
                          //               TextSelection(
                          //             baseOffset: 0,
                          //             extentOffset: controller
                          //                 .priceStap.value.text.length,
                          //           );
                          //         },
                          //         maxLength: 2,
                          //         decoration: InputDecoration(
                          //           counterText: '',
                          //           contentPadding: EdgeInsets.zero,
                          //           filled: true,
                          //           fillColor: Colors.white.withOpacity(0.25),
                          //           border: const OutlineInputBorder(),
                          //           // contentPadding: EdgeInsets.zero,
                          //           suffixIcon: SizedBox(
                          //             width: 0.12.sw,
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.end,
                          //               children: [
                          //                 GestureDetector(
                          //                   child: Icon(
                          //                     Icons.remove,
                          //                     color: Colors.white,
                          //                     size: 18.sp,
                          //                   ),
                          //                   onTap: () {
                          //                     controller.priceStap.text == '0'
                          //                         ? null
                          //                         : controller.priceStap.text =
                          //                             (int.parse(controller
                          //                                         .priceStap
                          //                                         .text) -
                          //                                     1)
                          //                                 .toString();
                          //                   },
                          //                 ),
                          //                 GestureDetector(
                          //                   onTap: () {
                          //                     controller.priceStap.text =
                          //                         (int.parse(controller
                          //                                     .priceStap.text) +
                          //                                 1)
                          //                             .toString();
                          //                   },
                          //                   child: Icon(
                          //                     Icons.add,
                          //                     color: Colors.white,
                          //                     size: 18.sp,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           enabled: controller.aPriceStap.value,
                          //         ),
                          //         maxLines: 1,
                          //         textDirection: TextDirection.ltr,
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: FontSizes.size11,
                          //         ),
                          //         onChanged: (a) => a,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 0.25.sw,
                                child: Text(
                                  'Automatic BUY: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size11,
                                  ),
                                ),
                              ),
                              FlutterSwitch(
                                valueFontSize: FontSizes.size10,
                                // showOnOff: true,
                                padding: 2.1.sp,
                                width: 50.w,
                                height: 25.h,
                                value: controller.aOrder.value,
                                onToggle: (a) {
                                  controller.aOrder.value = a;
                                  if (a == false) {
                                    controller.autoPrice.text = '0';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 25.h,
                                width: 0.4.sw,
                                child: TextField(
                                  controller: controller.autoPrice,
                                  textAlign: TextAlign.right,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(
                                        r'[0-9]',
                                      ),
                                    ),
                                  ],
                                  onTap: () {
                                    controller.autoPrice.selection =
                                        TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controller
                                          .autoPrice.value.text.length,
                                    );
                                  },
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.25),
                                    border: const OutlineInputBorder(),
                                    suffixIcon: SizedBox(
                                      width: 0.120.sw,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 18.sp,
                                            ),
                                            onTap: () {
                                              controller.autoPrice.text == '0'
                                                  ? null
                                                  : controller
                                                          .qtyController.text =
                                                      (int.parse(controller
                                                                  .autoPrice
                                                                  .text) -
                                                              1)
                                                          .toString();
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.autoPrice.text =
                                                  (int.parse(controller
                                                              .autoPrice.text) +
                                                          1)
                                                      .toString();
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    enabled: controller.aOrder.value,
                                  ),
                                  maxLines: 1,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSizes.size11,
                                  ),
                                  onChanged: (a) => a,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: Obx(
              () {
                return MainTable(
                  header: [
                    HeaderModel(
                      label: Text(
                        'Stock Estimation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size11,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    HeaderModel(
                      label: Text(
                        'Transaction Fee',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size11,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    HeaderModel(
                      label: Text(
                        'Nett',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size11,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                  body: [
                    BodyModel(
                      body: [
                        Container(
                          alignment: Alignment.centerRight,
                          height: 30.h,
                          child: Text(
                            formattaCurrun(controller.stockEstimasiData.value),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSizes.size11,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 30.h,
                          child: Text(
                            formattaCurrun(controller.fee(false)),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: FontSizes.size11,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 30.h,
                          padding: EdgeInsets.only(right: 5.w),
                          child: Text(
                            formattaCurrun(controller.nett(false)),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: FontSizes.size11,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 30.h,
            width: 0.9.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                        null) {
                      NotifikasiPopup.showWarning('Please Insert Pin');
                    }

                    OrderMassage.orderListReq(
                      Get.find<PinSave>().pin.value,
                      accountId.value == ''
                          ? Get.find<LoginOrderController>()
                              .order!
                              .value
                              .account!
                              .first
                              .accountId!
                          : accountId.value,
                    );
                    orderListDataWidget(
                      onTapA: (amend, accountIdOrder) {
                        controller.priceController.text =
                            formattaCurrun(amend.price!);
                        controller.qtyController.text = formattaCurrun(
                          (amend.oVolume! - amend.tVolume!),
                        );
                        controller.boardController.text =
                            amend.boardMarketCode!;
                        controller.bOrSController.text =
                            amend.command! == 1 ? 'SELL' : 'BUY';
                        controller.idxIdController.text = amend.idxOrderId!;
                        controller.orderIdController.text = amend.orderId!;
                        controller.accountId.text = accountIdOrder;
                        controller.stockCode.text = amend.stockCode!;
                        Get.back();
                        Get.find<RebuildPin>().addShared();
                        Navigator.pushNamed(
                          context,
                          '/goCheckoutviewAmendAndWD',
                          arguments: <String, String>{
                            'prevP': "",
                            'title': '${amend.stockCode}',
                            'subtitle': '',
                            'board': controller.boardController.text,
                            'typeCheckout': "AMEND",
                            'isFormC': '1'
                          },
                        );
                      },
                      onTapW: (amend, accountIdOrder) {
                        controller.priceController.text =
                            formattaCurrun(amend.price!);
                        controller.qtyController.text = formattaCurrun(
                          (amend.oVolume! - amend.tVolume!),
                        );
                        controller.boardController.text =
                            amend.boardMarketCode!;
                        controller.bOrSController.text =
                            amend.command! == 1 ? 'SELL' : 'BUY';
                        controller.idxIdController.text = amend.idxOrderId!;
                        controller.orderIdController.text = amend.orderId!;
                        controller.accountId.text = accountIdOrder;
                        controller.stockCode.text = amend.stockCode!;
                        Get.back();
                        Get.find<RebuildPin>().addShared();
                        Navigator.pushNamed(
                          context,
                          '/goCheckoutviewAmendAndWD',
                          arguments: <String, String>{
                            'prevP': "",
                            'title': '${amend.stockCode}',
                            'subtitle': '',
                            'board': controller.boardController.text,
                            'typeCheckout': "WITHDRAW",
                            'isFormC': '1'
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 0.25.sw,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        'Order List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size14,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return GestureDetector(
                    onTap: !onTapConfirm.value
                        ? () {}
                        : () {
                            if (Get.find<PinSave>()
                                    .limit
                                    .value
                                    .remainTradingLimit ==
                                null) {
                              NotifikasiPopup.showWarning("Please Insert Pin");
                              return;
                            }

                            if (controller.qtyController.text == '0') {
                              NotifikasiPopup.showWarning("Please Insert Qty");
                              return;
                            }

                            popUpConfirmationOrder(type: 'SELL');
                          },
                    child: Container(
                      width: 0.30.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(),
                      ),
                      child: !onTapConfirm.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'SELL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size14,
                              ),
                            ),
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () {
                    if (Get.find<PinSave>().limit.value.remainTradingLimit ==
                        null) {
                      NotifikasiPopup.showWarning('Please Insert Pin');
                      return;
                    }
                    listTradeList.clear();
                    OrderMassage.reqTradeList(
                        pin: Get.find<PinSave>().pin.value,
                        accountId: accountId.value == ""
                            ? Get.find<LoginOrderController>()
                                .order!
                                .value
                                .account!
                                .first
                                .accountId
                                .toString()
                            : accountId.value);

                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r)),
                      ),
                      useSafeArea: true,
                      enableDrag: true,
                      backgroundColor: bgabu,
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 0.5.sh,
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
                                "Trade List",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              const Expanded(child: WidgetTradeList())
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 0.25.sw,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        'Trade List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.size14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
