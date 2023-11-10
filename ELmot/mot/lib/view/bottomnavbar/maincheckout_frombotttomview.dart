import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/bottomnavbar/menu/checkout_widget_frombottom/new_OrderBuy.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/checkout_widget_frombottom/new_OrderSell.widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/Orderbook.main.mobile.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/view/widget/search_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

RxString selectedCode = ''.obs;

// ignore: must_be_immutable
class MainCheckOutFromBottomView extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? board;
  String? typeCheckout;
  int prevP;
  MainCheckOutFromBottomView(
      {super.key,
      required this.title,
      required this.subtitle,
      this.board,
      required this.typeCheckout,
      required this.prevP});

  @override
  State<MainCheckOutFromBottomView> createState() =>
      _MainCheckOutFromBottomViewState();
}

RxInt indexTabNewOrder = 0.obs;

class _MainCheckOutFromBottomViewState extends State<MainCheckOutFromBottomView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var controllerPin = PinSave();
  TextEditingController controller = TextEditingController();
  var getBodyController = BodyController();
  var query = Get.put(DetailSahamController());
  final Lock lock = Lock();

  var rebuilpinController = RebuildPin();
  void datas({String? stockcodeSearch}) async {
    await lock.synchronized(() {
      ActivityRequest.quoteRequest(
        packageId: Constans.PACKAGE_ID_QUOTES,
        commant: 1,
        arrayStockCode: [
          ArrayStockCode(
            stockCode: stockcodeSearch ?? widget.title,
            board: Get.find<ControllerBoard>().boards.value,
          )
        ],
      );
      ActivityRequest.orderBookRequest(
        packageId: Constans.PACKAGE_ID_ORDER_BOOK,
        stockCode: stockcodeSearch ?? widget.title,
        board: Get.find<ControllerBoard>().boards.value,
        commant: "1",
      );
      query.getpreviousPrice(
          stockcode: stockcodeSearch ?? widget.title,
          board: Get.find<ControllerBoard>().boards.value);

      ActivityRequest.parameterRequest(requestFlag: 1);
    });
    if (controllerPin.pin.value != '') {
      controllerPin.request();
    }

    setNewEstimation(
        price: query.previousPrice.toString(),
        qty: Get.find<BodyController>().qtyController.text);
  }

  void setNewEstimation({required String price, required String qty}) {
    Get.find<BodyController>().priceController.text = price;
    Get.find<BodyController>().stockEstimasiData.value =
        Get.find<BodyController>().stockEstimasi(price: price, qty: qty);
    Get.find<BodyController>().fee(false, price: price, qty: qty);
    Get.find<BodyController>().nett(false, price: price, qty: qty);
  }

  void setPriceControllerasPrev() {
    getBodyController.priceController.text = formattaCurrun(
      query.lastPrice.value == 0
          ? query.previousPrice.value
          : query.lastPrice.value,
    );
  }

  @override
  void initState() {
    super.initState();
    datas();
    if (!Get.isRegistered<BodyController>()) {
      getBodyController = Get.put(BodyController());
    } else {
      getBodyController = Get.find<BodyController>();
    }
    if (!Get.isRegistered<PinSave>()) {
      controllerPin = Get.put(PinSave());
    } else {
      controllerPin = Get.find<PinSave>();
    }
    if (!Get.isRegistered<BuildingMassageOrder>()) {
      Get.put(BuildingMassageOrder());
    } else {
      Get.find<BuildingMassageOrder>();
    }
    if (!Get.isRegistered<RebuildPin>()) {
      rebuilpinController = Get.put(RebuildPin());
    } else {
      rebuilpinController = Get.find<RebuildPin>();
    }

    selectedCode.value = widget.title.toString();
    rebuilpinController.stockCode.value = widget.title;
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: indexTabNewOrder.value,
    );

    Future.delayed(
      Duration.zero,
      () {
        setPriceControllerasPrev();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      selectedCode.value;
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: false,
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
                      hint: selectedCode.value,
                      controller: controller,
                      onPressedX: () {
                        if (controller.length == 0 || controller.text == '') {
                          isSearchq.toggle();
                          isSearchq.refresh();
                          controller.clear();
                        } else {
                          controller.clear();
                          FocusScope.of(context).requestFocus();
                        }
                      },
                      onFinnis: (a) {
                        setState(() {
                          selectedCode.value = a;
                          rebuilpinController.stockCode.value = a;
                          rebuilpinController.stockCode.refresh();
                          selectedCode.refresh();
                          rebuilpinController.stockCode.refresh();
                          datas(stockcodeSearch: selectedCode.value);
                        });
                      },
                    ),
            ),
            body: SingleChildScrollView(
              child: StreamBuilder(
                stream: ObjectBoxDatabase.qoutesRealtimeWithQuery(
                    selectedCode.value,
                    Get.find<ControllerBoard>().boards.value),
                builder: (context, snapshot) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Pin.show(
                          onComplete: (text) {
                            fokusNode.unfocus();
                            controllerPin.pin.value = text;
                            controllerPin.request();
                            rebuilpinController.pin.value = text;
                            rebuilpinController.pin.refresh();
                          },
                          onSelect: () {
                            Future.delayed(
                              const Duration(milliseconds: 50),
                              () {
                                controllerPin.request();
                              },
                            );
                          },
                        ),
                        DetailCheckOut(
                          typeCheckout: widget.typeCheckout!,
                          title: selectedCode.value,
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
                                        color: Colors.white, fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: BoardOption.TN,
                                child: Center(
                                  child: Text(
                                    'TN',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
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
                              datas(stockcodeSearch: selectedCode.value);
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
                        Pin.showLimit(stockCode: selectedCode.value),
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
                                      indicatorSize: TabBarIndicatorSize.tab,
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
                                        Get.find<BodyController>().onClear();

                                        Future.delayed(
                                          Duration.zero,
                                          () {
                                            getBodyController.priceController
                                                .text = snapshot.data == null ||
                                                    snapshot.data!.isEmpty
                                                ? '0'
                                                : formattaCurrun(
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
                                              color: indexTabNewOrder.value == 0
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
                                              color: indexTabNewOrder.value == 1
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
                                          title: selectedCode.value,
                                        ),
                                        NewOrderSellWidget(
                                          title: selectedCode.value,
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
                                stockCsearch: selectedCode.value,
                                board: Get.find<ControllerBoard>().boards.value,
                                onTapBid: (val) {
                                  getBodyController.priceController.text = val;
                                  setNewEstimation(
                                      price: val,
                                      qty: Get.find<BodyController>()
                                          .qtyController
                                          .text);
                                },
                                onTapOffer: (val) {
                                  getBodyController.priceController.text = val;
                                  setNewEstimation(
                                      price: val,
                                      qty: Get.find<BodyController>()
                                          .qtyController
                                          .text);
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
          ));
    });
  }
}

class RebuildPin extends GetxController {
  RxString pin = ''.obs;
  RxBool isrun = false.obs;
  RxString stockCode = ''.obs;
  void restoreDate() async {
    var a = await SharedPreferences.getInstance();
    if (a.getBool('isRun') == true) {
      Get.find<PinSave>().pin.value = pin.value;
      Get.find<PinSave>().pin.refresh();
      Get.put(BodyController());
      OrderMassage.reqTradinglimit(
        pin: pin.value,
        stockCode: stockCode.value,
      );
      isrun.value = false;
      isrun.refresh();
      removeShared();
    }
  }

  addShared() async {
    var a = await SharedPreferences.getInstance();
    a.setBool('isRun', true);
  }

  removeShared() async {
    var a = await SharedPreferences.getInstance();
    a.setBool('isRun', false);
  }
}

class CheckSahamDelisting extends GetxController {
  bool check({required String stockcode}) {
    final object = ObjectBoxDatabase.stockList;
    final query = object.getAll();
    bool a = false;
    if (query.isEmpty) {
      return a;
    } else {
      for (int i = 0; i < query.length; i++) {
        if (query[i].stcokCode == stockcode) {
          a = true;
        }
      }
      return a;
    }
  }
}
