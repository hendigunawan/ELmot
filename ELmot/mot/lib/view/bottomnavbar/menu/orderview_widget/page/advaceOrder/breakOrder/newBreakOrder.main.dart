import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/controller/breakOrder.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/buyBreak.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/cancelBreak.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/sellBreak.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/Orderbook.main.mobile.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/search_widget.dart';
import 'package:synchronized/synchronized.dart';

RxInt indexTabBreak = 0.obs;

class NewBreakOrderMain extends StatefulWidget {
  final String title;
  const NewBreakOrderMain({super.key, this.title = 'ANTM'});

  @override
  State<NewBreakOrderMain> createState() => _NewBreakOrderMainState();
}

class _NewBreakOrderMainState extends State<NewBreakOrderMain>
    with SingleTickerProviderStateMixin {
  late String pin = '';
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: indexTabBreak.value,
    );
    Get.put(BodyController());
    datas();
    ActivityRequest.parameterRequest(requestFlag: 1);
    Future.delayed(
      Duration.zero,
      () {
        setState(
          () {
            Get.put(BreakOrderContoller()).priceContollerBreak.text =
                formattaCurrun(
              ObjectBoxDatabase.quotesBox
                  .query(Quotes_.stockCode.equals(widget.title) &
                      Quotes_.board
                          .equals(Get.put(ControllerBoard()).boards.value))
                  .build()
                  .findFirst()!
                  .lastPrice!,
            );
          },
        );
      },
    );
  }

  void datas() async {
    final Lock lock = Lock();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BreakOrderContoller>().clearData();
        Get.find<PinSave>().onPop();
        indexTabBreak.value = 0;
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(1.sw, 40.h),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Obx(() {
              return isSearchq.value
                  ? SearchWidget(
                      autofocuskeyboard: true,
                      controller: searchController,
                      onPressedX: () {
                        isSearchq.toggle();
                        searchController.text = '';
                      },
                      onFinnis: (a) {
                        ActivityRequest.quoteRequest(
                          packageId: Constans.PACKAGE_ID_QUOTES,
                          commant: 1,
                          arrayStockCode: [
                            ArrayStockCode(
                              stockCode: a,
                              board: Get.find<ControllerBoard>().boards.value,
                            )
                          ],
                        );
                        ActivityRequest.orderBookRequest(
                          packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                          stockCode: a,
                          board: Get.find<ControllerBoard>().boards.value,
                          commant: "1",
                        );
                        Navigator.of(context).pushReplacementNamed(
                          '/newBreak',
                          arguments: <String, String>{
                            'title': a,
                          },
                        );
                      },
                    )
                  : Text(
                      'New Break Order',
                      style: TextStyle(
                        color: putihop85,
                        fontSize: FontSizes.size16,
                      ),
                    );
            }),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.find<BreakOrderContoller>().clearData();
                Get.find<PinSave>().onPop();
                indexTabBreak.value = 0;
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: 25.w,
                child: Icon(
                  Icons.arrow_back,
                  color: putihop85,
                  size: FontSizes.xsmall,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            width: 1.sw,
            height: 1.65.sh,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10.h),
            child: Column(
              children: [
                Pin.show(
                  onComplete: (a) {
                    OrderMassage.reqTradinglimit(
                      pin: a,
                      stockCode: widget.title,
                    );
                    pin = a;
                    Get.find<PinSave>().stockCode.value = widget.title;
                    Get.find<PinSave>().pin.value = a;
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
                  title: widget.title,
                  boardWidget: PopupMenuButton(
                    constraints: const BoxConstraints(),
                    color: foregroundwidget,
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: BoardOption.RG,
                        child: Center(
                          child: Text(
                            'RG',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: BoardOption.TN,
                        child: Center(
                          child: Text(
                            'TN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case BoardOption.RG:
                          Get.find<ControllerBoard>().updateBoard('RG');
                        case BoardOption.NG:
                          Get.find<ControllerBoard>().updateBoard('NG');
                        case BoardOption.TN:
                          Get.find<ControllerBoard>().updateBoard('TN');
                      }
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
                Obx(() {
                  return Container(
                    width: 1.sw,
                    height: 0.40.sh,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(7.r),
                      border: Border.all(
                        width: 0.5.w,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    margin:
                        EdgeInsets.only(bottom: 5.h, left: 19.h, right: 19.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: TabBar(
                            controller: tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            physics: const NeverScrollableScrollPhysics(),
                            indicatorColor: indexTabBreak.value == 0
                                ? Colors.red
                                : indexTabBreak.value == 1
                                    ? Colors.green
                                    : putihop85,
                            onTap: (i) {
                              Get.find<BreakOrderContoller>().clearData();
                              Future.delayed(
                                Duration.zero,
                                () {
                                  setState(
                                    () {
                                      Get.put(BreakOrderContoller())
                                          .priceContollerBreak
                                          .text = formattaCurrun(
                                        ObjectBoxDatabase.quotesBox
                                            .query(Quotes_.stockCode
                                                    .equals(widget.title) &
                                                Quotes_.board.equals(
                                                    Get.put(ControllerBoard())
                                                        .boards
                                                        .value))
                                            .build()
                                            .findFirst()!
                                            .lastPrice!,
                                      );
                                    },
                                  );
                                },
                              );
                              indexTabBreak.value = i;
                              indexTabBreak.refresh();
                            },
                            tabs: [
                              Tab(
                                child: Text(
                                  'BUY',
                                  style: TextStyle(
                                    fontSize: FontSizes.size13,
                                    color: indexTabBreak.value == 0
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
                                    color: indexTabBreak.value == 1
                                        ? Colors.green
                                        : putihop85,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    fontSize: FontSizes.size13,
                                    color: putihop85,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              BuyBreakOrder(title: widget.title, pin: pin),
                              SellBreakWidget(title: widget.title, pin: pin),
                              CancleBreakWidget(title: widget.title, pin: pin),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 5.h),
                Expanded(
                  child: SreamOBView(
                    stockCsearch: widget.title,
                    onTapBid: (val) {
                      // controller.priceContollerGTC.text = val;
                    },
                    onTapOffer: (val) {
                      // controller.priceContollerGTC.text = val;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
