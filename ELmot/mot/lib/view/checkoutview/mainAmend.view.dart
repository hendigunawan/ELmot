import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/order/orderListReq.model.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/maincheckout_frombotttomview.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/Orderbook.main.mobile.dart';
import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/streamlist.trading.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/table/main_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

RxBool isRun1 = false.obs;
RxBool isRun2 = false.obs;

class AmendReqMassageModel {
  String? orderID;
  String? stockCode;
  String? idxID;
  int? newPrice;
  int? newVol;
  String? pin;
  String? accountId;
  int? board;
  int? command;

  AmendReqMassageModel({
    this.orderID,
    this.stockCode,
    this.idxID,
    this.newPrice,
    this.newVol,
    this.pin,
    this.accountId,
    this.board,
    this.command,
  });
}

class AmendAndWithdrawRequestActivity extends GetxController {
  void requestAmend(AmendReqMassageModel data) {
    OrderMassage.amendReqMassage(data: data);
  }

  void requestWithdraw(AmendReqMassageModel data) {
    OrderMassage.withdrawReqMassage(data: data);
  }

  void popUp() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (Get.find<OrderListController>()
              .data
              .value
              .array!
              .firstWhereOrNull((element) => element.orderStatus == 1) ==
          null) {
        NotifikasiPopup.showWarning('there are no open orders');
      }
    });
  }
}

RxString types = ''.obs;

class AmendAndWithDraw extends StatelessWidget {
  final String stockCode;
  final String? idxCode;
  final String? orderCode;

  final String type;
  const AmendAndWithDraw({
    super.key,
    required this.stockCode,
    required this.type,
    this.idxCode,
    this.orderCode,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerBoard());
    Get.put(OrderListController());
    var query = Get.put(DetailSahamController());
    var controller = Get.put(BodyController());

    return WillPopScope(
      onWillPop: () async {
        var b = previousRouteObserver.previousRoute;
        if (!Get.isRegistered<RebuildPin>()) {
          var a = await SharedPreferences.getInstance();
          if (a.getBool('isRun') != true) {
            if (b != '/goCheckoutview' && b != '/orderList') {
              if (isRun1.value == true) isRun1.toggle();
              if (isRun2.value == true) isRun2.toggle();
              Get.put(PinSave()).onPop();
              Get.find<BodyController>().onClear();
              Get.put(OrderListController()).data.value = OrderList();
            } else {
              Get.find<BodyController>().onClear();
            }
          } else {
            Get.put(RebuildPin()).restoreDate();
          }
        } else {
          var a = await SharedPreferences.getInstance();
          if (a.getBool('isRun') != true) {
            if (b != '/goCheckoutview' && b != '/orderList') {
              if (isRun1.value == true) isRun1.toggle();
              if (isRun2.value == true) isRun2.toggle();
              Get.put(PinSave()).onPop();
              Get.find<BodyController>().onClear();
              Get.put(OrderListController()).data.value = OrderList();
            } else {
              Get.find<BodyController>().onClear();
            }
          } else {
            Get.find<RebuildPin>().restoreDate();
          }
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 40.h),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Obx(() {
                return Text(
                  types.value == '' ? ' $type' : types.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.size16,
                  ),
                );
              }),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () async {
                  Navigator.of(context).pop();
                  var b = previousRouteObserver.previousRoute;
                  if (!Get.isRegistered<RebuildPin>()) {
                    var a = await SharedPreferences.getInstance();
                    if (a.getBool('isRun') != true) {
                      if (b != '/goCheckoutview' && b != '/orderList') {
                        if (isRun1.value == true) isRun1.toggle();
                        if (isRun2.value == true) isRun2.toggle();
                        Get.put(PinSave()).onPop();
                        Get.find<BodyController>().onClear();
                        Get.put(OrderListController()).data.value = OrderList();
                      } else {
                        Get.find<BodyController>().onClear();
                      }
                    } else {
                      Get.put(RebuildPin()).restoreDate();
                    }
                  } else {
                    var a = await SharedPreferences.getInstance();
                    if (a.getBool('isRun') != true) {
                      if (b != '/goCheckoutview' && b != '/orderList') {
                        if (isRun1.value == true) isRun1.toggle();
                        if (isRun2.value == true) isRun2.toggle();
                        Get.put(PinSave()).onPop();
                        Get.find<BodyController>().onClear();
                        Get.put(OrderListController()).data.value = OrderList();
                      } else {
                        Get.find<BodyController>().onClear();
                      }
                    } else {
                      Get.find<RebuildPin>().restoreDate();
                    }
                  }
                },
                child: Container(
                  width: 5.w,
                  height: 1.h,
                  alignment: AlignmentDirectional.center,
                  child: Icon(
                    Icons.arrow_back,
                    color: putihop85,
                    size: IconSizes.backArrowSize,
                  ),
                ),
              ),
            ),
          ),
          body: Obx(() {
            //   RxString title = stockCode != ''
            //       ? stockCode.obs
            //       : Get.put(OrderListController()).data.value.array == null ||
            //               Get.put(OrderListController()).data.value.array!.isEmpty
            //           ? "".obs
            //           : Get.put(OrderListController())
            //                       .data
            //                       .value
            //                       .array!
            //                       .firstWhereOrNull(
            //                           (element) => element.orderStatus == 1) ==
            //                   null
            //               ? "".obs
            //               : Get.put(OrderListController())
            //                   .data
            //                   .value
            //                   .array!
            //                   .firstWhere((element) => element.orderStatus == 1)
            //                   .stockCode!
            //                   .obs;
            //   String nameStock = title.value == ''
            //       ? ''
            //       : ObjectBoxDatabase.stockList
            //           .query(
            //             PackageStockList_.stcokCode.equals(
            //               title.value == '' ? '' : title.value,
            //             ),
            //           )
            //           .build()
            //           .findFirst()!
            //           .stockName!;

            //   if (title.value != '' &&
            //       isRun1.value == false &&
            //       Get.put(PinSave()).pin.value != '') {
            //     ActivityRequest.quoteRequest(
            //       packageId: Constans.PACKAGE_ID_QUOTES,
            //       arrayStockCode: [
            //         ArrayStockCode(
            //           stockCode: title.value,
            //           board: Get.put(ControllerBoard()).boards.value,
            //         ),
            //       ],
            //     );
            //     Get.put(PinSave()).savePin('', stockCodes: title.value);
            //     Get.find<PinSave>().request();
            //     query.getpreviousPrice(
            //         stockcode: title.value,
            //         board: Get.find<ControllerBoard>().boards.value);
            //     isRun1.toggle();
            //   }
            return SingleChildScrollView(
              child: SizedBox(
                width: 1.sw,
                height: 1.3.sh,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Pin.show(
                      onComplete: (x) {
                        Get.put(OrderListController());
                        OrderMassage.orderListReq(
                          x,
                          accountId.value == ''
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId!
                              : accountId.value,
                        );
                        Get.put(PinSave()).pin.value = x;
                        Get.put(PinSave()).request();
                        Future.delayed(const Duration(milliseconds: 200), () {
                          Get.put(AmendAndWithdrawRequestActivity()).popUp();
                        });
                      },
                      onSelect: () {
                        Future.delayed(
                          const Duration(milliseconds: 50),
                          () {
                            Get.find<PinSave>().request();
                          },
                        );
                      },
                    ),
                    DetailCheckOut(
                      title: controller.stockCode.text == ''
                          ? stockCode
                          : controller.stockCode.text,
                      typeCheckout: 'AMEND',
                      boardWidget: Container(
                        width: 40.w,
                        height: 20.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1,
                            color: Colors.green.withOpacity(0.8),
                          ),
                        ),
                        child: Center(
                          child: GetBuilder<ControllerBoard>(
                            init: ControllerBoard(),
                            builder: (controllerBoards) => Text(
                              controllerBoards.boards.value,
                              style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontSize: FontSizes.size12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Pin.showLimit(stockCode: controller.stockCode.text),
                    bodyFormAmendAndWD(
                      controller.stockCode.text,
                      types.value == '' ? type : types.value,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 60.w,
                            height: 1,
                            color: Colors.white.withOpacity(0.8)),
                        Text(
                          ' Click your buying price below ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: FontSizes.size12,
                          ),
                        ),
                        Container(
                            width: 60.w,
                            height: 1,
                            color: Colors.white.withOpacity(0.8)),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Flexible(
                      flex: 1,
                      child: SreamOBView(
                        prevP: query.previousPrice.toInt(),
                        stockCsearch: controller.stockCode.text,
                        board: Get.find<ControllerBoard>().boards.value,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget bodyFormAmendAndWD(
  String title,
  String type,
) {
  var controller = Get.put(BodyController());
  var controllers = Get.put(OrderListController());
  // var data = Get.put(OrderListController());
  // if (isRun2.value == false) {
  //   Future.delayed(Duration.zero, () {
  //     controller.idxIdController.text = data.data.value.array == null
  //         ? ''
  //         : title == ''
  //             ? ''
  //             : controller.orderIdController.text == ''
  //                 ? ''
  //                 : data.data.value.array!.firstWhereOrNull((element) =>
  //                             element.orderId ==
  //                             controller.orderIdController.text) ==
  //                         null
  //                     ? ""
  //                     : data.data.value.array!
  //                         .where((element) =>
  //                             element.orderId ==
  //                             controller.orderIdController.text)
  //                         .first
  //                         .idxOrderId
  //                         .toString();
  //     controller.orderIdController.text = data.data.value.array == null
  //         ? ''
  //         : controller.orderIdController.text == ''
  //             ? ''
  //             : data.data.value.array!.firstWhereOrNull((element) =>
  //                         element.orderId ==
  //                         controller.orderIdController.text) ==
  //                     null
  //                 ? ""
  //                 : data.data.value.array!
  //                     .where((element) =>
  //                         element.orderId == controller.orderIdController.text)
  //                     .first
  //                     .orderId
  //                     .toString();
  //     controller.priceController.text = data.data.value.array == null
  //         ? ''
  //         : title == ''
  //             ? ''
  //             : controller.orderIdController.text == ''
  //                 ? ''
  //                 : data.data.value.array!
  //                     .where((element) =>
  //                         element.orderId == controller.orderIdController.text)
  //                     .first
  //                     .price
  //                     .toString();
  //     controller.qtyController.text = data.data.value.array == null
  //         ? ''
  //         : title == ''
  //             ? ''
  //             : controller.orderIdController.text == ''
  //                 ? ''
  //                 : ((data.data.value.array!
  //                                 .where((element) =>
  //                                     element.orderId ==
  //                                     controller.orderIdController.text)
  //                                 .first
  //                                 .oVolume! -
  //                             data.data.value.array!
  //                                 .where((element) =>
  //                                     element.orderId ==
  //                                     controller.orderIdController.text)
  //                                 .first
  //                                 .tVolume!) ~/
  //                         Get.find<LoginOrderController>().order!.value.lot!)
  //                     .toString();
  //     controller.boardController.text = data.data.value.array == null
  //         ? ''
  //         : title == ''
  //             ? ''
  //             : controller.orderIdController.text == ''
  //                 ? ''
  //                 : data.data.value.array!
  //                     .where((element) =>
  //                         element.orderId == controller.orderIdController.text)
  //                     .first
  //                     .boardMarketCode!;
  //     controller.bOrSController.text = data.data.value.array == null
  //         ? ''
  //         : title == ''
  //             ? ''
  //             : controller.orderIdController.text == ''
  //                 ? ''
  //                 : data.data.value.array!
  //                             .where((element) =>
  //                                 element.orderId ==
  //                                 controller.orderIdController.text)
  //                             .first
  //                             .command ==
  //                         0
  //                     ? 'BUY'
  //                     : 'SELL';
  //     controller.cashT2Controller.text = data.data.value.array == null ||
  //             Get.find<PinSave>().limit.value.cashonT3 == null
  //         ? ''
  //         : title == ''
  //             ? ''
  //             : formattaCurrun(Get.find<PinSave>().limit.value.cashonT3!);
  //   });
  //   if (title != '') isRun2.toggle();
  // }

  return Container(
    width: 0.9.sw,
    height: 250.h,
    decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(width: 0.5.w, color: Colors.grey.withOpacity(0.5))),
    margin: EdgeInsets.only(
      bottom: 5.h,
    ),
    padding: EdgeInsets.only(
      top: 5.h,
      bottom: 5.h,
      left: 5.w,
      right: 5.w,
    ),
    child: Column(
      children: [
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Container(
                width: 0.2.sw,
                height: 30.h,
                color: foregroundwidget,
                margin: EdgeInsets.only(right: 5.w),
                padding: EdgeInsets.only(left: 5.w, top: 5.h),
                child: Text(
                  "IDX No.",
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.idxIdController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size15,
                    ),
                    textAlign: TextAlign.end,
                    enabled: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                      contentPadding: EdgeInsets.zero,
                      prefix: const Text('  '),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: putihop85,
          height: 5.h,
          thickness: 0.2.h,
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Container(
                width: 0.2.sw,
                height: 30.h,
                color: foregroundwidget,
                margin: EdgeInsets.only(right: 5.w),
                padding: EdgeInsets.only(left: 5.w, top: 5.h),
                child: Text(
                  "Order ID.",
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.orderIdController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size15,
                    ),
                    textAlign: TextAlign.end,
                    enabled: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                      contentPadding: EdgeInsets.zero,
                      prefix: const Text('  '),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: putihop85,
          height: 5.h,
          thickness: 0.2.h,
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Container(
                width: 0.2.sw,
                height: 30.h,
                color: foregroundwidget,
                margin: EdgeInsets.only(right: 5.w),
                padding: EdgeInsets.only(left: 5.w, top: 5.h),
                child: Text(
                  "Price",
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size15,
                    ),
                    textAlign: TextAlign.right,
                    enabled: type == "WITHDRAW" || types.value == 'WITHDRAW'
                        ? false
                        : true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                      contentPadding: EdgeInsets.zero,
                      prefix: const Text('  '),
                      suffixIcon: SizedBox(
                        width: 0.15.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                              onTap: () {
                                // if (Get.find<PinSave>()
                                //         .limit
                                //         .value
                                //         .remainTradingLimit ==
                                //     null) {
                                //   NotifikasiPopup.show("Please Insert Pin");
                                //   return;
                                // }
                                int frac = controller.fraksiPrice((int.parse(
                                          controller.priceController.text
                                              .replaceAll(
                                            RegExp(r','),
                                            '',
                                          ),
                                        ) -
                                        1)
                                    .toString());
                                controller.priceController.text =
                                    formattaCurrun(int.parse(
                                          controller.priceController.text
                                              .replaceAll(
                                            RegExp(r','),
                                            '',
                                          ),
                                        ) -
                                        frac);
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                // if (Get.find<PinSave>()
                                //         .limit
                                //         .value
                                //         .remainTradingLimit ==
                                //     null) {
                                //   NotifikasiPopup.show("Please Insert Pin");
                                //   return;
                                // }

                                int frac = controller.fraksiPrice(
                                  (int.parse(
                                            controller.priceController.text
                                                .replaceAll(
                                              RegExp(r','),
                                              '',
                                            ),
                                          ) +
                                          1)
                                      .toString(),
                                );
                                controller.priceController.text =
                                    formattaCurrun(int.parse(
                                          controller.priceController.text
                                              .replaceAll(
                                            RegExp(r','),
                                            '',
                                          ),
                                        ) +
                                        frac);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: putihop85,
          height: 5.h,
          thickness: 0.2.h,
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Container(
                width: 0.2.sw,
                height: 30.h,
                color: foregroundwidget,
                margin: EdgeInsets.only(right: 5.w),
                padding: EdgeInsets.only(left: 5.w, top: 5.h),
                child: Text(
                  "Quantity",
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller.qtyController,
                    keyboardType: TextInputType.number,
                    enabled: type == "WITHDRAW" || types.value == 'WITHDRAW'
                        ? false
                        : true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size15,
                    ),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                      contentPadding: EdgeInsets.zero,
                      prefix: const Text('  '),
                      suffixIcon: SizedBox(
                        width: 0.15.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                              onTap: () {
                                controller.qtyController.text == '0'
                                    ? null
                                    : controller.qtyController.text =
                                        (int.parse(
                                                  controller.qtyController.text
                                                      .replaceAll(
                                                    RegExp(r','),
                                                    '',
                                                  ),
                                                ) -
                                                1)
                                            .toString();
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.qtyController.text =
                                    formattaCurrun(int.parse(
                                          controller.qtyController.text
                                              .replaceAll(
                                            RegExp(r','),
                                            '',
                                          ),
                                        ) +
                                        1);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: putihop85,
          height: 5.h,
          thickness: 0.2.h,
        ),
        SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Container(
                width: 0.2.sw,
                height: 30.h,
                color: foregroundwidget,
                margin: EdgeInsets.only(right: 5.w),
                padding: EdgeInsets.only(left: 5.w, top: 5.h),
                child: Text(
                  "Board",
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5.w),
                  child: TextField(
                    controller: controller.boardController,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSizes.size15,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: putihop85,
                      contentPadding: EdgeInsets.zero,
                      prefix: const Text('  '),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 0.1.sw,
                height: 28.h,
                color: foregroundwidget,
                margin: EdgeInsets.only(
                  left: 7.w,
                ),
                child: Text(
                  "B/S",
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size13,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 7.w),
                  child: TextField(
                    controller: controller.bOrSController,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    enabled: false,
                    style: TextStyle(
                      color: putihop85,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizes.size16,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: controller.bOrSController.text == 'BUY'
                          ? Colors.red
                          : Colors.green,
                      contentPadding: EdgeInsets.zero,
                      prefix: const Text('  '),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: putihop85,
          height: 0.01.sw,
          thickness: 0.2.h,
        ),
        SizedBox(
          height: 5.h,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
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
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r)),
                      ),
                      useSafeArea: true,
                      enableDrag: true,
                      backgroundColor: bgabu,
                      context: Get.context!,
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
                                "Order List",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: putihop85,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 8.h),
                                  child: Obx(
                                    () {
                                      return ScrollConfiguration(
                                        behavior: const ScrollBehavior()
                                            .copyWith(overscroll: false),
                                        child: HorizontalDataTable(
                                          leftHandSideColumnWidth: 0.3.sw,
                                          rightHandSideColumnWidth: 1.48.sw,
                                          leftHandSideColBackgroundColor:
                                              Colors.transparent,
                                          rightHandSideColBackgroundColor:
                                              Colors.transparent,
                                          isFixedHeader: true,
                                          itemCount:
                                              controllers.data.value.array ==
                                                      null
                                                  ? 0
                                                  : controllers
                                                      .data.value.array!.length,
                                          headerWidgets: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 66.h,
                                                  width: 0.1.sw,
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 33.h,
                                                        width: 0.2.sw,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    foregroundwidget,
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.w,
                                                                  ),
                                                                )),
                                                      ),
                                                      Container(
                                                        height: 33.h,
                                                        width: 0.2.sw,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    foregroundwidget,
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.w,
                                                                  ),
                                                                )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 66.h,
                                                  width: 0.2.sw,
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 33.h,
                                                        width: 0.2.sw,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    foregroundwidget,
                                                                border: Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.w,
                                                                ))),
                                                        child: Text(
                                                          'Type',
                                                          style: TextStyle(
                                                            color: putihop85,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 33.h,
                                                        width: 0.2.sw,
                                                        alignment:
                                                            Alignment.center,
                                                        color: foregroundwidget,
                                                        child: Text(
                                                          'Code',
                                                          style: TextStyle(
                                                            color: putihop85,
                                                            fontSize: 12.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 66.h,
                                              width: 0.23.sw,
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 33.h,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                            left: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ),
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ))),
                                                    child: Text(
                                                      'Status',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 33.h,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.w,
                                                          ),
                                                        )),
                                                    child: Text(
                                                      'Board',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 66.h,
                                              width: 0.25.sw,
                                              alignment: Alignment.center,
                                              color: foregroundwidget,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.25.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            left: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ),
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ))),
                                                    child: Text(
                                                      'Price',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.25.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.w,
                                                          ),
                                                        )),
                                                    child: Text(
                                                      'Qty',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 66.h,
                                              width: 0.25.sw,
                                              alignment: Alignment.center,
                                              color: foregroundwidget,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.25.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                            left: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ),
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ))),
                                                    child: Text(
                                                      'Order Time',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.25.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.w,
                                                          ),
                                                        )),
                                                    child: Text(
                                                      'Input User',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 66.h,
                                              width: 0.25.sw,
                                              alignment: Alignment.center,
                                              color: foregroundwidget,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.25.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                            left: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ),
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ))),
                                                    child: Text(
                                                      'Done Qty',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.25.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.w,
                                                          ),
                                                        )),
                                                    child: Text(
                                                      'Rest Qty',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 66.h,
                                              width: 0.50.sw,
                                              alignment: Alignment.center,
                                              color: foregroundwidget,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.50.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                            left: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ),
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1.w,
                                                            ))),
                                                    child: Text(
                                                      'Order ID',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 33.h,
                                                    width: 0.50.sw,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: foregroundwidget,
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.w,
                                                          ),
                                                        )),
                                                    child: Text(
                                                      'IDX ID',
                                                      style: TextStyle(
                                                        color: putihop85,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          leftSideItemBuilder:
                                              (context, index) => Obx(
                                            () {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children:
                                                    controllers.data.value
                                                                    .array ==
                                                                null ||
                                                            controllers
                                                                .data
                                                                .value
                                                                .array!
                                                                .isEmpty
                                                        ? []
                                                        : [
                                                            controllers
                                                                        .data
                                                                        .value
                                                                        .array![
                                                                            index]
                                                                        .orderStatus ==
                                                                    1
                                                                ? Container(
                                                                    height:
                                                                        66.h,
                                                                    width:
                                                                        0.1.sw,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.priceController.text =
                                                                                formattaCurrun(controllers.data.value.array![index].price!);
                                                                            controller.qtyController.text =
                                                                                formattaCurrun(((controllers.data.value.array![index].oVolume! - controllers.data.value.array![index].tVolume!) ~/ Get.find<LoginOrderController>().order!.value.lot!));
                                                                            controller.boardController.text =
                                                                                controllers.data.value.array![index].boardMarketCode!;
                                                                            controller.bOrSController.text = controllers.data.value.array![index].command! == 1
                                                                                ? 'SELL'
                                                                                : 'BUY';
                                                                            controller.idxIdController.text =
                                                                                controllers.data.value.array![index].idxOrderId!;
                                                                            controller.orderIdController.text =
                                                                                controllers.data.value.array![index].orderId!;
                                                                            controller.stockCode.text =
                                                                                controllers.data.value.array![index].stockCode!;
                                                                            controller.accountId.text =
                                                                                controllers.data.value.accountId!;
                                                                            types.value =
                                                                                'AMEND';
                                                                            Get.back();
                                                                            if (title !=
                                                                                controllers.data.value.array![index].stockCode) {
                                                                              Navigator.pushReplacementNamed(
                                                                                context,
                                                                                '/goCheckoutviewAmendAndWD',
                                                                                arguments: <String, String>{
                                                                                  'prevP': "${ObjectBoxDatabase.quotesBox.query(Quotes_.stockCode.equals(controllers.data.value.array![index].stockCode!)).build().findFirst()!.prevPrice!}",
                                                                                  'title': '${controllers.data.value.array![index].stockCode}',
                                                                                  'subtitle': '',
                                                                                  'board': Get.find<ControllerBoard>().boards.value,
                                                                                  'typeCheckout': "AMEND",
                                                                                  'isFormC': '1'
                                                                                },
                                                                              );
                                                                            }
                                                                          },
                                                                          // onTap:
                                                                          //     () {
                                                                          //   controller.priceController.text =
                                                                          //       formattaCurrun(controllers.data.value.array![index].price!);
                                                                          //   controller.qtyController.text =
                                                                          //       formattaCurrun(((controllers.data.value.array![index].oVolume! - data.data.value.array![index].tVolume!) ~/ Get.find<LoginOrderController>().order!.value.lot!));
                                                                          //   controller.boardController.text =
                                                                          //       controllers.data.value.array![index].boardMarketCode!;
                                                                          //   controller.bOrSController.text = controllers.data.value.array![index].command! == 1
                                                                          //       ? 'SELL'
                                                                          //       : 'BUY';
                                                                          //   controller.idxIdController.text =
                                                                          //       controllers.data.value.array![index].idxOrderId!;
                                                                          //   types.value =
                                                                          //       'AMEND';
                                                                          //   Get.back();
                                                                          // },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                33.h,
                                                                            width:
                                                                                0.1.sw,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            color: index % 2 == 0
                                                                                ? Colors.black
                                                                                : bgabu.withOpacity(0.6),
                                                                            child:
                                                                                Text(
                                                                              "A",
                                                                              style: TextStyle(
                                                                                color: Colors.amber,
                                                                                fontSize: 12.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.priceController.text =
                                                                                formattaCurrun(controllers.data.value.array![index].price!);
                                                                            controller.qtyController.text =
                                                                                formattaCurrun(((controllers.data.value.array![index].oVolume! - controllers.data.value.array![index].tVolume!) ~/ Get.find<LoginOrderController>().order!.value.lot!));
                                                                            controller.boardController.text =
                                                                                controllers.data.value.array![index].boardMarketCode!;
                                                                            controller.bOrSController.text = controllers.data.value.array![index].command! == 1
                                                                                ? 'SELL'
                                                                                : 'BUY';
                                                                            controller.idxIdController.text =
                                                                                controllers.data.value.array![index].idxOrderId!;
                                                                            controller.orderIdController.text =
                                                                                controllers.data.value.array![index].orderId!;
                                                                            controller.stockCode.text =
                                                                                controllers.data.value.array![index].stockCode!;
                                                                            controller.accountId.text =
                                                                                controllers.data.value.accountId!;
                                                                            types.value =
                                                                                'WITHDRAW';
                                                                            Get.back();
                                                                            if (title !=
                                                                                controllers.data.value.array![index].stockCode) {
                                                                              Navigator.pushReplacementNamed(
                                                                                context,
                                                                                '/goCheckoutviewAmendAndWD',
                                                                                arguments: <String, String>{
                                                                                  'prevP': "${ObjectBoxDatabase.quotesBox.query(Quotes_.stockCode.equals(controllers.data.value.array![index].stockCode!)).build().findFirst()!.prevPrice!}",
                                                                                  'title': '${controllers.data.value.array![index].stockCode}',
                                                                                  'subtitle': '',
                                                                                  'board': Get.find<ControllerBoard>().boards.value,
                                                                                  'typeCheckout': "WITHDRAW",
                                                                                  'isFormC': '1'
                                                                                },
                                                                              );
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                33.h,
                                                                            width:
                                                                                0.1.sw,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            color: index % 2 == 0
                                                                                ? Colors.black
                                                                                : bgabu.withOpacity(0.6),
                                                                            child:
                                                                                Text(
                                                                              "W",
                                                                              style: TextStyle(
                                                                                color: Colors.green,
                                                                                fontSize: 12.sp,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height:
                                                                        66.h,
                                                                    width:
                                                                        0.1.sw,
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .black
                                                                        : bgabu.withOpacity(
                                                                            0.6),
                                                                  ),
                                                            Container(
                                                              height: 66.h,
                                                              width: 0.2.sw,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        33.h,
                                                                    width:
                                                                        0.2.sw,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .black
                                                                        : bgabu.withOpacity(
                                                                            0.6),
                                                                    child: Text(
                                                                      controllers.data.value.array![index].command ==
                                                                              0
                                                                          ? "B"
                                                                          : controllers.data.value.array![index].command == 1
                                                                              ? "S"
                                                                              : controllers.data.value.array![index].command == 2
                                                                                  ? "M"
                                                                                  : controllers.data.value.array![index].command == 3
                                                                                      ? "SS"
                                                                                      : "",
                                                                      style: TextStyle(
                                                                          color: controllers.data.value.array![index].command == 0
                                                                              ? Colors.red
                                                                              : controllers.data.value.array![index].command == 1
                                                                                  ? Colors.green
                                                                                  : controllers.data.value.array![index].command == 2
                                                                                      ? Colors.orange
                                                                                      : controllers.data.value.array![index].command == 3
                                                                                          ? Colors.blue
                                                                                          : null,
                                                                          fontSize: 11.sp),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        33.h,
                                                                    width:
                                                                        0.2.sw,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    color: index %
                                                                                2 ==
                                                                            0
                                                                        ? Colors
                                                                            .black
                                                                        : bgabu.withOpacity(
                                                                            0.6),
                                                                    child: Text(
                                                                      controllers
                                                                          .data
                                                                          .value
                                                                          .array![
                                                                              index]
                                                                          .stockCode
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color:
                                                                            putihop85,
                                                                        fontSize:
                                                                            12.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                              );
                                            },
                                          ),
                                          rightSideItemBuilder:
                                              (context, index) {
                                            return Row(
                                              children: List.generate(1, (i) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      height: 66.h,
                                                      width: 0.23.sw,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () =>
                                                                OrderMassage
                                                                    .reqRejectedOrderMassage(
                                                              orderID:
                                                                  controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .orderId!,
                                                              pin: Get.find<
                                                                      PinSave>()
                                                                  .pin
                                                                  .value,
                                                              accountId:
                                                                  controllers
                                                                      .data
                                                                      .value
                                                                      .accountId!,
                                                            ),
                                                            child: Container(
                                                              height: 33.h,
                                                              color: index %
                                                                          2 ==
                                                                      0
                                                                  ? Colors.black
                                                                  : bgabu
                                                                      .withOpacity(
                                                                          0.6),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                controllers
                                                                            .data
                                                                            .value
                                                                            .array![
                                                                                index]
                                                                            .orderStatus ==
                                                                        1
                                                                    ? 'Open'
                                                                    : controllers.data.value.array![index].orderStatus ==
                                                                            2
                                                                        ? 'Matched'
                                                                        : controllers.data.value.array![index].orderStatus ==
                                                                                3
                                                                            ? 'Amending'
                                                                            : controllers.data.value.array![index].orderStatus == 4
                                                                                ? 'Withdrawing'
                                                                                : controllers.data.value.array![index].orderStatus == 5
                                                                                    ? 'Withdrawn'
                                                                                    : controllers.data.value.array![index].orderStatus == 6
                                                                                        ? 'Amended'
                                                                                        : 'Rejected',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      putihop85,
                                                                  fontSize:
                                                                      11.sp,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 33.h,
                                                            alignment: Alignment
                                                                .center,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.black
                                                                : bgabu
                                                                    .withOpacity(
                                                                        0.6),
                                                            child: Text(
                                                              controllers
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .boardMarketCode
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 66.h,
                                                      width: 0.25.sw,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.25.sw,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.black
                                                                : bgabu
                                                                    .withOpacity(
                                                                        0.6),
                                                            child: Text(
                                                              formattaCurrun(
                                                                  controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .price!),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.25.sw,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.black
                                                                : bgabu
                                                                    .withOpacity(
                                                                        0.6),
                                                            child: Text(
                                                              formattaCurrun(
                                                                  controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .oVolume!),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 66.h,
                                                      width: 0.25.sw,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.25.sw,
                                                            alignment: Alignment
                                                                .center,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.black
                                                                : bgabu
                                                                    .withOpacity(
                                                                        0.6),
                                                            child: Text(
                                                              formatJam(controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .orderTime
                                                                      .toString())
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r' '),
                                                                      ''),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.25.sw,
                                                            alignment: Alignment
                                                                .center,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.black
                                                                : bgabu
                                                                    .withOpacity(
                                                                        0.6),
                                                            child: Text(
                                                              controllers
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .inputUser
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 5.w),
                                                      height: 66.h,
                                                      width: 0.25.sw,
                                                      color: index % 2 == 0
                                                          ? Colors.black
                                                          : bgabu
                                                              .withOpacity(0.6),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.25.sw,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              formattaCurrun(
                                                                  controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .tVolume!),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.25.sw,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              formattaCurrun(
                                                                  controllers
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .rVolume!),
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 5.w),
                                                      height: 66.h,
                                                      width: 0.50.sw,
                                                      color: index % 2 == 0
                                                          ? Colors.black
                                                          : bgabu
                                                              .withOpacity(0.6),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.50.sw,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              controllers
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .orderId!,
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 33.h,
                                                            width: 0.50.sw,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              controllers
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .idxOrderId!,
                                                              style: TextStyle(
                                                                color:
                                                                    putihop85,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 0.25.sw,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Order List',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size13,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.back();
                    var b = previousRouteObserver.previousRoute;
                    if (!Get.isRegistered<RebuildPin>()) {
                      var a = await SharedPreferences.getInstance();
                      if (a.getBool('isRun') != true) {
                        if (b != '/goCheckoutview' && b != '/orderList') {
                          if (isRun1.value == true) isRun1.toggle();
                          if (isRun2.value == true) isRun2.toggle();
                          Get.put(PinSave()).onPop();
                          Get.find<BodyController>().onClear();
                          Get.put(OrderListController()).data.value =
                              OrderList();
                        } else {
                          Get.find<BodyController>().onClear();
                        }
                      } else {
                        Get.put(RebuildPin()).restoreDate();
                      }
                    } else {
                      var a = await SharedPreferences.getInstance();
                      if (a.getBool('isRun') != true) {
                        if (b != '/goCheckoutview' && b != '/orderList') {
                          if (isRun1.value == true) isRun1.toggle();
                          if (isRun2.value == true) isRun2.toggle();
                          Get.put(PinSave()).onPop();
                          Get.find<BodyController>().onClear();
                          Get.put(OrderListController()).data.value =
                              OrderList();
                        } else {
                          Get.find<BodyController>().onClear();
                        }
                      } else {
                        Get.find<RebuildPin>().restoreDate();
                      }
                    }
                  },
                  child: Container(
                    width: 0.25.sw,
                    decoration: BoxDecoration(
                      color: bgabu,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size13,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var data = Get.find<OrderListController>().data;
                    Get.defaultDialog(
                      title:
                          '${data.value.array!.where((element) => element.stockCode == title).first.command == 0 ? 'BUY ORDER' : 'SELL ORDER'}\n$type Confirmation',
                      titleStyle: TextStyle(
                        color: controller.bOrSController.text == 'BUY'
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      cancel: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 70.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.red,
                          ),
                          alignment: AlignmentDirectional.center,
                          child: const Text('Cancel'),
                        ),
                      ),
                      confirm: GestureDetector(
                        onTap: () {
                          type == 'AMEND'
                              ? Get.put(AmendAndWithdrawRequestActivity())
                                  .requestAmend(
                                  AmendReqMassageModel()
                                    ..accountId = controller.accountId.text
                                    ..board =
                                        controller.boardController.text == 'RG'
                                            ? 0
                                            : 1
                                    ..command =
                                        controller.bOrSController.text == 'BUY'
                                            ? 0
                                            : 1
                                    ..idxID = controller.idxIdController.text
                                    ..newPrice = int.parse(
                                      controller.priceController.text
                                          .replaceAll(
                                        RegExp(r','),
                                        '',
                                      ),
                                    )
                                    ..newVol = int.parse(
                                          controller.qtyController.text
                                              .replaceAll(
                                            RegExp(r','),
                                            '',
                                          ),
                                        ) *
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .lot!
                                    ..orderID =
                                        controller.orderIdController.text
                                    ..pin = Get.find<PinSave>().pin.value
                                    ..stockCode = title,
                                )
                              : Get.put(AmendAndWithdrawRequestActivity())
                                  .requestWithdraw(
                                  AmendReqMassageModel()
                                    ..accountId = controller.accountId.text
                                    ..board =
                                        controller.boardController.text == 'RG'
                                            ? 0
                                            : 1
                                    ..command =
                                        controller.bOrSController.text == 'BUY'
                                            ? 0
                                            : 1
                                    ..idxID = controller.idxIdController.text
                                    ..newPrice = int.parse(
                                      controller.priceController.text
                                          .replaceAll(
                                        RegExp(r','),
                                        '',
                                      ),
                                    )
                                    ..newVol = int.parse(
                                          controller.qtyController.text
                                              .replaceAll(
                                            RegExp(r','),
                                            '',
                                          ),
                                        ) *
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .lot!
                                    ..orderID =
                                        controller.orderIdController.text
                                    ..pin = Get.find<PinSave>().pin.value
                                    ..stockCode = title,
                                );
                          controller.onClear();
                          Get.back();
                        },
                        child: Container(
                          width: 70.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.blue,
                          ),
                          alignment: AlignmentDirectional.center,
                          child: const Text('Confirm'),
                        ),
                      ),
                      content: Container(
                        padding: EdgeInsets.all(2.w),
                        // color: Colors.greenAccent,
                        // width: 1.w,
                        // height: 0.5.sw,
                        child: Column(
                          children: [
                            Text(
                              '$title - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(title)).build().findFirst()!.stockName!}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizes.size13,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              width: 0.5.sw,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Market: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    data.value.array!
                                                .where((element) =>
                                                    element.stockCode == title)
                                                .first
                                                .boardMarketCode! ==
                                            'RG'
                                        ? 'Regular Market'
                                        : 'Cash Market',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Account ID: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizes.size10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      '${controller.accountId.text} - ${Get.find<LoginOrderController>().order!.value.account!.firstWhere((element) => element.accountId == controller.accountId.text).accountName}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontSizes.size10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order Id: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                      Text(
                                        controller.orderIdController.text,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 0.025.sw,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Idx ID: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90.w,
                                        child: Text(
                                          controller.idxIdController.text,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: FontSizes.size10,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Price: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                          int.parse(
                                            controller.priceController.text
                                                .replaceAll(
                                              RegExp(r','),
                                              '',
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 0.025.sw,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Volume: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                      Text(
                                        formattaCurrun(
                                          int.parse(
                                            controller.qtyController.text
                                                .replaceAll(
                                              RegExp(r','),
                                              '',
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSizes.size10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.25.sw,
                              child: MainTable(
                                header: [
                                  HeaderModel(
                                    label: Text(
                                      'Estimation',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  HeaderModel(
                                    label: Text(
                                      'Transaction Fee',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  HeaderModel(
                                    label: Text(
                                      'Nett',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ],
                                body: [
                                  BodyModel(
                                    body: [
                                      Text(
                                        formattaCurrun(
                                            controller.stockEstimasi()),
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: FontSizes.size10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        formattaCurrun(controller.fee(
                                            controller.bOrSController.text ==
                                                    'BUY'
                                                ? true
                                                : false)),
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: FontSizes.size10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        formattaCurrun(controller.nett(
                                            controller.bOrSController.text ==
                                                    'BUY'
                                                ? true
                                                : false)),
                                        style: TextStyle(
                                          color: type == 'BUY'
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: FontSizes.size10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 0.25.sw,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSizes.size13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
