import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/requestGTCList.pkg.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/controller/newGTC.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/widget/cancelGTC.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/widget/newGTCBuy.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/widget/newGTCSell.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/Orderbook.main.mobile.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/search_widget.dart';

RxInt indexTab = 0.obs;

class NewGTCMain extends StatefulWidget {
  final String title;
  const NewGTCMain({super.key, this.title = 'ANTM'});

  @override
  State<NewGTCMain> createState() => _NewGTCMainState();
}

class _NewGTCMainState extends State<NewGTCMain>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var controller = Get.put(NewGTCController());
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: indexTab.value,
    );

    ActivityRequest.parameterRequest(requestFlag: 1);
    Future.delayed(
      Duration.zero,
      () {
        controller.priceContollerGTC.text = ObjectBoxDatabase.quotesBox
                    .query(Quotes_.stockCode.equals(widget.title))
                    .build()
                    .findFirst()!
                    .prevPrice ==
                0
            ? formattaCurrun(
                ObjectBoxDatabase.quotesBox
                    .query(Quotes_.stockCode.equals(widget.title))
                    .build()
                    .findFirst()!
                    .lastPrice!,
              )
            : formattaCurrun(
                ObjectBoxDatabase.quotesBox
                    .query(Quotes_.stockCode.equals(widget.title))
                    .build()
                    .findFirst()!
                    .prevPrice!,
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerBoard());
    return WillPopScope(
      onWillPop: () async {
        var controller = Get.put(NewGTCController());
        controller.priceContollerGTC.text = '';
        controller.qtyContollerGTC.text = '';
        indexTab.value = 0;
        listGTC.clear();
        Get.find<PinSave>().onPop();
        Get.back();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 40.h),
            child: AppBar(
              backgroundColor: Colors.black,
              leading: GestureDetector(
                onTap: () {
                  var controller = Get.put(NewGTCController());
                  controller.priceContollerGTC.text = '';
                  controller.qtyContollerGTC.text = '';
                  indexTab.value = 0;
                  listGTC.clear();
                  Get.find<PinSave>().onPop();
                  Get.back();
                },
                child: SizedBox(
                  child: Icon(
                    Icons.arrow_back,
                    size: IconSizes.backArrowSize,
                    color: putihop85,
                  ),
                ),
              ),
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
                            '/newGTC',
                            arguments: <String, String>{
                              'title': a,
                            },
                          );
                        },
                      )
                    : Text(
                        'NEW GTC ORDER',
                        style: TextStyle(
                          color: putihop85,
                          fontSize: FontSizes.size16,
                        ),
                      );
              }),
              centerTitle: true,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: 1.sw,
              height: 1.3.sh,
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
                  SizedBox(
                    height: 5.h,
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
                  Container(
                    width: 1.sw,
                    height: 240.h,
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
                          child: Obx(() {
                            return TabBar(
                              controller: tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: Colors.transparent,
                              physics: const NeverScrollableScrollPhysics(),
                              indicatorColor: indexTab.value == 0
                                  ? Colors.red
                                  : indexTab.value == 1
                                      ? Colors.green
                                      : putihop85,
                              onTap: (i) {
                                indexTab.value = i;
                                indexTab.refresh();
                                var controll = Get.put(NewGTCController());
                                controll.dueDateContollerGTC.text =
                                    DateFormat('yyyy/MM/dd').format(
                                  DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day +
                                        DateUtils.getDaysInMonth(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                        ),
                                  ),
                                );
                                controll.effectiveDateContollerGTC.text =
                                    DateFormat('yyyy/MM/dd').format(
                                  DateTime.now(),
                                );
                                controll.priceContollerGTC.text = '';
                                controll.qtyContollerGTC.text = '';
                                if (controll.autoGTC.value == true) {
                                  controll.autoGTC.toggle();
                                }
                                controll.priceStapControllerGTC.text = '';
                                isFirst = false;
                              },
                              tabs: [
                                Tab(
                                  child: Text(
                                    'BUY',
                                    style: TextStyle(
                                      fontSize: FontSizes.size13,
                                      color: indexTab.value == 0
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
                                      color: indexTab.value == 1
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
                            );
                          }),
                        ),
                        Expanded(
                            child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: [
                            NewGTCBUY(
                              title: widget.title,
                            ),
                            NewGTCSellWidget(
                              title: widget.title,
                            ),
                            CancelGTCWidget(
                              title: widget.title,
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
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
                  Expanded(
                    child: SreamOBView(
                      stockCsearch: widget.title,
                      onTapBid: (val) {
                        controller.priceContollerGTC.text = val;
                      },
                      onTapOffer: (val) {
                        controller.priceContollerGTC.text = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
