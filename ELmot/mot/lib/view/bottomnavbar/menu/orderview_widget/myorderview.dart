// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:online_trading/core/rabbitmq/connection.controller.dart';
// import 'package:online_trading/helper/constant_style.dart';
// import 'package:online_trading/helper/constants.dart';
// import 'package:online_trading/helper/fontstyleConstans.dart';
// import 'package:online_trading/module/objectbox/crud/crud_.dart';
// import 'package:online_trading/module/request/activity/acty_request.dart';
// import 'package:online_trading/objectbox.g.dart';
// import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
// import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';

// class MyOrderController extends GetxController {
//   RxBool container1 = false.obs;
//   RxBool container2 = false.obs;

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyOrderControllerAccount());

    controller;

    List<int> selectedIndices = [];
    int getActiveIndex() {
      if (selectedIndices.isNotEmpty) {
        return selectedIndices[0];
      }
      return 0;
    }

    getActiveIndex();
    Future.delayed(
      const Duration(milliseconds: 51),
      () {
        controller.showPininput();
      },
    );
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        expandedHeight: 160.h,
        floating: false,
        pinned: true,
        automaticallyImplyLeading: false,
        title: Text(
          'My Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 60.h, left: 5.w, right: 5.w, bottom: 10.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Get.find<LoginOrderController>()
                            .order!
                            .value
                            .account!
                            .isEmpty
                        ? 0
                        : Get.find<LoginOrderController>()
                            .order!
                            .value
                            .account!
                            .length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (getActiveIndex() == index) {
                            return;
                          } else {
                            selectedIndices.clear();
                            selectedIndices.add(index);
                            controller.isSelected.toggle();
                          }
                        },
                        child: Obx(() {
                          controller.isSelected.value;
                          return Container(
                            width: 200.w,
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                color: getActiveIndex() == index
                                    ? Colors.blue
                                    : bgabu,
                                borderRadius: BorderRadius.circular(5.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      spreadRadius: 0.1,
                                      offset: const Offset(1, 1),
                                      blurRadius: 0.5)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Accound Id",
                                      style: TextStyle(
                                          color: selectedIndices.contains(index)
                                              ? Colors.black
                                              : putihop85,
                                          fontSize: 11.sp),
                                    ),
                                    Text(
                                      Get.find<LoginOrderController>()
                                          .order!
                                          .value
                                          .account![index]
                                          .accountId!,
                                      style: TextStyle(
                                          color: selectedIndices.contains(index)
                                              ? Colors.black
                                              : putihop85,
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Accound Name",
                                      style: TextStyle(
                                          color: selectedIndices.contains(index)
                                              ? Colors.black
                                              : putihop85,
                                          fontSize: 11.sp),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      color: Colors.transparent,
                                      width: 80.w,
                                      child: Text(
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .account![index]
                                            .accountName!,
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:
                                                selectedIndices.contains(index)
                                                    ? Colors.black
                                                    : putihop85,
                                            fontSize: 11.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Online Fee Buy",
                                      style: TextStyle(
                                          color: selectedIndices.contains(index)
                                              ? Colors.black
                                              : putihop85,
                                          fontSize: 11.sp),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      color: Colors.transparent,
                                      width: 80.w,
                                      child: Text(
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .account![index]
                                            .onlineFeeBuy!
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:
                                                selectedIndices.contains(index)
                                                    ? Colors.black
                                                    : putihop85,
                                            fontSize: 11.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Online Fee Sell",
                                      style: TextStyle(
                                          color: selectedIndices.contains(index)
                                              ? Colors.black
                                              : putihop85,
                                          fontSize: 11.sp),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      color: Colors.transparent,
                                      width: 80.w,
                                      child: Text(
                                        Get.find<LoginOrderController>()
                                            .order!
                                            .value
                                            .account![index]
                                            .onlineFeeSell!
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:
                                                selectedIndices.contains(index)
                                                    ? Colors.black
                                                    : putihop85,
                                            fontSize: 11.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  );
                }),
              ),
            )),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 1.sh,
          color: Colors.blue,
          child: Obx(() {
            controller.isSelected.value;
            return Column(
              children: [
                Center(
                  child: Text("CENTER ${getActiveIndex()}"),
                ),
                Center(
                  child: Text(
                      "${Get.find<LoginOrderController>().order!.value.account![getActiveIndex()].accountId}"),
                ),
              ],
            );
          }),
        ),
      )
    ]);
  }
}

class MyOrderControllerAccount extends GetxController {
  RxBool isSelected = false.obs;
  var pinController = Get.put(PinSave());

  void changeSelected() {
    isSelected.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    pinController;
  }

  void showPininput() async {
    await showDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: AlertDialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
              title: Center(
                child: Text(
                  "Please input PIN",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
              backgroundColor: bgabu,
              content: SizedBox(
                width: 0.25.sw,
                height: 50.h,
                child: PinCodeFields(
                  autofocus: true,
                  length: 6,
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(
                    fontSize: 12.sp,
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
                  autofillHints: Get.put(PinSave()).pin.value == ''
                      ? null
                      : Get.put(PinSave()).pin.value.split(''),
                  onComplete: (text) async {
                    pinController.pin.value = text;
                    await ActivityRequest.todayTradesDataRequest(
                        packageId: Constans.PACKAGE_ID_TODAY_TRADES_DATA,
                        stockCode: "GOTO12",
                        commant: "1",
                        board: "RG",
                        nbreq: "0",
                        starttradeId: "0");
                    // await OrderMassage.validatePIN(pin: text);
                    Get.back();
                  },
                ),
              ),
            ),
          );
        });
  }
}

// class MyOrder extends GetView<MyOrderController> {
//   const MyOrder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(MyOrderController());
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: PreferredSize(
//         preferredSize: Size(1.sw, 40.h),
//         child: Container(
//           alignment: Alignment.center,
//           child: Text(
//             'ORDERS',
//             style: TextStyle(
//               fontSize: FontSizes.size16,
//               color: putihop85,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         width: 1.sw,
//         decoration: BoxDecoration(
//           color: bgabu,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(35.r),
//             topRight: Radius.circular(35.r),
//           ),
//         ),
//         padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w),
//         child: Column(
//           children: [
//             Obx(
//               () {
//                 return GestureDetector(
//                   onTap: () => controller.container1.toggle(),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     width: 1.sw,
//                     height:
//                         controller.container1.value == true ? 0.365.sh : 30.h,
//                     // color: Colors.white,
//                     margin: EdgeInsets.only(bottom: 10.h),
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Order Menu',
//                               style: TextStyle(color: putihop85),
//                             ),
//                             Icon(
//                               controller.container1.value == true
//                                   ? Icons.keyboard_arrow_down
//                                   : Icons.keyboard_arrow_right,
//                               color: putihop85,
//                               size: 0.06.sw,
//                             ),
//                           ],
//                         ),
//                         controller.container1.value == false
//                             ? Container()
//                             : Container(
//                                 margin: EdgeInsets.only(left: 0.065.sw),
//                                 constraints:
//                                     BoxConstraints.tightFor(width: 1.sw),
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.find<ControllerHandelSUB>()
//                                             .unBind();
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           commant: 1,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode:
//                                                   Get.find<ControllerBoard>()
//                                                       .stockCodes
//                                                       .value,
//                                               board: Get.find<ControllerBoard>()
//                                                   .boards
//                                                   .value,
//                                             )
//                                           ],
//                                         );
//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: Get.find<ControllerBoard>()
//                                               .stockCodes
//                                               .value,
//                                           board: Get.find<ControllerBoard>()
//                                               .boards
//                                               .value,
//                                           commant: "1",
//                                         );
//                                         var query = ObjectBoxDatabase.quotesBox
//                                             .query(Quotes_.stockCode.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .stockCodes
//                                                         .value) &
//                                                 Quotes_.board.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .boards
//                                                         .value))
//                                             .build()
//                                             .findFirst();

//                                         Navigator.pushNamed(
//                                           context,
//                                           '/goCheckoutview',
//                                           arguments: <String, String>{
//                                             'prevP': "${query!.prevPrice}",
//                                             'title': Get.find<ControllerBoard>()
//                                                 .stockCodes
//                                                 .value,
//                                             'subtitle': ObjectBoxDatabase
//                                                 .stockList
//                                                 .query(PackageStockList_
//                                                     .stcokCode
//                                                     .equals(Get.find<
//                                                             ControllerBoard>()
//                                                         .stockCodes
//                                                         .value))
//                                                 .build()
//                                                 .findFirst()!
//                                                 .stockName!,
//                                             'board': Get.find<ControllerBoard>()
//                                                 .boards
//                                                 .value,
//                                             'typeCheckout': "BUY",
//                                           },
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'BUY',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.find<ControllerHandelSUB>()
//                                             .unBind();
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           commant: 1,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode:
//                                                   Get.find<ControllerBoard>()
//                                                       .stockCodes
//                                                       .value,
//                                               board: Get.find<ControllerBoard>()
//                                                   .boards
//                                                   .value,
//                                             )
//                                           ],
//                                         );
//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: Get.find<ControllerBoard>()
//                                               .stockCodes
//                                               .value,
//                                           board: Get.find<ControllerBoard>()
//                                               .boards
//                                               .value,
//                                           commant: "1",
//                                         );
//                                         var query = ObjectBoxDatabase.quotesBox
//                                             .query(Quotes_.stockCode.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .stockCodes
//                                                         .value) &
//                                                 Quotes_.board.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .boards
//                                                         .value))
//                                             .build()
//                                             .findFirst();

//                                         Navigator.pushNamed(
//                                           context,
//                                           '/goCheckoutview',
//                                           arguments: <String, String>{
//                                             'prevP': "${query!.prevPrice}",
//                                             'title': Get.find<ControllerBoard>()
//                                                 .stockCodes
//                                                 .value,
//                                             'subtitle': ObjectBoxDatabase
//                                                 .stockList
//                                                 .query(PackageStockList_
//                                                     .stcokCode
//                                                     .equals(Get.find<
//                                                             ControllerBoard>()
//                                                         .stockCodes
//                                                         .value))
//                                                 .build()
//                                                 .findFirst()!
//                                                 .stockName!,
//                                             'board': Get.find<ControllerBoard>()
//                                                 .boards
//                                                 .value,
//                                             'typeCheckout': "SELL",
//                                           },
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'SELL',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         ActivityRequest.parameterRequest(
//                                             requestFlag: 1);

//                                         Get.find<ControllerHandelSUB>()
//                                             .unBind();
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           commant: 1,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode:
//                                                   Get.find<ControllerBoard>()
//                                                       .stockCodes
//                                                       .value,
//                                               board: Get.find<ControllerBoard>()
//                                                   .boards
//                                                   .value,
//                                             )
//                                           ],
//                                         );
//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: Get.find<ControllerBoard>()
//                                               .stockCodes
//                                               .value,
//                                           board: Get.find<ControllerBoard>()
//                                               .boards
//                                               .value,
//                                           commant: "1",
//                                         );
//                                         var query = ObjectBoxDatabase.quotesBox
//                                             .query(Quotes_.stockCode.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .stockCodes
//                                                         .value) &
//                                                 Quotes_.board.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .boards
//                                                         .value))
//                                             .build()
//                                             .findFirst();

//                                         Navigator.pushNamed(
//                                           context,
//                                           '/goCheckoutviewAmendAndWD',
//                                           arguments: <String, String>{
//                                             'prevP': "${query!.prevPrice}",
//                                             'title': '',
//                                             'subtitle': '',
//                                             'board': Get.find<ControllerBoard>()
//                                                 .boards
//                                                 .value,
//                                             'typeCheckout': "AMEND",
//                                             'isFormC': "true",
//                                           },
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'AMEND',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         ActivityRequest.parameterRequest(
//                                             requestFlag: 1);

//                                         Get.find<ControllerHandelSUB>()
//                                             .unBind();
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           commant: 1,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode:
//                                                   Get.put(ControllerBoard())
//                                                       .stockCodes
//                                                       .value,
//                                               board: Get.put(ControllerBoard())
//                                                   .boards
//                                                   .value,
//                                             )
//                                           ],
//                                         );
//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: Get.find<ControllerBoard>()
//                                               .stockCodes
//                                               .value,
//                                           board: Get.find<ControllerBoard>()
//                                               .boards
//                                               .value,
//                                           commant: "1",
//                                         );
//                                         var query = ObjectBoxDatabase.quotesBox
//                                             .query(Quotes_.stockCode.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .stockCodes
//                                                         .value) &
//                                                 Quotes_.board.equals(
//                                                     Get.find<ControllerBoard>()
//                                                         .boards
//                                                         .value))
//                                             .build()
//                                             .findFirst();

//                                         Navigator.pushNamed(
//                                           context,
//                                           '/goCheckoutviewAmendAndWD',
//                                           arguments: <String, String>{
//                                             'prevP': "${query!.prevPrice}",
//                                             'title': '',
//                                             'subtitle': '',
//                                             'board': Get.find<ControllerBoard>()
//                                                 .boards
//                                                 .value,
//                                             'typeCheckout': "WITHDRAW",
//                                           },
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'WITHDRAW',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.put(OrderListController());
//                                         Navigator.pushNamed(
//                                             context, '/orderList',
//                                             arguments: <String, String>{
//                                               'A': 'B',
//                                             });
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'ORDERLIST',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.toNamed('/historiOrder');
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'Historical Order List'
//                                                 .toUpperCase(),
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.toNamed('/tradeList');
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'TRADELIST',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.toNamed('/historicalTradeList');
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'Historical Trade List'
//                                                 .toUpperCase(),
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Obx(
//               () {
//                 return GestureDetector(
//                   onTap: () => controller.container2.toggle(),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     width: 1.sw,
//                     height:
//                         controller.container2.value == true ? 0.35.sh : 30.h,
//                     // color: Colors.white,
//                     margin: EdgeInsets.only(bottom: 10.h),
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Advance Order Menu',
//                               style: TextStyle(color: putihop85),
//                             ),
//                             Icon(
//                               controller.container2.value == true
//                                   ? Icons.keyboard_arrow_down
//                                   : Icons.keyboard_arrow_right,
//                               color: putihop85,
//                               size: 0.06.sw,
//                             ),
//                           ],
//                         ),
//                         controller.container2.value == false
//                             ? Container()
//                             : Container(
//                                 margin: EdgeInsets.only(left: 0.065.sw),
//                                 constraints:
//                                     BoxConstraints.tightFor(width: 1.sw),
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushNamed(context, '/newGTC',
//                                             arguments: <String, String>{
//                                               'title': "ANTM",
//                                             });
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode: "ANTM",
//                                               board: "RG",
//                                             )
//                                           ],
//                                           commant: 1,
//                                         );

//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: "ANTM",
//                                           commant: '1',
//                                           board: 'RG',
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'NEW GTC ORDER',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                           context,
//                                           '/listGTC',
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'LIST GTC',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, '/newBreak',
//                                             arguments: <String, String>{
//                                               'title': "",
//                                             });
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode: "ANTM",
//                                               board: "RG",
//                                             )
//                                           ],
//                                           commant: 1,
//                                         );

//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: "ANTM",
//                                           commant: '1',
//                                           board: 'RG',
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'BREAK ORDER',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, '/ListBreakOrderMain',
//                                             arguments: <String, String>{
//                                               'title': "",
//                                             });
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'LIST BREAK ORDER',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, '/newTraling',
//                                             arguments: <String, String>{
//                                               'title': "",
//                                             });
//                                         ActivityRequest.quoteRequest(
//                                           packageId: Constans.PACKAGE_ID_QUOTES,
//                                           arrayStockCode: [
//                                             ArrayStockCode(
//                                               stockCode: "ANTM",
//                                               board: "RG",
//                                             )
//                                           ],
//                                           commant: 1,
//                                         );

//                                         ActivityRequest.orderBookRequest(
//                                           packageId:
//                                               Constans.PACKAGE_ID_ORDER_BOOK,
//                                           stockCode: "ANTM",
//                                           commant: '1',
//                                           board: 'RG',
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'TRAILING ORDER',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                           context,
//                                           '/newListTraling',
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'LIST TRAILING ORDER',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     GestureDetector(
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.circle_outlined,
//                                             color: putihop85,
//                                             size: 0.03.sw,
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Text(
//                                             'SPEAD ORDER',
//                                             style: TextStyle(
//                                               color: putihop85,
//                                               fontSize: FontSizes.size12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
