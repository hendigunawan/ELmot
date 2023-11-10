// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/GetxController/favoritecontrollerlocal.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/dailychartdata_model.dart';
import 'package:online_trading/module/model/favoritelocal_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/analisiswidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/dailyDatawidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/infowidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/messagewidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/newswidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/quoteswidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/runningtrade_widget.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/tradebook/tradebook.main.mobile.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/tabbar_view/tradingView/controller/runningtrade.controller.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/search_widget.dart';
import 'package:synchronized/synchronized.dart';
import 'tradewidget/orderbook/Orderbook.main.mobile.dart';
import 'tradewidget/action_button.dart';
import 'tradewidget/expandable_fab.dart';

class TradeViewMain extends StatelessWidget {
  final VoidCallback? onTap;
  String title;
  final String board;
  final String subTitle;

  TradeViewMain({
    required this.title,
    this.onTap,
    super.key,
    required this.subTitle,
    this.board = 'RG',
  });
  RxInt selectedIndex = 0.obs;
  void onTapSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    var detailController = Get.put(DetailSahamController());
    TextEditingController controller = TextEditingController();
    RxBool isSearch = false.obs;
    detailController.requestDataDetail(
        title, Get.put(ControllerBoard()).boards.value);
    RxList<FavoriteLoacalB> options = <FavoriteLoacalB>[].obs;
    RxList<bool> selectedOptions = <bool>[].obs;
    RxList<bool> data = <bool>[].obs;
    final controllers = Get.put(FavoriteControllerLocal());
    void updateData() {
      for (int i = 0; i < options.length; i++) {
        var getMembers = controllers.body
            .query(FavoriteLoacalB_.id.equals(options[i].id))
            .build()
            .findFirst();
        if (getMembers != null) {
          if (getMembers.member.isEmpty || getMembers.member.isEmpty) {
            data.add(false);
          }
          for (int x = 0; x < getMembers.member.length; x++) {
            if (getMembers.member[x].stockCode == title) {
              data.add(true);
            } else {
              data.add(false);
            }
          }
        }
      }
      if (data.length < options.length) {
        data.add(false);
      }
      if (data.length < options.length && data.isEmpty) {
        data.add(false);
      }

      if (data.isNotEmpty) {
        selectedOptions = data;
      }
    }

    void initializeGroup() async {
      options = controllers.body.getAll().obs;
      if (options.isNotEmpty) {
        selectedOptions = List.generate(options.length, (index) => false).obs;
      }
      updateData();
    }

    initializeGroup();
    void addnewEmptygroup() async {
      controllers.onAddBody(groupname_controller.text, false);
      options = controllers.body.getAll().obs;
      if (options.isNotEmpty) {
        selectedOptions = List.generate(options.length, (index) => false).obs;
      }
      updateData();
      groupname_controller.clear();
    }

    void showDialogAddToFav() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Add $title to favorit",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: putihop85,
                ),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.only(top: 20.h),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.r)),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    height: 30.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r))),
                      onPressed: () async {
                        for (int i = 0; i < options.length; i++) {
                          var queryB = controllers.body
                              .query(FavoriteLoacalB_.groupTag
                                  .equals(options[i].groupTag.toString()))
                              .build()
                              .findFirst();

                          if (queryB != null) {
                            if (selectedOptions[i]) {
                              bool stockCodeFound = false;
                              for (int x = 0; x < queryB.member.length; x++) {
                                if (queryB.member[x].stockCode != title) {
                                  stockCodeFound = true;
                                } else {
                                  stockCodeFound = false;
                                  break;
                                }
                              }
                              if (queryB.member.isEmpty) {
                                controllers.onAddMember(queryB, title, false);
                              }

                              if (stockCodeFound) {
                                controllers.onAddMember(queryB, title, false);
                              }
                            }
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size12),
                      ),
                    ),
                  ),
                ],
              )
            ],
            backgroundColor: bgabu,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.only(left: 13.w, right: 13.w),
                  height: 0.3.sh,
                  width: 0.6.sw,
                  decoration: BoxDecoration(
                    color: bgabu,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.isEmpty ? 0 : options.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return CheckboxListTile(
                                activeColor: Colors.blue,
                                checkColor: Colors.black,
                                dense: true,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                selected: selectedOptions[index],
                                title: Text(
                                  controllers.body
                                      .getAll()[index]
                                      .groupTag
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: FontSizes.size13,
                                      color: putihop85),
                                ),
                                value: selectedOptions[index],
                                onChanged: (bool? value) {
                                  selectedOptions[index] =
                                      !selectedOptions[index];
                                  selectedOptions.refresh();
                                },
                              );
                            });
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Get.find<ControllerBoard>().updateBoard('RG');

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 45.h),
          child: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: IconSizes.backArrowSize,
              ),
              onTap: () {
                Get.find<ControllerBoard>().updateBoard('RG');
                Navigator.of(context).pop();
              },
            ),
            title: Obx(
              () {
                return !isSearch.value
                    ? GestureDetector(
                        child: Column(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size16,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          isSearch.value = true;
                        },
                      )
                    : SearchWidget(
                        autofocuskeyboard: true,
                        hint: title,
                        controller: controller,
                        onPressedX: () {
                          controller.clear();
                          isSearch.value = false;
                        },
                        onFinnis: (a) {
                          Navigator.of(context).pushReplacementNamed(
                            '/goDetailview',
                            arguments: <String, String>{
                              'title': a,
                              'subtitle': '',
                              'board': Get.find<ControllerBoard>().boards.value,
                            },
                          );
                        },
                      );
              },
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PopupMenuButton(
                      constraints: BoxConstraints.tightFor(
                        height: 130.h,
                        width: 75.w,
                      ),
                      color: foregroundwidget,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          height: 35.h,
                          value: BoardOption.RG,
                          child: Center(
                              child: Text(
                            'RG',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          )),
                        ),
                        PopupMenuItem(
                          height: 35.h,
                          value: BoardOption.TN,
                          child: Center(
                              child: Text(
                            'TN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          )),
                        ),
                        PopupMenuItem(
                          height: 35.h,
                          value: BoardOption.NG,
                          child: Center(
                              child: Text(
                            'NG',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          )),
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

                        detailController.requestDataDetail(
                            title, Get.find<ControllerBoard>().boards.value);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            border: Border.all(
                              width: 1.w,
                              color: Colors.green,
                            )),
                        child: GetBuilder<ControllerBoard>(
                          init: ControllerBoard(),
                          builder: (controllerBoard) => Text(
                            controllerBoard.boards.value,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (options.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: bgabu,
                            title: Text(
                              "Group is empty",
                              style: TextStyle(
                                  color: putihop85, fontSize: FontSizes.size14),
                            ),
                            content: TextField(
                              autofocus: true,
                              controller: groupname_controller,
                              style: TextStyle(
                                  color: putihop85, fontSize: FontSizes.size14),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: FontSizes.size14,
                                ),
                                hintText: "Input new group name",
                              ),
                            ),
                            actions: <Widget>[
                              SizedBox(
                                width: 90.w,
                                height: 35.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: putihop85,
                                        fontSize: FontSizes.size12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 90.w,
                                height: 35.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  onPressed: () {
                                    if (groupname_controller.text.length < 2) {
                                      NotifikasiPopup.show(
                                          "Group name length must more than 3 character");
                                    } else {
                                      addnewEmptygroup();
                                      Navigator.pop(context);
                                      showDialogAddToFav();
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: putihop85,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  } else {
                    showDialogAddToFav();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 4.w),
                  child: Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                    size: 17.sp,
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return QuotesView(
                quotesName: title,
                subTitle: subTitle,
                board: Get.find<ControllerBoard>().boards.value,
              );
            }),
            Container(
              margin:
                  EdgeInsets.only(top: 3.h, left: 7.w, right: 7.w, bottom: 1.h),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                child: SizedBox(
                  width: 2.6.sw,
                  height: 25.h,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _customButton("OrderBook", 0),
                        _customButton("TradeBook", 1),
                        _customButton("Chart", 2),
                        _customButton("Running Trade", 3),
                        _customButton("Daily Price", 4),
                        _customButton("Brokers Price", 5),
                        _customButton("Foreign Price", 6),
                        _customButton("Messages", 7),
                        _customButton("News", 8),
                        _customButton("Info", 9),
                        _customButton("Analyst", 10),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Obx(() {
              if (selectedIndex.value == 3) {
                var getRunning = Get.put(RunningTradeController());
                getRunning;
              }
              return selectedIndex.value == 0
                  ? Expanded(
                      child: SreamOBView(
                        prevP: detailController.previousPrice.value,
                        stockCsearch: title,
                        board: Get.find<ControllerBoard>().boards.value,
                      ),
                    )
                  : selectedIndex.value == 1
                      ? Expanded(
                          child: TradeBookWidget(
                            prevP: detailController.previousPrice.value,
                            stockCsearch: title,
                            board: Get.find<ControllerBoard>().boards.value,
                          ),
                        )
                      : selectedIndex.value == 2
                          ? Expanded(
                              child: StreamBuilder(
                                  stream: CandleList.getDaily(
                                    title,
                                    Get.find<ControllerBoard>().boards.value,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ChartComponent(
                                        type: ChartType.daily,
                                        stockCode: title.toString(),
                                        board: Get.find<ControllerBoard>()
                                            .boards
                                            .value,
                                        data: CandleList.generateList(
                                          snapshot.data == null ||
                                                  snapshot.data!.isEmpty
                                              ? []
                                              : snapshot.data!.first
                                                  .arrayDailyChartList,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          snapshot.error.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp),
                                        ),
                                      );
                                    } else {
                                      return ChartComponent(
                                        type: ChartType.daily,
                                        stockCode: title.toString(),
                                        board: Get.find<ControllerBoard>()
                                            .boards
                                            .value,
                                        data: CandleList.generateList(
                                          snapshot.data == null ||
                                                  snapshot.data!.isEmpty
                                              ? []
                                              : snapshot.data!.first
                                                  .arrayDailyChartList,
                                        ),
                                      );
                                    }
                                  }),
                            )
                          : selectedIndex.value == 3
                              ? Expanded(
                                  child: RunningTradeWidget(
                                    stockCsearch: title,
                                  ),
                                )
                              : selectedIndex.value == 4
                                  ? Expanded(
                                      child: StreamBuilder(
                                        stream: getDailySortbyDate(
                                          title,
                                          Get.find<ControllerBoard>()
                                              .boards
                                              .value,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return DailyDataWidget(
                                              title: title,
                                              data: snapshot.data == null ||
                                                      snapshot.data!.isEmpty
                                                  ? []
                                                  : snapshot.data,
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                snapshot.error.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),
                                              ),
                                            );
                                          } else {
                                            return DailyDataWidget(
                                              title: title,
                                              data: snapshot.data == null ||
                                                      snapshot.data!.isEmpty
                                                  ? []
                                                  : snapshot.data,
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  : selectedIndex.value == 5
                                      ? Container(
                                          // broker price
                                          )
                                      : selectedIndex.value == 6
                                          ? Container(
                                              // broker price
                                              )
                                          : selectedIndex.value == 7
                                              ? const Expanded(
                                                  child: MessageWidget())
                                              : selectedIndex.value == 8
                                                  ? const Expanded(
                                                      child: NewsWidget())
                                                  : selectedIndex.value == 9
                                                      ? Expanded(
                                                          child: InfoWidget(
                                                            stockC: title,
                                                            stockN: subTitle,
                                                          ),
                                                        )
                                                      : selectedIndex.value ==
                                                              10
                                                          // analisis
                                                          ? const Expanded(
                                                              child:
                                                                  AnalisisWidget())
                                                          : Container();
            })
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ExpandableFab(
          distance: 60.r,
          children: [
            ActionButton(
              color: Colors.red,
              title: "BUY",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/goCheckoutview',
                  arguments: <String, String>{
                    'prevP': 1.toString(),
                    'title': title,
                    'subtitle': subTitle,
                    'board': Get.find<ControllerBoard>().boards.value,
                    'typeCheckout': "BUY",
                  },
                );
              },
            ),
            ActionButton(
              color: Colors.green,
              title: "SELL",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/goCheckoutview',
                  arguments: <String, String>{
                    'prevP': 1.toString(),
                    'title': title,
                    'subtitle': subTitle,
                    'board': Get.find<ControllerBoard>().boards.value,
                    'typeCheckout': "SELL",
                  },
                );
              },
            ),
            // ActionButton(
            //   color: ConstantStyle.oren,
            //   title: "AMEND",
            //   onPressed: () {
            //     Navigator.pushNamed(
            //       context,
            //       '/goCheckoutview',
            //       arguments: <String, String>{
            //         'prevP': 1.toString(),
            //         'title': title,
            //         'subtitle': subTitle,
            //         'board': Get.find<ControllerBoard>().boards.value,
            //         'typeCheckout': "AMEND",
            //       },
            //     );
            //   },
            // ),
            // ActionButton(
            //   color: Colors.blue,
            //   title: "WD",
            //   onPressed: () {
            //     Navigator.pushNamed(
            //       context,
            //       '/goCheckoutview',
            //       arguments: <String, String>{
            //         'prevP': 1.toString(),
            //         'title': title,
            //         'subtitle': subTitle,
            //         'board': Get.find<ControllerBoard>().boards.value,
            //         'typeCheckout': "WD",
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(String title, int index) {
    return GestureDetector(
      onTap: () =>
          selectedIndex.value != index ? onTapSelectedIndex(index) : null,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: selectedIndex.value == index
                  ? ConstantStyle.oren
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailSahamController extends GetxController {
  RxInt previousPrice = 0.obs;
  RxInt lastPrice = 0.obs;
  StreamSubscription? data;
  RxBool iyanichbro = false.obs;
  void requestDataDetail(String stockcode, String board,
      {bool? iyadong}) async {
    if (iyadong != null) {
      iyanichbro.value = iyadong;
    }
    final lock = Lock();
    await lock.synchronized(() {
      ActivityRequest.quoteRequest(
        packageId: Constans.PACKAGE_ID_QUOTES,
        commant: 1,
        arrayStockCode: [
          ArrayStockCode(
            stockCode: stockcode,
            board: board,
          )
        ],
      );
      ActivityRequest.orderBookRequest(
        packageId: Constans.PACKAGE_ID_ORDER_BOOK,
        stockCode: stockcode,
        board: board,
        commant: "1",
      );

      ActivityRequest.subscribeRunningTradesRequest(
        packageId: Constans.PACKAGE_ID_RUNNING_TRADES,
        arrayStockCode: [
          ArrayStockCode(
            stockCode: stockcode,
            board: board,
          ),
        ],
        commant: '1',
      );
      ActivityRequest.subscribeTradeBookRequest(
        packageId: Constans.PACKAGE_ID_TRADE_BOOK,
        command: '1',
        stockCode: stockcode,
        board: board,
      );
      ActivityRequest.dailyChartDataRequest(
        packageId: Constans.PACKAGE_ID_DAILY_CHART_DATA,
        stockCode: stockcode,
        board: board,
        command: "0",
      );
      getpreviousPrice(stockcode: stockcode, board: board);
    });
  }

  void getpreviousPrice({required String stockcode, required String board}) {
    final stream = ObjectBoxDatabase.qoutesRealtimeWithQuery(stockcode, board);
    data = stream.listen((event) {
      if (event.isEmpty) {
        previousPrice.value = 0;
        lastPrice.value = 0;
      } else {
        if (event.first.prevPrice != 0) {
          previousPrice.value = event.first.prevPrice!;
          lastPrice.value = event.first.lastPrice!;
          if (iyanichbro.value == true) {
            setPriceControllerasPrev();
            iyanichbro.value = false;
          }
          data!.pause();
        }
      }
    });
  }

  void removeStream() {
    data!.pause();
  }

  void setPriceControllerasPrev() {
    var getBodyController = BodyController();
    if (!Get.isRegistered<BodyController>()) {
      getBodyController = Get.put(BodyController());
    } else {
      getBodyController = Get.find<BodyController>();
    }

    getBodyController.priceController.text = formattaCurrun(
      lastPrice.value == 0 ? previousPrice.value : lastPrice.value,
    );
  }

  void updateNewDate({String? stockCodeChange, String? boardd}) {
    requestDataDetail(stockCodeChange!, boardd!);
  }
}

// class TradeViewMain2 extends StatefulWidget {
//   final VoidCallback? onTap;
//   final String title;
//   final String board;
//   final String subTitle;

//   const TradeViewMain2({
//     required this.title,
//     this.onTap,
//     super.key,
//     required this.subTitle,
//     this.board = 'RG',
//   });

//   @override
//   State<TradeViewMain2> createState() => _TradeViewMain2State();
// }

// class _TradeViewMain2State extends State<TradeViewMain2> {
//   bool _isFirstBuild = true;
//   bool _isSearch = false;
//   TextEditingController controller = TextEditingController();
//   int _selectedIndex = 0;
//   final getObjectBox = ObjectBoxDatabase.indexMembers;
//   final getObjectBoxOrderBook = ObjectBoxDatabase.orderBookBox;
//   int? prevprice;
//   bool isLove = false;
//   RxList<FavoriteLoacalB> options = <FavoriteLoacalB>[].obs;
//   RxList<bool> selectedOptions = <bool>[].obs;
//   RxList<bool> data = <bool>[].obs;
//   ConnectionsController getConnect = Get.find();
//   final Lock lock = Lock();
//   final controllers = Get.put(FavoriteControllerLocal());
//   final buildRG = Get.put(ControllerBoard());
//   RxString val = 'Daily'.obs;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     if (_isFirstBuild && widget.onTap != null) {
//       _isFirstBuild = false;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         widget.onTap!();
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     Get.put(FavoriteControllerLocal());
//     buildRG.stockCodes.value = widget.title;
//     datas();
//     initializeGroup();
//   }

//   void initializeGroup() async {
//     await lock.synchronized(() {
//       options = controllers.body.getAll().obs;
//       if (options.isNotEmpty) {
//         selectedOptions = List.generate(options.length, (index) => false).obs;
//       }
//       updateData();
//     });
//   }

//   void datas() async {
//     await lock.synchronized(() {
//       ActivityRequest.quoteRequest(
//         packageId: Constans.PACKAGE_ID_QUOTES,
//         commant: 1,
//         arrayStockCode: [
//           ArrayStockCode(
//             stockCode: widget.title,
//             board: Get.find<ControllerBoard>().boards.value,
//           )
//         ],
//       );
//       ActivityRequest.orderBookRequest(
//         packageId: Constans.PACKAGE_ID_ORDER_BOOK,
//         stockCode: widget.title,
//         board: Get.find<ControllerBoard>().boards.value,
//         commant: "1",
//       );

//       ActivityRequest.subscribeRunningTradesRequest(
//         packageId: Constans.PACKAGE_ID_RUNNING_TRADES,
//         arrayStockCode: [
//           ArrayStockCode(
//             stockCode: widget.title,
//             board: Get.find<ControllerBoard>().boards.value,
//           ),
//         ],
//         commant: '1',
//       );
//       ActivityRequest.subscribeTradeBookRequest(
//         packageId: Constans.PACKAGE_ID_TRADE_BOOK,
//         command: '1',
//         stockCode: widget.title,
//         board: Get.find<ControllerBoard>().boards.value,
//       );
//       ActivityRequest.dailyChartDataRequest(
//         packageId: Constans.PACKAGE_ID_DAILY_CHART_DATA,
//         stockCode: widget.title,
//         board: Get.find<ControllerBoard>().boards.value,
//         command: "0",
//       );
//       final stream = ObjectBoxDatabase.qoutesRealtimeWithQuery(
//           widget.title, Get.find<ControllerBoard>().boards.value);
//       final saa = stream.listen((event) {
//         if (event.isEmpty) {
//           prevprice = 0;
//         } else {
//           setState(() {
//             prevprice = event.first.prevPrice!.toInt();
//           });
//         }
//       });
//       Future.delayed(const Duration(microseconds: 1), () {
//         saa.pause();
//       });
//     });
//   }

//   void updateData() {
//     for (int i = 0; i < options.length; i++) {
//       var getMembers = controllers.body
//           .query(FavoriteLoacalB_.id.equals(options[i].id))
//           .build()
//           .findFirst();
//       if (getMembers != null) {
//         if (getMembers.member.isEmpty || getMembers.member.isEmpty) {
//           data.add(false);
//         }
//         for (int x = 0; x < getMembers.member.length; x++) {
//           if (getMembers.member[x].stockCode == widget.title) {
//             data.add(true);
//           } else {
//             data.add(false);
//           }
//         }
//       }
//     }
//     if (data.length < options.length) {
//       data.add(false);
//     }
//     if (data.length < options.length && data.isEmpty) {
//       data.add(false);
//     }

//     if (data.isNotEmpty) {
//       selectedOptions = data;
//     }
//   }

//   void _onTabSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void addnewEmptygroup() async {
//     await lock.synchronized(() {
//       controllers.onAddBody(groupname_controller.text, false);
//       options = controllers.body.getAll().obs;
//       if (options.isNotEmpty) {
//         selectedOptions = List.generate(options.length, (index) => false).obs;
//       }
//       updateData();
//       groupname_controller.clear();
//       Navigator.pop(context);
//       setState(() {
//         isLove = !isLove;
//       });
//     });
//   }

//   void reqChartbasedonType(String type) {
//     if (type == "Daily") {
//       ActivityRequest.dailyChartDataRequest(
//         packageId: Constans.PACKAGE_ID_DAILY_CHART_DATA,
//         stockCode: widget.title,
//         board: Get.find<ControllerBoard>().boards.value,
//         command: "0",
//       );
//     } else if (type == "Weekly") {
//       ActivityRequest.weeklyChartDataRequest(
//         packageId: Constans.PACKAGE_ID_WEEKLY_CHART_DATA,
//         stockCode: widget.title,
//         board: Get.find<ControllerBoard>().boards.value,
//         command: "0",
//       );
//     } else if (type == "Monthly") {
//       ActivityRequest.monthlyChartDataRequest(
//         packageId: Constans.PACKAGE_ID_MONTHLY_CHART_DATA,
//         stockCode: widget.title,
//         board: Get.find<ControllerBoard>().boards.value,
//         command: "0",
//       );
//     } else if (type == "Intraday") {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return WillPopScope(
//         onWillPop: () async {
//           Get.find<ControllerBoard>().updateBoard('RG');
//           Get.find<ControllerHandelSUB>().unBind();
//           Navigator.pushReplacementNamed(context, "/backtoHome");
//           return true;
//         },
//         child: Stack(
//           children: [
//             Scaffold(
//               backgroundColor: ConstantStyle.backgroundhitam,
//               appBar: PreferredSize(
//                 preferredSize: Size(double.infinity, 45.h),
//                 child: AppBar(
//                   elevation: 0,
//                   centerTitle: true,
//                   backgroundColor: Colors.black,
//                   foregroundColor: Colors.white,
//                   leading: GestureDetector(
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 20.sp,
//                     ),
//                     onTap: () {
//                       Get.find<ControllerBoard>().updateBoard('RG');
//                       Get.find<ControllerHandelSUB>().unBind();
//                       Navigator.pushReplacementNamed(context, "/backtoHome");
//                     },
//                   ),
//                   title: !_isSearch
//                       ? GestureDetector(
//                           child: Column(
//                             children: [
//                               Text(
//                                 widget.title,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: FontSizes.size16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             setState(() {
//                               _isSearch = true;
//                             });
//                           },
//                         )
//                       : SearchWidget(
//                           autofocuskeyboard: true,
//                           hint: widget.title,
//                           controller: controller,
//                           onPressedX: () {
//                             controller.clear();
//                             setState(() {
//                               _isSearch = false;
//                             });
//                           },
//                           onFinnis: (a) {
//                             Navigator.of(context).pushReplacementNamed(
//                               '/goDetailview',
//                               arguments: <String, String>{
//                                 'title': a,
//                                 'subtitle': '',
//                                 'board':
//                                     Get.find<ControllerBoard>().boards.value,
//                               },
//                             );
//                           },
//                         ),
//                   actions: [
//                     Container(
//                       margin: EdgeInsets.only(right: 8.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           PopupMenuButton(
//                             constraints: BoxConstraints.tightFor(
//                               height: 130.h,
//                               width: 75.w,
//                             ),
//                             color: foregroundwidget,
//                             itemBuilder: (context) => [
//                               PopupMenuItem(
//                                 height: 35.h,
//                                 value: BoardOption.RG,
//                                 child: Center(
//                                     child: Text(
//                                   'RG',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13.sp,
//                                   ),
//                                 )),
//                               ),
//                               PopupMenuItem(
//                                 height: 35.h,
//                                 value: BoardOption.TN,
//                                 child: Center(
//                                     child: Text(
//                                   'TN',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13.sp,
//                                   ),
//                                 )),
//                               ),
//                               PopupMenuItem(
//                                 height: 35.h,
//                                 value: BoardOption.NG,
//                                 child: Center(
//                                     child: Text(
//                                   'NG',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13.sp,
//                                   ),
//                                 )),
//                               ),
//                             ],
//                             onSelected: (value) {
//                               switch (value) {
//                                 case BoardOption.RG:
//                                   Get.find<ControllerBoard>().updateBoard('RG');
//                                 case BoardOption.NG:
//                                   Get.find<ControllerBoard>().updateBoard('NG');
//                                 case BoardOption.TN:
//                                   Get.find<ControllerBoard>().updateBoard('TN');
//                               }
//                               setState(() {});
//                               datas();
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: 30.w,
//                               height: 18.h,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(3.r),
//                                   border: Border.all(
//                                     width: 1.w,
//                                     color: Colors.green,
//                                   )),
//                               child: GetBuilder<ControllerBoard>(
//                                 init: ControllerBoard(),
//                                 builder: (controllerBoard) => Text(
//                                   controllerBoard.boards.value,
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontSize: 12.sp,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 8.w,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               if (options.isEmpty) {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         backgroundColor: foregroundwidget,
//                                         title: Text(
//                                           "Group is empty",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: FontSizes.size14),
//                                         ),
//                                         content: TextField(
//                                           autofocus: true,
//                                           controller: groupname_controller,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: FontSizes.size14),
//                                           decoration: InputDecoration(
//                                             hintStyle: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: FontSizes.size14,
//                                             ),
//                                             hintText: "Input new group name",
//                                           ),
//                                         ),
//                                         actions: <Widget>[
//                                           SizedBox(
//                                             width: 90.w,
//                                             height: 35.h,
//                                             child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.red,
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: Text(
//                                                 "Cancel",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: FontSizes.size12),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 90.w,
//                                             height: 35.h,
//                                             child: ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                               ),
//                                               onPressed: () {
//                                                 if (groupname_controller
//                                                         .text.length <
//                                                     2) {
//                                                   NotifikasiPopup.show(
//                                                       "Group name length must more than 3 character");
//                                                 } else {
//                                                   addnewEmptygroup();
//                                                 }
//                                               },
//                                               child: Text(
//                                                 "Submit",
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: FontSizes.size12,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               } else {
//                                 setState(() {
//                                   isLove = !isLove;
//                                 });
//                               }
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(right: 5.w),
//                               child: Icon(
//                                 Icons.favorite_outline,
//                                 color: Colors.white,
//                                 size: 17.sp,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               body: Stack(
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 fit: StackFit.expand,
//                 children: [
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       QuotesView(
//                         quotesName: widget.title,
//                         subTitle: widget.subTitle,
//                         board: Get.find<ControllerBoard>().boards.value,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         physics: const ScrollPhysics(),
//                         child: Container(
//                           margin: EdgeInsets.only(
//                             top: 5.h,
//                             left: 10.w,
//                             right: 10.w,
//                             bottom: 1.h,
//                           ),
//                           width: 2.6.sw,
//                           height: 25.h,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               _customButton("OrderBook", 0),
//                               _customButton("TradeBook", 1),
//                               _customButton("Chart", 2),
//                               _customButton("Running Trade", 3),
//                               _customButton("Daily Price", 4),
//                               _customButton("Brokers Price", 5),
//                               _customButton("Foreign Price", 6),
//                               _customButton("Messages", 7),
//                               _customButton("News", 8),
//                               _customButton("Info", 9),
//                               _customButton("Analyst", 10),
//                             ],
//                           ),
//                         ),
//                       ),
//                       if (_selectedIndex == 2)
//                         Container(
//                           margin: EdgeInsets.only(left: 8.w, bottom: 3.h),
//                           child: PopupMenuButton(
//                             elevation: 0,
//                             position: PopupMenuPosition.under,
//                             constraints: BoxConstraints.tightFor(
//                               height: 100.h,
//                               width: 0.22.sw,
//                             ),
//                             color: foregroundwidget,
//                             itemBuilder: (context) => [
//                               PopupMenuItem(
//                                 height: 50.h,
//                                 value: 'DY',
//                                 child: Center(
//                                     child: Text(
//                                   'Daily',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: FontSizes.size12),
//                                 )),
//                               ),
//                               PopupMenuItem(
//                                 height: 50.h,
//                                 value: 'WY',
//                                 child: Center(
//                                     child: Text(
//                                   'Weekly',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: FontSizes.size12),
//                                 )),
//                               ),
//                               PopupMenuItem(
//                                 height: 50.h,
//                                 value: 'MY',
//                                 child: Center(
//                                     child: Text(
//                                   'Monthly',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: FontSizes.size12),
//                                 )),
//                               ),
//                               PopupMenuItem(
//                                 height: 50.h,
//                                 value: 'ID',
//                                 child: Center(
//                                     child: Text(
//                                   'Intraday',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: FontSizes.size12),
//                                 )),
//                               ),
//                             ],
//                             onSelected: (value) {
//                               switch (value) {
//                                 case 'DY':
//                                   val.value = 'Daily';
//                                   val.refresh();
//                                   reqChartbasedonType(val.value);
//                                 case 'WY':
//                                   val.value = 'Weekly';
//                                   val.refresh();
//                                   reqChartbasedonType(val.value);
//                                 case 'MY':
//                                   val.value = 'Monthly';
//                                   val.refresh();
//                                   reqChartbasedonType(val.value);
//                                 case 'ID':
//                                   val.value = 'Intraday';
//                                   val.refresh();
//                               }
//                             },
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 width: 0.22.sw,
//                                 height: 22.h,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.85),
//                                   borderRadius: BorderRadius.circular(3.r),
//                                 ),
//                                 child: Obx(
//                                   () => Text(
//                                     val.value,
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: FontSizes.size12),
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       _selectedIndex == 0
//                           ? Expanded(
//                               child: SreamOBView(
//                                 prevP: prevprice,
//                                 stockCsearch: widget.title,
//                                 board: Get.find<ControllerBoard>().boards.value,
//                               ),
//                             )
//                           : _selectedIndex == 1
//                               ? Expanded(
//                                   child: TradeBookWidget(
//                                     prevP: prevprice,
//                                     stockCsearch: widget.title,
//                                     board: Get.find<ControllerBoard>()
//                                         .boards
//                                         .value,
//                                   ),
//                                 )
//                               : _selectedIndex == 2
//                                   ? Obx(() {
//                                       if (val.value == "Daily") {
//                                         return Expanded(
//                                           child: StreamBuilder(
//                                               stream: CandleList.getDaily(
//                                                 widget.title,
//                                                 Get.find<ControllerBoard>()
//                                                     .boards
//                                                     .value,
//                                               ),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.connectionState ==
//                                                     ConnectionState.waiting) {
//                                                   return const Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   );
//                                                 } else if (snapshot.hasError) {
//                                                   return Center(
//                                                     child: Text(
//                                                       snapshot.error.toString(),
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   if (snapshot.data == null ||
//                                                       snapshot.data!.isEmpty) {
//                                                     return SizedBox(
//                                                       width: double.infinity,
//                                                       height: double.infinity,
//                                                       child: Column(
//                                                         children: [
//                                                           Flexible(
//                                                             flex: 14,
//                                                             child: Container(
//                                                               color:
//                                                                   Colors.blue,
//                                                               child:
//                                                                   ChartComponent(
//                                                                 type: ChartType
//                                                                     .daily,
//                                                                 stockCode: widget
//                                                                     .title
//                                                                     .toString(),
//                                                                 board: Get.find<
//                                                                         ControllerBoard>()
//                                                                     .boards
//                                                                     .value,
//                                                                 data: CandleList
//                                                                     .generateList(
//                                                                         []),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     return SizedBox(
//                                                       width: double.infinity,
//                                                       height: double.infinity,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           SizedBox(
//                                                             height: 3.h,
//                                                           ),
//                                                           Flexible(
//                                                             flex: 14,
//                                                             child:
//                                                                 ChartComponent(
//                                                               type: ChartType
//                                                                   .daily,
//                                                               stockCode: widget
//                                                                   .title
//                                                                   .toString(),
//                                                               board: Get.find<
//                                                                       ControllerBoard>()
//                                                                   .boards
//                                                                   .value,
//                                                               data: CandleList
//                                                                   .generateList(
//                                                                 snapshot.data ==
//                                                                             null ||
//                                                                         snapshot
//                                                                             .data!
//                                                                             .isEmpty
//                                                                     ? []
//                                                                     : snapshot
//                                                                         .data!
//                                                                         .first
//                                                                         .arrayDailyChartList,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   }
//                                                 }
//                                               }),
//                                         );
//                                       } else if (val.value == "Weekly") {
//                                         return Expanded(
//                                           child: StreamBuilder(
//                                               stream:
//                                                   CandleListWeekly.getWeekly(
//                                                 widget.title,
//                                                 Get.find<ControllerBoard>()
//                                                     .boards
//                                                     .value,
//                                               ),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.connectionState ==
//                                                     ConnectionState.waiting) {
//                                                   return const Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   );
//                                                 } else if (snapshot.hasError) {
//                                                   return Center(
//                                                     child: Text(
//                                                       snapshot.error.toString(),
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   if (snapshot.data == null ||
//                                                       snapshot.data!.isEmpty) {
//                                                     return SizedBox(
//                                                       width: double.infinity,
//                                                       height: double.infinity,
//                                                       child: Column(
//                                                         children: [
//                                                           Flexible(
//                                                             flex: 14,
//                                                             child: Container(
//                                                               color:
//                                                                   Colors.blue,
//                                                               child:
//                                                                   ChartComponent(
//                                                                 type: ChartType
//                                                                     .weekly,
//                                                                 stockCode: widget
//                                                                     .title
//                                                                     .toString(),
//                                                                 board: Get.find<
//                                                                         ControllerBoard>()
//                                                                     .boards
//                                                                     .value,
//                                                                 data: CandleList
//                                                                     .generateList(
//                                                                         []),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     return SizedBox(
//                                                       width: double.infinity,
//                                                       height: double.infinity,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           SizedBox(
//                                                             height: 3.h,
//                                                           ),
//                                                           Flexible(
//                                                             flex: 14,
//                                                             child:
//                                                                 ChartComponent(
//                                                               type: ChartType
//                                                                   .weekly,
//                                                               stockCode: widget
//                                                                   .title
//                                                                   .toString(),
//                                                               board: Get.find<
//                                                                       ControllerBoard>()
//                                                                   .boards
//                                                                   .value,
//                                                               data: CandleListWeekly
//                                                                   .generateList(
//                                                                 snapshot.data ==
//                                                                             null ||
//                                                                         snapshot
//                                                                             .data!
//                                                                             .isEmpty
//                                                                     ? []
//                                                                     : snapshot
//                                                                         .data!
//                                                                         .first
//                                                                         .arrayWeeklyChartList,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   }
//                                                 }
//                                               }),
//                                         );
//                                       } else if (val.value == "Monthly") {
//                                         return Expanded(
//                                           child: StreamBuilder(
//                                               stream:
//                                                   CandleListMonthly.getMonthly(
//                                                 widget.title,
//                                                 Get.find<ControllerBoard>()
//                                                     .boards
//                                                     .value,
//                                               ),
//                                               builder: (context, snapshot) {
//                                                 if (snapshot.connectionState ==
//                                                     ConnectionState.waiting) {
//                                                   return const Center(
//                                                     child:
//                                                         CircularProgressIndicator(),
//                                                   );
//                                                 } else if (snapshot.hasError) {
//                                                   return Center(
//                                                     child: Text(
//                                                       snapshot.error.toString(),
//                                                     ),
//                                                   );
//                                                 } else {
//                                                   if (snapshot.data == null ||
//                                                       snapshot.data!.isEmpty) {
//                                                     return SizedBox(
//                                                       width: double.infinity,
//                                                       height: double.infinity,
//                                                       child: Column(
//                                                         children: [
//                                                           Flexible(
//                                                             flex: 14,
//                                                             child:
//                                                                 ChartComponent(
//                                                               type: ChartType
//                                                                   .monthly,
//                                                               stockCode: widget
//                                                                   .title
//                                                                   .toString(),
//                                                               board: Get.find<
//                                                                       ControllerBoard>()
//                                                                   .boards
//                                                                   .value,
//                                                               data: CandleListMonthly
//                                                                   .generateList(
//                                                                 [],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   } else {
//                                                     return SizedBox(
//                                                       width: double.infinity,
//                                                       height: double.infinity,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           SizedBox(
//                                                             height: 3.h,
//                                                           ),
//                                                           Flexible(
//                                                             flex: 14,
//                                                             child:
//                                                                 ChartComponent(
//                                                               type: ChartType
//                                                                   .monthly,
//                                                               stockCode: widget
//                                                                   .title
//                                                                   .toString(),
//                                                               board: Get.find<
//                                                                       ControllerBoard>()
//                                                                   .boards
//                                                                   .value,
//                                                               data: CandleListMonthly
//                                                                   .generateList(
//                                                                 snapshot.data ==
//                                                                             null ||
//                                                                         snapshot
//                                                                             .data!
//                                                                             .isEmpty
//                                                                     ? []
//                                                                     : snapshot
//                                                                         .data!
//                                                                         .first
//                                                                         .arrayMonthlyChartList,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   }
//                                                 }
//                                               }),
//                                         );
//                                       } else if (val.value == "Intraday") {
//                                         return Container();
//                                       } else {
//                                         return Container();
//                                       }
//                                     })
//                                   : _selectedIndex == 3
//                                       ? Expanded(
//                                           child: RunningTradeWidget(
//                                             stockCsearch: widget.title,
//                                           ),
//                                         )
//                                       : _selectedIndex == 4
//                                           ? Expanded(
//                                               child: DailyDataWidget(
//                                               title: widget.title,
//                                             ))
//                                           : _selectedIndex == 5
//                                               ? Container(
//                                                   // broker price
//                                                   )
//                                               : _selectedIndex == 6
//                                                   // foreign price
//                                                   ? Container()
//                                                   : _selectedIndex == 7
//                                                       // message
//                                                       ? const Expanded(
//                                                           child:
//                                                               MessageWidget())
//                                                       : _selectedIndex == 8
//                                                           // news
//                                                           ? const Expanded(
//                                                               child:
//                                                                   NewsWidget())
//                                                           : _selectedIndex == 9
//                                                               // info
//                                                               ? Expanded(
//                                                                   child:
//                                                                       InfoWidget(
//                                                                     stockC: widget
//                                                                         .title,
//                                                                     stockN: widget
//                                                                         .subTitle,
//                                                                   ),
//                                                                 )
//                                                               : _selectedIndex ==
//                                                                       10
//                                                                   // analisis
//                                                                   ? const Expanded(
//                                                                       child:
//                                                                           AnalisisWidget())
//                                                                   : Container(),
//                     ],
//                   ),
//                   isLove
//                       ? Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isLove = !isLove;
//                               });
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               color: Colors.black.withOpacity(0.9),
//                               height: 1.sh,
//                               width: 1.sw,
//                               child: Container(
//                                 padding: EdgeInsets.all(20.w),
//                                 height: 0.4.sh,
//                                 width: 0.65.sw,
//                                 decoration: BoxDecoration(
//                                     color: foregroundwidget,
//                                     borderRadius: BorderRadius.circular(5.r)),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Add ${widget.title} to favorit",
//                                           style: TextStyle(
//                                             fontSize: 13.sp,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: SizedBox(
//                                             height: 0.2.sh,
//                                             child: ListView.builder(
//                                               shrinkWrap: true,
//                                               itemCount: options.isEmpty
//                                                   ? 0
//                                                   : options.length,
//                                               itemBuilder: (context, index) {
//                                                 return CheckboxListTile(
//                                                   activeColor: Colors.blue,
//                                                   checkColor: Colors.black,
//                                                   dense: true,
//                                                   controlAffinity:
//                                                       ListTileControlAffinity
//                                                           .trailing,
//                                                   contentPadding:
//                                                       EdgeInsets.symmetric(
//                                                     horizontal: 10.0.sp,
//                                                   ),
//                                                   selected:
//                                                       selectedOptions[index],
//                                                   title: Text(
//                                                     controllers.body
//                                                         .getAll()[index]
//                                                         .groupTag
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontSize:
//                                                             FontSizes.size13,
//                                                         color: Colors.white),
//                                                   ),
//                                                   value: selectedOptions[index],
//                                                   onChanged: (bool? value) {
//                                                     setState(() {
//                                                       selectedOptions[index] =
//                                                           !selectedOptions[
//                                                               index];
//                                                     });
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           height: 35.h,
//                                           child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           5.r)),
//                                               backgroundColor: Colors.red,
//                                             ),
//                                             onPressed: () {
//                                               setState(() {
//                                                 isLove = !isLove;
//                                               });
//                                             },
//                                             child: Text(
//                                               "Cancel",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: FontSizes.size12),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                         SizedBox(
//                                           height: 35.h,
//                                           child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5.r))),
//                                             onPressed: () async {
//                                               for (int i = 0;
//                                                   i < options.length;
//                                                   i++) {
//                                                 var queryB = controllers.body
//                                                     .query(FavoriteLoacalB_
//                                                         .groupTag
//                                                         .equals(options[i]
//                                                             .groupTag
//                                                             .toString()))
//                                                     .build()
//                                                     .findFirst();

//                                                 if (queryB != null) {
//                                                   if (selectedOptions[i]) {
//                                                     bool stockCodeFound = false;
//                                                     for (int x = 0;
//                                                         x <
//                                                             queryB
//                                                                 .member.length;
//                                                         x++) {
//                                                       if (queryB.member[x]
//                                                               .stockCode !=
//                                                           widget.title) {
//                                                         stockCodeFound = true;
//                                                       } else {
//                                                         stockCodeFound = false;
//                                                         break;
//                                                       }
//                                                     }
//                                                     if (queryB.member.isEmpty) {
//                                                       controllers.onAddMember(
//                                                           queryB,
//                                                           widget.title,
//                                                           false);
//                                                     }

//                                                     if (stockCodeFound) {
//                                                       controllers.onAddMember(
//                                                           queryB,
//                                                           widget.title,
//                                                           false);
//                                                     }
//                                                   }
//                                                 }
//                                               }
//                                               setState(() {
//                                                 isLove = !isLove;
//                                               });
//                                             },
//                                             child: Text(
//                                               "Ok",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: FontSizes.size12),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       : Container(),
//                 ],
//               ),
//               floatingActionButtonLocation:
//                   FloatingActionButtonLocation.centerFloat,
//               floatingActionButton: ExpandableFab(
//                 distance: 120.r,
//                 children: [
//                   ActionButton(
//                     color: Colors.red,
//                     title: "BUY",
//                     onPressed: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/goCheckoutview',
//                         arguments: <String, String>{
//                           'prevP': prevprice.toString(),
//                           'title': widget.title,
//                           'subtitle': widget.subTitle,
//                           'board': Get.find<ControllerBoard>().boards.value,
//                           'typeCheckout': "BUY",
//                         },
//                       );
//                     },
//                   ),
//                   ActionButton(
//                     color: Colors.green,
//                     title: "SELL",
//                     onPressed: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/goCheckoutview',
//                         arguments: <String, String>{
//                           'prevP': prevprice.toString(),
//                           'title': widget.title,
//                           'subtitle': widget.subTitle,
//                           'board': Get.find<ControllerBoard>().boards.value,
//                           'typeCheckout': "SELL",
//                         },
//                       );
//                     },
//                   ),
//                   ActionButton(
//                     color: ConstantStyle.oren,
//                     title: "AMEND",
//                     onPressed: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/goCheckoutview',
//                         arguments: <String, String>{
//                           'prevP': prevprice.toString(),
//                           'title': widget.title,
//                           'subtitle': widget.subTitle,
//                           'board': Get.find<ControllerBoard>().boards.value,
//                           'typeCheckout': "AMEND",
//                         },
//                       );
//                     },
//                   ),
//                   ActionButton(
//                     color: Colors.blue,
//                     title: "WD",
//                     onPressed: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/goCheckoutview',
//                         arguments: <String, String>{
//                           'prevP': prevprice.toString(),
//                           'title': widget.title,
//                           'subtitle': widget.subTitle,
//                           'board': Get.find<ControllerBoard>().boards.value,
//                           'typeCheckout': "WD",
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             getConnect.onError()
//                 ? GestureDetector(
//                     onTap: () {
// getConnect.onErrors.toggle();
//                     },
//                     child: Scaffold(
//                       backgroundColor: Colors.transparent,
//                       body: Container(
//                         alignment: Alignment.center,
//                         color: Colors.black.withOpacity(0.9),
//                         height: Get.height,
//                         width: Get.width,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: foregroundwidget,
//                             borderRadius: BorderRadius.circular(5.r),
//                           ),
//                           padding: EdgeInsets.all(20.r),
//                           height: 0.425.sh,
//                           width: 0.7.sw,
//                           alignment: Alignment.center,
//                           child: Text(
//                             'ERROR CONNECT \n PLEASE TURN ON INTERNET OR CHECK VPN',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: FontSizes.size15,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _customButton(String title, int index) {
//     return GestureDetector(
//       onTap: () => _selectedIndex != index ? _onTabSelected(index) : null,
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 13.sp,
//               color: _selectedIndex == index ? ConstantStyle.oren : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

enum BoardOption {
  RG,
  TN,
  NG,
}

class ControllerBoard extends GetxController {
  var boards = 'RG'.obs;
  var stockCodes = 'ANTM'.obs;
  void updateBoard(String value) {
    boards.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    ever(boards, (callback) => null);
  }
}

List<Widget> _getHeaderWidget() {
  return [
    Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 33.h,
          width: 0.25.sw,
          color: foregroundwidget,
          child: Text(
            'Date',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 33.h,
          width: 0.23.sw,
          color: foregroundwidget,
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSizes.size12,
            ),
          ),
        ),
      ],
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.2.sw,
      color: foregroundwidget,
      child: Text(
        'Open',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.2.sw,
      color: foregroundwidget,
      child: Text(
        'High',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.2.sw,
      color: foregroundwidget,
      child: Text(
        'Low',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
    Container(
      alignment: Alignment.center,
      height: 33.h,
      width: 0.3.sw,
      color: foregroundwidget,
      child: Text(
        'Vol',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSizes.size12,
        ),
      ),
    ),
  ];
}

Stream<List<DailyChartDataModel>> getDailySortbyDate(
    String stockCode, String board) {
  final open = ObjectBoxDatabase.dailyChartDataBox;
  final stream = open.query(
    DailyChartDataModel_.stockCode.equals(stockCode) &
        DailyChartDataModel_.board.equals(board),
  );
  return stream.watch(triggerImmediately: true).map((event) => event.find());
}
