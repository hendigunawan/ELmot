import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/orderListReq.model.dart';
import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/Orderbook.main.mobile.dart';
import 'package:online_trading/view/checkoutview/mainAmend.view.dart';
import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/new_OrderBuy.widget.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/new_OrderSell.widget.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/search_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:synchronized/synchronized.dart';

enum ChackOut {
  BUY,
  SELL,
}

RxBool isReplacement = false.obs;
RxString onChackOut = ''.obs;

// ignore: must_be_immutable
class MainCheckOutView extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? board;
  String? typeCheckout;
  int prevP;
  MainCheckOutView(
      {super.key,
      required this.title,
      required this.subtitle,
      this.board,
      required this.typeCheckout,
      required this.prevP});

  @override
  State<MainCheckOutView> createState() => _MainCheckOutViewState();
}

RxInt indexTabNewOrder = 0.obs;

class _MainCheckOutViewState extends State<MainCheckOutView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  RxBool isShow = true.obs;
  final controllerPin = Get.put(PinSave());
  TextEditingController controller = TextEditingController();
  ConnectionsController getConnect = Get.find();
  var getBodyController = Get.put(BodyController());
  var query = Get.put(DetailSahamController());

  final Lock lock = Lock();
  late String pin = '';

  void datas() async {
    await lock.synchronized(() {
      ActivityRequest.quoteRequest(
        packageId: Constans.PACKAGE_ID_QUOTES,
        commant: 1,
        arrayStockCode: [
          ArrayStockCode(
            stockCode: widget.title,
            board: Get.find<ControllerBoard>().boards.value,
          )
        ],
      );
      ActivityRequest.orderBookRequest(
        packageId: Constans.PACKAGE_ID_ORDER_BOOK,
        stockCode: widget.title,
        board: Get.find<ControllerBoard>().boards.value,
        commant: "1",
      );
      query.getpreviousPrice(
          stockcode: widget.title,
          board: Get.find<ControllerBoard>().boards.value);

      ActivityRequest.parameterRequest(requestFlag: 1);
    });
    if (controllerPin.pin.value != '') {
      controllerPin.request();
    }
  }

  @override
  void initState() {
    super.initState();
    datas();

    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: indexTabNewOrder.value,
    );
    Get.put(BuildingMassageOrder());
    Future.delayed(
      Duration.zero,
      () {
        getBodyController.priceController.text = formattaCurrun(
          query.lastPrice.value == 0
              ? query.previousPrice.value
              : query.lastPrice.value,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          Get.put(BodyController()).onClear();
          Get.put(PinSave()).onPop();

          if (isRun1.value == true) isRun1.toggle();
          if (isRun2.value == true) isRun2.toggle();
          Get.put(PinSave()).onPop();
          Get.put(OrderListController()).data.value = OrderList();
          listTradeList.clear();
          if (isReplacement.value == true) {
            Navigator.pushReplacementNamed(context, '/');
            isReplacement.value = false;
          } else {
            Navigator.of(context).pop();
          }
          return true;
        },
        child: Stack(
          children: [
            Obx(() {
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  leading: GestureDetector(
                    onTap: () {
                      Get.put(BodyController()).onClear();
                      Get.put(PinSave()).onPop();
                      if (isRun1.value == true) isRun1.toggle();
                      if (isRun2.value == true) isRun2.toggle();
                      Get.put(PinSave()).onPop();
                      Get.put(OrderListController()).data.value = OrderList();
                      listTradeList.clear();
                      if (isReplacement.value == true) {
                        Navigator.pushReplacementNamed(context, '/');
                        isReplacement.value = false;
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: IconSizes.backArrowSize,
                    ),
                  ),
                  title: isSearchq.value == false
                      ? Text(
                          'NEW ORDER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size16,
                          ),
                        )
                      : SearchWidget(
                          autofocuskeyboard: true,
                          hint: widget.title,
                          controller: controller,
                          onPressedX: () {
                            if (controller.length == 0 ||
                                controller.text == '') {
                              isSearchq.toggle();
                              isSearchq.refresh();
                              controller.clear();
                            } else {
                              controller.clear();
                              FocusScope.of(context).requestFocus();
                            }
                          },
                          onFinnis: (a) {
                            isReplacement.value = true;
                            Navigator.of(context).pushReplacementNamed(
                              '/goCheckoutview',
                              arguments: <String, String>{
                                'prevP': query.previousPrice.toString(),
                                'title': a,
                                'subtitle': '',
                                'board':
                                    Get.find<ControllerBoard>().boards.value,
                                'typeCheckout': widget.typeCheckout!,
                              },
                            );
                          },
                        ),
                ),
                body: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: ObjectBoxDatabase.qoutesRealtimeWithQuery(
                        widget.title, Get.find<ControllerBoard>().boards.value),
                    builder: (context, snapshot) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Pin.show(
                              onComplete: (text) {
                                fokusNode.unfocus();
                                controllerPin.pin.value = text;
                                pin = text;
                                controllerPin.savePin(
                                  text,
                                  stockCodes: snapshot.data!.first.stockCode!,
                                );
                                controllerPin.request();
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
                              typeCheckout: widget.typeCheckout!,
                              title: widget.title,
                              board: Get.find<ControllerBoard>().boards.value,
                              boardWidget: PopupMenuButton(
                                constraints: const BoxConstraints(),
                                color: foregroundwidget,
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: BoardOption.RG,
                                    child: Center(
                                      child: Text(
                                        'RG',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  // PopupMenuItem(
                                  //   value: BoardOption.TN,
                                  //   child: Center(
                                  //     child: Text(
                                  //       'TN',
                                  //       style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 14.sp),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                                onSelected: (value) {
                                  switch (value) {
                                    case BoardOption.RG:
                                      Get.find<ControllerBoard>()
                                          .updateBoard('RG');
                                    case BoardOption.NG:
                                      Get.find<ControllerBoard>()
                                          .updateBoard('NG');
                                    case BoardOption.TN:
                                      Get.find<ControllerBoard>()
                                          .updateBoard('TN');
                                  }
                                  datas();
                                },
                                child: Container(
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
                            ),
                            Pin.showLimit(stockCode: widget.title),
                            Obx(
                              () {
                                return Container(
                                  width: 1.sw,
                                  height: isMore.value ? 0.5535.sh : 0.365.sh,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(7.r),
                                    border: Border.all(
                                      width: 0.5.w,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: 5.h, left: 19.h, right: 19.h),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                        child: TabBar(
                                          controller: tabController,
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          dividerColor: Colors.transparent,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          indicatorColor:
                                              indexTabNewOrder.value == 0
                                                  ? Colors.red
                                                  : indexTabNewOrder.value == 1
                                                      ? Colors.green
                                                      : putihop85,
                                          onTap: (i) {
                                            Get.find<BodyController>()
                                                .onClear();
                                            Future.delayed(
                                              Duration.zero,
                                              () {
                                                getBodyController
                                                    .priceController
                                                    .text = formattaCurrun(
                                                  query.lastPrice.value == 0
                                                      ? query
                                                          .previousPrice.value
                                                      : query.lastPrice.value,
                                                );
                                              },
                                            );
                                            indexTabNewOrder.value = i;
                                            indexTabNewOrder.refresh();
                                          },
                                          tabs: [
                                            Tab(
                                              child: Text(
                                                'BUY',
                                                style: TextStyle(
                                                  fontSize: FontSizes.size13,
                                                  color:
                                                      indexTabNewOrder.value ==
                                                              0
                                                          ? Colors.red
                                                          : putihop85,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                'SELL',
                                                style: TextStyle(
                                                  fontSize: FontSizes.size13,
                                                  color:
                                                      indexTabNewOrder.value ==
                                                              1
                                                          ? Colors.green
                                                          : putihop85,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: tabController,
                                          children: [
                                            NewOrderBuyWidget(
                                              title: widget.title,
                                              onTapStock: (a) {
                                                Navigator.of(context).pop();
                                                if (!delistingStock(
                                                    a.stockCode!)) {
                                                  NotifikasiPopup.showWarning(
                                                    'Sorry, but the stock you have selected is not available in the market or has been delisted. Please contact customer service for more detailed information.',
                                                  );
                                                  return;
                                                }
                                                tabController.index = 1;
                                                indexTabNewOrder.value = 1;
                                                ActivityRequest.quoteRequest(
                                                  packageId: Constans
                                                      .PACKAGE_ID_QUOTES,
                                                  commant: 1,
                                                  arrayStockCode: [
                                                    ArrayStockCode(
                                                      stockCode: a.stockCode!,
                                                      board: Get.find<
                                                              ControllerBoard>()
                                                          .boards
                                                          .value,
                                                    )
                                                  ],
                                                );
                                                ActivityRequest
                                                    .orderBookRequest(
                                                  packageId: Constans
                                                      .PACKAGE_ID_ORDER_BOOK,
                                                  stockCode: a.stockCode!,
                                                  board: Get.find<
                                                          ControllerBoard>()
                                                      .boards
                                                      .value,
                                                  commant: "1",
                                                );
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500),
                                                  () {
                                                    getBodyController
                                                        .qtyController
                                                        .text = (a.balance! ~/
                                                            Get.find<
                                                                    LoginOrderController>()
                                                                .order!
                                                                .value
                                                                .lot!)
                                                        .toString();

                                                    getBodyController
                                                        .stockEstimasiData
                                                        .value = 0;
                                                    Future.delayed(
                                                        Duration.zero,
                                                        () => getBodyController
                                                                .stockEstimasiData
                                                                .value =
                                                            getBodyController
                                                                .stockEstimasi());
                                                    if (a.stockCode !=
                                                        widget.title) {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                        context,
                                                        '/goCheckoutview',
                                                        arguments: <String,
                                                            String>{
                                                          'prevP': "0",
                                                          'title': a.stockCode!,
                                                          'subtitle': ObjectBoxDatabase
                                                              .stockList
                                                              .query(PackageStockList_
                                                                  .stcokCode
                                                                  .equals(Get.find<
                                                                          ControllerBoard>()
                                                                      .stockCodes
                                                                      .value))
                                                              .build()
                                                              .findFirst()!
                                                              .stockName!,
                                                          'board': Get.find<
                                                                  ControllerBoard>()
                                                              .boards
                                                              .value,
                                                          'typeCheckout':
                                                              "SELL",
                                                        },
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            NewOrderSellWidget(
                                              title: widget.title,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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
                                  ' Click your buying price below',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: FontSizes.size12,
                                  ),
                                ),
                                Container(
                                  width: 60.w,
                                  height: 1,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Flexible(
                              flex: 1,
                              child: Obx(
                                () {
                                  return SreamOBView(
                                    prevP: query.previousPrice.toInt(),
                                    stockCsearch: widget.title,
                                    board: Get.find<ControllerBoard>()
                                        .boards
                                        .value,
                                    onTapBid: (val) {
                                      getBodyController.priceController.text =
                                          val;
                                      getBodyController
                                              .stockEstimasiData.value =
                                          int.parse(val.replaceAll(r',', ''));
                                    },
                                    onTapOffer: (val) {
                                      getBodyController.priceController.text =
                                          val;
                                      getBodyController
                                              .stockEstimasiData.value =
                                          int.parse(val.replaceAll(r',', ''));
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            getConnect.onError()
                ? GestureDetector(
                    onTap: () {
                      getConnect.onErrors.toggle();
                    },
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.9),
                        height: Get.height,
                        width: Get.width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: foregroundwidget,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          padding: EdgeInsets.all(20.r),
                          height: 0.425.sh,
                          width: 0.7.sw,
                          alignment: Alignment.center,
                          child: Text(
                            'ERROR CONNECT \n PLEASE TURN ON INTERNET OR CHECK VPN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSizes.size15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}

// // ignore_for_file: use_build_context_synchronously, prefer_is_empty, unrelated_type_equality_checks, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:online_trading/helper/constant_style.dart';
// import 'package:online_trading/helper/constants.dart';
// import 'package:online_trading/helper/fontstyleConstans.dart';
// import 'package:online_trading/module/ordering/model/order/orderListReq.model.dart';
// import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
// import 'package:online_trading/module/request/activity/acty_request.dart';
// import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
// import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/Orderbook.main.mobile.dart';
// import 'package:online_trading/view/checkoutview/mainAmend.view.dart';
// import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
// import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';
// import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
// import 'package:online_trading/view/widget/pin/pin.widget.dart';
// import 'package:online_trading/view/widget/search_widget.dart';
// import 'package:synchronized/synchronized.dart';

// enum ChackOut {
//   BUY,
//   SELL,
// }

// RxBool isReplacement = false.obs;

// class MainCheckOutView extends StatefulWidget {
//   final String title;
//   final String subtitle;
//   final String? board;
//   String? typeCheckout;
//   final int prevP;
//   MainCheckOutView(
//       {super.key,
//       required this.title,
//       required this.subtitle,
//       this.board,
//       required this.typeCheckout,
//       required this.prevP});

//   @override
//   State<MainCheckOutView> createState() => _MainCheckOutViewState();
// }

// class _MainCheckOutViewState extends State<MainCheckOutView> {
//   var getBodyController = Get.put(BodyController());
//   @override
//   Widget build(BuildContext context) {
//     RxBool isshowSearch = false.obs;
//     final controllerPin = Get.put(PinSave());
//     TextEditingController controller = TextEditingController();
//     var query = Get.put(DetailSahamController());
//     var controllerCheckout = Get.put(CheckoutController());
//     return WillPopScope(
//       onWillPop: () async {
//         Get.put(BodyController()).onClear();
//         Get.put(PinSave()).onPop();
//         if (isRun1.value == true) isRun1.toggle();
//         if (isRun2.value == true) isRun2.toggle();
//         Get.put(PinSave()).onPop();
//         Get.put(OrderListController()).data.value = OrderList();
//         listTradeList.clear();
//         if (isReplacement.value == true) {
//           Navigator.pushReplacementNamed(context, '/');
//           isReplacement.value = false;
//         } else {
//           Navigator.of(context).pop();
//         }
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//           centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Get.put(BodyController()).onClear();
//               Get.put(PinSave()).onPop();
//               if (isRun1.value == true) isRun1.toggle();
//               if (isRun2.value == true) isRun2.toggle();
//               Get.put(PinSave()).onPop();
//               Get.put(OrderListController()).data.value = OrderList();
//               listTradeList.clear();

//               if (isReplacement.value == true) {
//                 Navigator.pushReplacementNamed(context, '/');
//                 isReplacement.value = false;
//               } else {
//                 Navigator.of(context).pop();
//               }
//             },
//             child: Icon(
//               Icons.arrow_back,
//               size: IconSizes.backArrowSize,
//             ),
//           ),
//           title: Obx(() {
//             isReplacement.value;
//             return PopupMenuButton(
//               color: foregroundwidget,
//               itemBuilder: (contex) => [
//                 const PopupMenuItem(
//                   value: ChackOut.BUY,
//                   child: Center(
//                     child: Text(
//                       'BUY',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const PopupMenuItem(
//                   value: ChackOut.SELL,
//                   child: Center(
//                     child: Text(
//                       'SELL',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//               onSelected: (value) {
//                 switch (value) {
//                   case ChackOut.BUY:
//                     setState(() {
//                       widget.typeCheckout = 'BUY';
//                     });
//                     break;
//                   case ChackOut.SELL:
//                     setState(() {
//                       widget.typeCheckout = 'SELL';
//                     });
//                     break;
//                 }
//               },
//               child: isSearchq.value == false
//                   ? Text(
//                       widget.typeCheckout!,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: FontSizes.size16,
//                       ),
//                     )
//                   : SearchWidget(
//                       autofocuskeyboard: true,
//                       hint: widget.title,
//                       controller: controller,
//                       onPressedX: () {
//                         controller.clear();
//                         isSearchq.toggle();
//                         isSearchq.refresh();
//                       },
//                       onFinnis: (a) {
//                         isReplacement.value = true;
//                         Navigator.of(context).pushReplacementNamed(
//                           '/goCheckoutview',
//                           arguments: <String, String>{
//                             'prevP': '0',
//                             'title': a,
//                             'subtitle': '',
//                             'board': Get.find<ControllerBoard>().boards.value,
//                             'typeCheckout': widget.typeCheckout!,
//                           },
//                         );
//                       },
//                     ),
//             );
//           }),
//           // title: Obx(() {
//           //   return !isshowSearch.value
//           //       ? GestureDetector(
//           //           onTap: () {
//           //             isshowSearch.toggle();
//           //           },
//           //           child: Text(
//           //             widget.title,
//           //             style: TextStyle(
//           //               color: Colors.white,
//           //               fontSize: FontSizes.size16,
//           //             ),
//           //           ),
//           //         )
//           //       : SearchWidget(
//           //           autofocuskeyboard: true,
//           //           hint: widget.title,
//           //           controller: controller,
//           //           onPressedX: () {
//           //             controller.clear();
//           //             isSearchq.toggle();
//           //             isSearchq.refresh();
//           //           },
//           //           onFinnis: (a) {
//           //             isReplacement.value = true;
//           //             Navigator.of(context).pushReplacementNamed(
//           //               '/goCheckoutview',
//           //               arguments: <String, String>{
//           //                 'prevP': '0',
//           //                 'title': a,
//           //                 'subtitle': '',
//           //                 'board': controllerBoard,
//           //                 'typeCheckout': widget.typeCheckout!,
//           //               },
//           //             );
//           //           },
//           //         );
//           // }),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Pin.show(
//                 onComplete: (text) {
//                   fokusNode.unfocus();
//                   controllerPin.pin.value = text;
//                   controllerPin.savePin(
//                     text,
//                     stockCodes: widget.title,
//                   );
//                   controllerPin.request();
//                 },
//                 onSelect: () {
//                   Future.delayed(
//                     const Duration(milliseconds: 50),
//                     () {
//                       Get.find<PinSave>().request();
//                     },
//                   );
//                 },
//               ),
//               Obx(() {
//                 isshowSearch.value;
//                 return DetailCheckOut(
//                   typeCheckout: widget.typeCheckout!,
//                   title: widget.title,
//                   board: Get.find<ControllerBoard>().boards.value,
//                   boardWidget: PopupMenuButton(
//                     constraints: const BoxConstraints(),
//                     color: foregroundwidget,
//                     itemBuilder: (context) => [
//                       const PopupMenuItem(
//                         value: BoardOption.RG,
//                         child: Center(
//                           child: Text(
//                             'RG',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       const PopupMenuItem(
//                         value: BoardOption.TN,
//                         child: Center(
//                           child: Text(
//                             'TN',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                     onSelected: (value) {
//                       switch (value) {
//                         case BoardOption.RG:
//                           Get.find<ControllerBoard>().updateBoard('RG');
//                         case BoardOption.NG:
//                           Get.find<ControllerBoard>().updateBoard('NG');
//                         case BoardOption.TN:
//                           Get.find<ControllerBoard>().updateBoard('TN');
//                       }
//                       setState(() {
//                         controllerCheckout.datas(widget.title,
//                             Get.find<ControllerBoard>().boards.value);
//                       });
//                     },
//                     child: Container(
//                       width: 40.w,
//                       height: 20.h,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         border: Border.all(
//                           width: 1,
//                           color: Colors.green.withOpacity(0.8),
//                         ),
//                       ),
//                       child: Center(
//                         child: GetBuilder<ControllerBoard>(
//                           init: ControllerBoard(),
//                           builder: (controllerBoards) => Text(
//                             controllerBoards.boards.value,
//                             style: TextStyle(
//                               color: Colors.green.withOpacity(0.8),
//                               fontSize: FontSizes.size12,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//               Pin.showLimit(stockCode: widget.title),
//               Obx(() {
//                 return LotDetail(
//                   types: widget.typeCheckout!,
//                   prevpp: query.previousPrice.toInt(),
//                   stockCode: widget.title,
//                 );
//               }),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                       width: 60.w,
//                       height: 1,
//                       color: Colors.white.withOpacity(0.8)),
//                   Text(
//                     ' Click your buying price below',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.8),
//                       fontSize: FontSizes.size12,
//                     ),
//                   ),
//                   Container(
//                       width: 60.w,
//                       height: 1,
//                       color: Colors.white.withOpacity(0.8)),
//                 ],
//               ),
//               SizedBox(height: 5.h),
//               Flexible(
//                 flex: 1,
//                 child: Obx(() {
//                   return SreamOBView(
//                     prevP: query.previousPrice.toInt(),
//                     stockCsearch: widget.title,
//                     board: Get.find<ControllerBoard>().boards.value,
//                     onTapBid: (val) {
//                       getBodyController.priceController.text = val;
//                     },
//                     onTapOffer: (val) {
//                       getBodyController.priceController.text = val;
//                     },
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CheckoutController extends GetxController {
//   var query = Get.find<DetailSahamController>();
//   void datas(String title, String board) async {
//     final lock = Lock();
//     await lock.synchronized(() {
//       ActivityRequest.quoteRequest(
//         packageId: Constans.PACKAGE_ID_QUOTES,
//         commant: 1,
//         arrayStockCode: [
//           ArrayStockCode(
//             stockCode: title,
//             board: board,
//           )
//         ],
//       );
//       ActivityRequest.orderBookRequest(
//         packageId: Constans.PACKAGE_ID_ORDER_BOOK,
//         stockCode: title,
//         board: board,
//         commant: "1",
//       );
//       query.getpreviousPrice(
//           stockcode: title, board: Get.find<ControllerBoard>().boards.value);
//     });
//   }
// }
// // backup 2
// // // ignore: must_be_immutable
// // class MainCheckOutView extends StatefulWidget {
// //   final String title;
// //   final String subtitle;
// //   final String? board;
// //   String? typeCheckout;
// //   final int prevP;
// //   MainCheckOutView(
// //       {super.key,
// //       required this.title,
// //       required this.subtitle,
// //       this.board,
// //       required this.typeCheckout,
// //       required this.prevP});

// //   @override
// //   State<MainCheckOutView> createState() => _MainCheckOutViewState();
// // }

// // class _MainCheckOutViewState extends State<MainCheckOutView> {
// //   RxBool isShow = true.obs;
// //   final controllerPin = Get.put(PinSave());
// //   TextEditingController controller = TextEditingController();
// //   var getBodyController = Get.put(BodyController());
// //   var query = Get.put(DetailSahamController());

// //   final Lock lock = Lock();
// //   late String pin = '';
// //   void datas() async {
// //     await lock.synchronized(() {
// //       ActivityRequest.quoteRequest(
// //         packageId: Constans.PACKAGE_ID_QUOTES,
// //         commant: 1,
// //         arrayStockCode: [
// //           ArrayStockCode(
// //             stockCode: widget.title,
// //             board: Get.find<ControllerBoard>().boards.value,
// //           )
// //         ],
// //       );
// //       ActivityRequest.orderBookRequest(
// //         packageId: Constans.PACKAGE_ID_ORDER_BOOK,
// //         stockCode: widget.title,
// //         board: Get.find<ControllerBoard>().boards.value,
// //         commant: "1",
// //       );
// //       query.getpreviousPrice(
// //           stockcode: widget.title,
// //           board: Get.find<ControllerBoard>().boards.value);
// //     });
// //     if (controllerPin.pin.value != '') {
// //       controllerPin.request();
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     datas();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final controllerBoard = Get.find<ControllerBoard>().boards.value;
// //     Future.delayed(const Duration(milliseconds: 50), () {
// //       if (Get.find<ControllerBoard>().boards.value.isEmpty) {
// //         setState(() {
// //           Get.find<ControllerBoard>().boards();
// //         });
// //       }
// //     });
// //     return Obx(() {
// //       return WillPopScope(
// //         onWillPop: () async {
// //           Get.put(BodyController()).onClear();
// //           Get.put(PinSave()).onPop();
// //           Navigator.of(context).pop();
// //           if (isRun1.value == true) isRun1.toggle();
// //           if (isRun2.value == true) isRun2.toggle();
// //           Get.put(PinSave()).onPop();
// //           Get.put(OrderListController()).data.value = OrderList();
// //           listTradeList.clear();
// //           return true;
// //         },
// //         child: Scaffold(
// //           backgroundColor: Colors.black,
// //           appBar: AppBar(
// //             backgroundColor: Colors.black,
// //             foregroundColor: Colors.white,
// //             centerTitle: true,
// //             leading: GestureDetector(
// //               onTap: () {
// //                 Get.put(BodyController()).onClear();
// //                 Get.put(PinSave()).onPop();
// //                 if (isRun1.value == true) isRun1.toggle();
// //                 if (isRun2.value == true) isRun2.toggle();
// //                 Get.put(PinSave()).onPop();
// //                 Get.put(OrderListController()).data.value = OrderList();
// //                 listTradeList.clear();

// //                 Navigator.of(context).pop();
// //               },
// //               child: Icon(
// //                 Icons.arrow_back,
// //                 size: IconSizes.backArrowSize,
// //               ),
// //             ),
// //             title: PopupMenuButton(
// //               color: foregroundwidget,
// //               itemBuilder: (contex) => [
// //                 const PopupMenuItem(
// //                   value: ChackOut.BUY,
// //                   child: Text(
// //                     'BUY',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //                 const PopupMenuItem(
// //                   value: ChackOut.SELL,
// //                   child: Text(
// //                     'SELL',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //               ],
// //               onSelected: (value) {
// //                 switch (value) {
// //                   case ChackOut.BUY:
// //                     setState(() {
// //                       widget.typeCheckout = 'BUY';
// //                     });
// //                     break;
// //                   case ChackOut.SELL:
// //                     setState(() {
// //                       widget.typeCheckout = 'SELL';
// //                     });
// //                     break;
// //                 }
// //               },
// //               child: isSearchq.value == false
// //                   ? Text(
// //                       widget.typeCheckout!,
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: FontSizes.size16,
// //                       ),
// //                     )
// //                   : SearchWidget(
// //                       autofocuskeyboard: true,
// //                       hint: widget.title,
// //                       controller: controller,
// //                       onPressedX: () {
// //                         controller.clear();
// //                         isSearchq.toggle();
// //                         isSearchq.refresh();
// //                       },
// //                       onFinnis: (a) {
// //                         Navigator.of(context).pushReplacementNamed(
// //                           '/goCheckoutview',
// //                           arguments: <String, String>{
// //                             'prevP': '0',
// //                             'title': a,
// //                             'subtitle': '',
// //                             'board': controllerBoard,
// //                             'typeCheckout': widget.typeCheckout!,
// //                           },
// //                         );
// //                       },
// //                     ),
// //             ),
// //           ),
// //           body: SingleChildScrollView(
// //               child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Pin.show(
// //                 onComplete: (text) {
// //                   fokusNode.unfocus();
// //                   controllerPin.pin.value = text;
// //                   controllerPin.savePin(
// //                     text,
// //                     stockCodes: widget.title,
// //                   );
// //                   controllerPin.request();
// //                 },
// //                 onSelect: () {
// //                   Future.delayed(
// //                     const Duration(milliseconds: 50),
// //                     () {
// //                       Get.find<PinSave>().request();
// //                     },
// //                   );
// //                 },
// //               ),
// //               DetailCheckOut(
// //                 typeCheckout: widget.typeCheckout!,
// //                 title: widget.title,
// //                 board: controllerBoard,
// //                 boardWidget: PopupMenuButton(
// //                   constraints: const BoxConstraints(),
// //                   color: foregroundwidget,
// //                   itemBuilder: (context) => [
// //                     const PopupMenuItem(
// //                       value: BoardOption.RG,
// //                       child: Center(
// //                         child: Text(
// //                           'RG',
// //                           style: TextStyle(color: Colors.white),
// //                         ),
// //                       ),
// //                     ),
// //                     const PopupMenuItem(
// //                       value: BoardOption.TN,
// //                       child: Center(
// //                         child: Text(
// //                           'TN',
// //                           style: TextStyle(color: Colors.white),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                   onSelected: (value) {
// //                     switch (value) {
// //                       case BoardOption.RG:
// //                         Get.find<ControllerBoard>().updateBoard('RG');
// //                       case BoardOption.NG:
// //                         Get.find<ControllerBoard>().updateBoard('NG');
// //                       case BoardOption.TN:
// //                         Get.find<ControllerBoard>().updateBoard('TN');
// //                     }
// //                     datas();
// //                   },
// //                   child: Container(
// //                     width: 40.w,
// //                     height: 20.h,
// //                     alignment: Alignment.center,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(3),
// //                       border: Border.all(
// //                         width: 1,
// //                         color: Colors.green.withOpacity(0.8),
// //                       ),
// //                     ),
// //                     child: Center(
// //                       child: GetBuilder<ControllerBoard>(
// //                         init: ControllerBoard(),
// //                         builder: (controllerBoards) => Text(
// //                           controllerBoards.boards.value,
// //                           style: TextStyle(
// //                             color: Colors.green.withOpacity(0.8),
// //                             fontSize: FontSizes.size12,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Pin.showLimit(stockCode: widget.title),
// //               Obx(() {
// //                 return LotDetail(
// //                   types: widget.typeCheckout!,
// //                   prevpp: query.previousPrice.toInt(),
// //                   stockCode: widget.title,
// //                 );
// //               }),
// //               SizedBox(
// //                 height: 5.h,
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                       width: 60.w,
// //                       height: 1,
// //                       color: Colors.white.withOpacity(0.8)),
// //                   Text(
// //                     ' Click your buying price below',
// //                     style: TextStyle(
// //                       color: Colors.white.withOpacity(0.8),
// //                       fontSize: FontSizes.size12,
// //                     ),
// //                   ),
// //                   Container(
// //                       width: 60.w,
// //                       height: 1,
// //                       color: Colors.white.withOpacity(0.8)),
// //                 ],
// //               ),
// //               SizedBox(height: 5.h),
// //               Flexible(
// //                 flex: 1,
// //                 child: Obx(() {
// //                   return SreamOBView(
// //                     prevP: query.previousPrice.toInt(),
// //                     stockCsearch: widget.title,
// //                     board: controllerBoard,
// //                     onTapBid: (val) {
// //                       getBodyController.priceController.text = val;
// //                     },
// //                     onTapOffer: (val) {
// //                       getBodyController.priceController.text = val;
// //                     },
// //                   );
// //                 }),
// //               ),
// //             ],
// //           )),
// //         ),
// //       );
// //     });
// //   }
// // }
