import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/bottomnavbarwidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/homeview_widget/appbarwidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/homeview_widget/widget/settings.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/historical_tradelist/historical_tradelist_main.dart';
import 'package:online_trading/view/checkoutview/mainchechout_view.dart';
import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isExpandOrder = false.obs;
    RxBool isExpandAdvanceOrder = false.obs;
    // RxBool isExpandAccount = false.obs;
    RxBool isExpandMarketInfo = false.obs;
    var a = previousRouteObserver.lastCode;

    var query = ObjectBoxDatabase.StockCodeRangking.query(
      StockData_.reqType.equals(1) & StockData_.iBoard.equals(0),
    ).build().findFirst();
    var stockCode = a ??
        (query == null || query.arrayData.isEmpty
            ? 'ANTM'
            : query.arrayData.first.stockCode);
    return Drawer(
        width: 0.7.sw,
        backgroundColor: bgabu,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120.h,
              width: double.infinity,
              color: Colors.black,
              padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Master Menu",
                    style: TextStyle(color: putihop85, fontSize: 14.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: const Duration(milliseconds: 250),
                              child: const SettingsView(),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Icon(
                      Icons.settings,
                      color: putihop85,
                      size: 20.sp,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    trailing: Obx(() {
                      return Icon(
                        isExpandMarketInfo.value
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down,
                        color: putihop85,
                        size: 25.sp,
                      );
                    }),
                    title: Text(
                      'Market Info',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size15,
                      ),
                    ),
                    onTap: () {
                      isExpandMarketInfo.toggle();
                    },
                  ),
                  Obx(() {
                    if (isExpandMarketInfo.value) {
                      return Expanded(
                        child: AnimatedContainer(
                          width: double.infinity,
                          duration: const Duration(seconds: 1),
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 10.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Quote',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/goDetailview',
                                      arguments: <String, String>{
                                        'title': stockCode!,
                                        'subtitle': '',
                                        'board': Get.put(
                                          ControllerBoard(),
                                        ).boards.value,
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Index',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    index.value = 1;
                                    tabController.index = index.value;
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Running Trade',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    index.value = 2;
                                    tabController.index = index.value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  ListTile(
                    trailing: Obx(() {
                      return Icon(
                        isExpandOrder.value
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down,
                        color: putihop85,
                        size: 25.sp,
                      );
                    }),
                    title: Text(
                      'Order',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size15,
                      ),
                    ),
                    onTap: () {
                      isExpandOrder.toggle();
                    },
                  ),
                  Obx(() {
                    if (isExpandOrder.value) {
                      return Expanded(
                        child: AnimatedContainer(
                          width: double.infinity,
                          duration: const Duration(seconds: 1),
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 10.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Buy',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    ActivityRequest.quoteRequest(
                                      packageId: Constans.PACKAGE_ID_QUOTES,
                                      commant: 1,
                                      arrayStockCode: [
                                        ArrayStockCode(
                                          stockCode: stockCode,
                                          board: Get.find<ControllerBoard>()
                                              .boards
                                              .value,
                                        )
                                      ],
                                    );
                                    ActivityRequest.orderBookRequest(
                                      packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                      stockCode: stockCode!,
                                      board: Get.find<ControllerBoard>()
                                          .boards
                                          .value,
                                      commant: "1",
                                    );
                                    var query = ObjectBoxDatabase.quotesBox
                                        .query(Quotes_.stockCode.equals(
                                              stockCode,
                                            ) &
                                            Quotes_.board.equals(
                                                Get.find<ControllerBoard>()
                                                    .boards
                                                    .value))
                                        .build()
                                        .findFirst();
                                    indexTabNewOrder.value = 0;

                                    Navigator.pushNamed(
                                      context,
                                      '/goCheckoutview',
                                      arguments: <String, String>{
                                        'prevP': "${query!.prevPrice}",
                                        'title': stockCode,
                                        'subtitle': ObjectBoxDatabase.stockList
                                            .query(PackageStockList_.stcokCode
                                                .equals(stockCode))
                                            .build()
                                            .findFirst()!
                                            .stockName!,
                                        'board': Get.find<ControllerBoard>()
                                            .boards
                                            .value,
                                        'typeCheckout': "BUY",
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Sell',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    ActivityRequest.quoteRequest(
                                      packageId: Constans.PACKAGE_ID_QUOTES,
                                      commant: 1,
                                      arrayStockCode: [
                                        ArrayStockCode(
                                          stockCode: stockCode,
                                          board: Get.find<ControllerBoard>()
                                              .boards
                                              .value,
                                        )
                                      ],
                                    );
                                    ActivityRequest.orderBookRequest(
                                      packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                      stockCode: stockCode!,
                                      board: Get.find<ControllerBoard>()
                                          .boards
                                          .value,
                                      commant: "1",
                                    );
                                    var query = ObjectBoxDatabase.quotesBox
                                        .query(Quotes_.stockCode.equals(
                                              stockCode,
                                            ) &
                                            Quotes_.board.equals(
                                                Get.find<ControllerBoard>()
                                                    .boards
                                                    .value))
                                        .build()
                                        .findFirst();
                                    indexTabNewOrder.value = 1;

                                    Navigator.pushNamed(
                                      context,
                                      '/goCheckoutview',
                                      arguments: <String, String>{
                                        'prevP': "${query!.prevPrice}",
                                        'title': stockCode,
                                        'subtitle': ObjectBoxDatabase.stockList
                                            .query(PackageStockList_.stcokCode
                                                .equals(stockCode))
                                            .build()
                                            .findFirst()!
                                            .stockName!,
                                        'board': Get.find<ControllerBoard>()
                                            .boards
                                            .value,
                                        'typeCheckout': "SELL",
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Amend',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    ActivityRequest.parameterRequest(
                                        requestFlag: 1);

                                    ActivityRequest.quoteRequest(
                                      packageId: Constans.PACKAGE_ID_QUOTES,
                                      commant: 1,
                                      arrayStockCode: [
                                        ArrayStockCode(
                                          stockCode: stockCode,
                                          board: Get.find<ControllerBoard>()
                                              .boards
                                              .value,
                                        )
                                      ],
                                    );
                                    ActivityRequest.orderBookRequest(
                                      packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                      stockCode: stockCode!,
                                      board: Get.find<ControllerBoard>()
                                          .boards
                                          .value,
                                      commant: "1",
                                    );
                                    var query = ObjectBoxDatabase.quotesBox
                                        .query(Quotes_.stockCode.equals(
                                              stockCode,
                                            ) &
                                            Quotes_.board.equals(
                                                Get.find<ControllerBoard>()
                                                    .boards
                                                    .value))
                                        .build()
                                        .findFirst();

                                    Navigator.pushNamed(
                                      context,
                                      '/goCheckoutviewAmendAndWD',
                                      arguments: <String, String>{
                                        'prevP': "${query!.prevPrice}",
                                        'title': stockCode,
                                        'subtitle': '',
                                        'board': Get.find<ControllerBoard>()
                                            .boards
                                            .value,
                                        'typeCheckout': "AMEND",
                                        'isFormC': "true",
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Withdraw',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    ActivityRequest.parameterRequest(
                                        requestFlag: 1);

                                    ActivityRequest.quoteRequest(
                                      packageId: Constans.PACKAGE_ID_QUOTES,
                                      commant: 1,
                                      arrayStockCode: [
                                        ArrayStockCode(
                                          stockCode: stockCode,
                                          board: Get.put(ControllerBoard())
                                              .boards
                                              .value,
                                        )
                                      ],
                                    );
                                    ActivityRequest.orderBookRequest(
                                      packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                      stockCode: stockCode!,
                                      board: Get.find<ControllerBoard>()
                                          .boards
                                          .value,
                                      commant: "1",
                                    );
                                    var query = ObjectBoxDatabase.quotesBox
                                        .query(Quotes_.stockCode
                                                .equals(stockCode) &
                                            Quotes_.board.equals(
                                                Get.find<ControllerBoard>()
                                                    .boards
                                                    .value))
                                        .build()
                                        .findFirst();

                                    Navigator.pushNamed(
                                      context,
                                      '/goCheckoutviewAmendAndWD',
                                      arguments: <String, String>{
                                        'prevP': "${query!.prevPrice}",
                                        'title': stockCode,
                                        'subtitle': '',
                                        'board': Get.find<ControllerBoard>()
                                            .boards
                                            .value,
                                        'typeCheckout': "WITHDRAW",
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Orderlist',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.put(OrderListController());
                                    Navigator.pushNamed(context, '/orderList',
                                        arguments: <String, String>{
                                          'A': 'B',
                                        });
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Historical Orderlist',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.toNamed('/historiOrder');
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Tradelist',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.toNamed('/tradeList');
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'Historical Trade List',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const HistoricalTradeListMain();
                                      },
                                    ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  ListTile(
                    trailing: Obx(() {
                      return Icon(
                        isExpandAdvanceOrder.value
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down,
                        color: putihop85,
                        size: 25.sp,
                      );
                    }),
                    title: Text(
                      'Advance Order',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size15,
                      ),
                    ),
                    onTap: () {
                      isExpandAdvanceOrder.toggle();
                    },
                  ),
                  Obx(() {
                    if (isExpandAdvanceOrder.value) {
                      return Expanded(
                        child: AnimatedContainer(
                          width: double.infinity,
                          duration: const Duration(seconds: 1),
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 10.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'New GTC Order',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/newGTC',
                                        arguments: <String, String>{
                                          'title': stockCode!,
                                        });
                                    ActivityRequest.quoteRequest(
                                      packageId: Constans.PACKAGE_ID_QUOTES,
                                      arrayStockCode: [
                                        ArrayStockCode(
                                          stockCode: stockCode,
                                          board: Get.find<ControllerBoard>()
                                              .boards
                                              .value,
                                        )
                                      ],
                                      commant: 1,
                                    );

                                    ActivityRequest.orderBookRequest(
                                      packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                      stockCode: stockCode,
                                      commant: '1',
                                      board: Get.find<ControllerBoard>()
                                          .boards
                                          .value,
                                    );
                                  },
                                ),
                                ListTile(
                                  minLeadingWidth: 5.w,
                                  titleAlignment: ListTileTitleAlignment.center,
                                  leading: Icon(
                                    Icons.circle,
                                    color: putihop85,
                                    size: 10.sp,
                                  ),
                                  title: Text(
                                    'List GTC',
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size13,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/listGTC',
                                    );
                                  },
                                ),
                                // ListTile(
                                //   minLeadingWidth: 5.w,
                                //   titleAlignment: ListTileTitleAlignment.center,
                                //   leading: Icon(
                                //     Icons.circle,
                                //     color: putihop85,
                                //     size: 10.sp,
                                //   ),
                                //   title: Text(
                                //     'Break Order',
                                //     style: TextStyle(
                                //       color: putihop85,
                                //       fontSize: FontSizes.size13,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     Navigator.pushNamed(context, '/newBreak',
                                //         arguments: <String, String>{
                                //           'title': stockCode!,
                                //         });
                                //     ActivityRequest.quoteRequest(
                                //       packageId: Constans.PACKAGE_ID_QUOTES,
                                //       commant: 1,
                                //       arrayStockCode: [
                                //         ArrayStockCode(
                                //           stockCode: stockCode,
                                //           board: Get.find<ControllerBoard>()
                                //               .boards
                                //               .value,
                                //         )
                                //       ],
                                //     );
                                //     ActivityRequest.orderBookRequest(
                                //       packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                //       stockCode: stockCode,
                                //       board: Get.find<ControllerBoard>()
                                //           .boards
                                //           .value,
                                //       commant: "1",
                                //     );
                                //   },
                                // ),
                                // ListTile(
                                //   minLeadingWidth: 5.w,
                                //   titleAlignment: ListTileTitleAlignment.center,
                                //   leading: Icon(
                                //     Icons.circle,
                                //     color: putihop85,
                                //     size: 10.sp,
                                //   ),
                                //   title: Text(
                                //     'List Break Order',
                                //     style: TextStyle(
                                //       color: putihop85,
                                //       fontSize: FontSizes.size13,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //         context, '/ListBreakOrderMain',
                                //         arguments: <String, String>{
                                //           'title': "",
                                //         });
                                //   },
                                // ),
                                // ListTile(
                                //   minLeadingWidth: 5.w,
                                //   titleAlignment: ListTileTitleAlignment.center,
                                //   leading: Icon(
                                //     Icons.circle,
                                //     color: putihop85,
                                //     size: 10.sp,
                                //   ),
                                //   title: Text(
                                //     'Trailing Order',
                                //     style: TextStyle(
                                //       color: putihop85,
                                //       fontSize: FontSizes.size13,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     Navigator.pushNamed(context, '/newTraling',
                                //         arguments: <String, String>{
                                //           'title': stockCode!,
                                //         });
                                //     ActivityRequest.quoteRequest(
                                //       packageId: Constans.PACKAGE_ID_QUOTES,
                                //       commant: 1,
                                //       arrayStockCode: [
                                //         ArrayStockCode(
                                //           stockCode: stockCode,
                                //           board: Get.find<ControllerBoard>()
                                //               .boards
                                //               .value,
                                //         )
                                //       ],
                                //     );
                                //     ActivityRequest.orderBookRequest(
                                //       packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                                //       stockCode: stockCode,
                                //       board: Get.find<ControllerBoard>()
                                //           .boards
                                //           .value,
                                //       commant: "1",
                                //     );
                                //   },
                                // ),
                                // ListTile(
                                //   minLeadingWidth: 5.w,
                                //   titleAlignment: ListTileTitleAlignment.center,
                                //   leading: Icon(
                                //     Icons.circle,
                                //     color: putihop85,
                                //     size: 10.sp,
                                //   ),
                                //   title: Text(
                                //     'List Trailing Order',
                                //     style: TextStyle(
                                //       color: putihop85,
                                //       fontSize: FontSizes.size13,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //       context,
                                //       '/newListTraling',
                                //     );
                                //   },
                                // ),
                                // ListTile(
                                //   minLeadingWidth: 5.w,
                                //   titleAlignment: ListTileTitleAlignment.center,
                                //   leading: Icon(
                                //     Icons.circle,
                                //     color: putihop85,
                                //     size: 10.sp,
                                //   ),
                                //   title: Text(
                                //     'Spread Order',
                                //     style: TextStyle(
                                //       color: putihop85,
                                //       fontSize: FontSizes.size13,
                                //     ),
                                //   ),
                                //   onTap: () {},
                                // ),
                                // ListTile(
                                //   minLeadingWidth: 5.w,
                                //   titleAlignment: ListTileTitleAlignment.center,
                                //   leading: Icon(
                                //     Icons.circle,
                                //     color: putihop85,
                                //     size: 10.sp,
                                //   ),
                                //   title: Text(
                                //     'List Spread Order',
                                //     style: TextStyle(
                                //       color: putihop85,
                                //       fontSize: FontSizes.size13,
                                //     ),
                                //   ),
                                //   onTap: () {
                                //     Navigator.pushNamed(
                                //       context,
                                //       '/ListSpreadOrderView',
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  ListTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: putihop85,
                      size: 25.sp,
                    ),
                    title: Text(
                      'Account',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size15,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      bottomindex.value = 2;
                    },
                  ),
                  // ListTile(
                  //   trailing: Obx(() {
                  //     return Icon(
                  //       isExpandAccount.value
                  //           ? Icons.keyboard_arrow_right
                  //           : Icons.keyboard_arrow_down,
                  //       color: putihop85,
                  //       size: 25.sp,
                  //     );
                  //   }),
                  //   title: Text(
                  //     'Account',
                  //     style: TextStyle(
                  //       color: putihop85,
                  //       fontSize: FontSizes.size15,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     isExpandAccount.toggle();
                  //   },
                  // ),
                  // Obx(() {
                  //   if (isExpandAccount.value) {
                  //     return Expanded(
                  //       child: AnimatedContainer(
                  //         width: double.infinity,
                  //         duration: const Duration(seconds: 1),
                  //         color: Colors.transparent,
                  //         padding: EdgeInsets.only(left: 10.w),
                  //         child: SingleChildScrollView(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Account Info',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Transaction Report',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Realized Gain/Loss',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Tax Report',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Statement of Account',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Cash Ledger',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Trade Confirmation',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Cash Withdraw',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Monthly Balance',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Transaction and Holidays',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //               ListTile(
                  //                 minLeadingWidth: 5.w,
                  //                 titleAlignment: ListTileTitleAlignment.center,
                  //                 leading: Icon(
                  //                   Icons.circle,
                  //                   color: putihop85,
                  //                   size: 10.sp,
                  //                 ),
                  //                 title: Text(
                  //                   'Exercise Right/Warrant',
                  //                   style: TextStyle(
                  //                     color: putihop85,
                  //                     fontSize: FontSizes.size13,
                  //                   ),
                  //                 ),
                  //                 onTap: () {},
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   } else {
                  //     return Container();
                  //   }
                  // }),
                ],
              ),
            )
          ],
        ));
  }
}
