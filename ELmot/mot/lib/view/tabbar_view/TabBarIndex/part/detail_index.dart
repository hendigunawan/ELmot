import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:online_trading/GetxController/stockmember_indexcontroller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/dailyindexchartdatas_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/part/Detailpart/historical.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/part/Detailpart/stocklist_index.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/part/quote_index.dart';

class DetailIndexTop extends StatelessWidget {
  final String indexCode;
  DetailIndexTop({super.key, required this.indexCode});
  final RxInt _selectedIndex = 0.obs;
  final controller = Get.put(StockMemberIndexController());
  final buildRG = Get.put(ControllerBoard());
  void requestStockwithBoard() {
    controller.getAllmemberWithQuery(
        indexCode, Get.find<ControllerBoard>().boards.value);
  }

  void _onTabSelected(int index) {
    _selectedIndex.value = index;
    switch (index) {
      case 0:
        requestStockwithBoard();
        break;
      case 1:
        ActivityRequest.dailyIndexChartDatasRequest(
          packageId: Constans.PACKAGE_ID_DAILY_INDEX_CHART_DATAS,
          indexCode: indexCode,
        );
        break;
      case 2:
        ActivityRequest.dailyIndexChartDatasRequest(
          packageId: Constans.PACKAGE_ID_DAILY_INDEX_CHART_DATAS,
          indexCode: indexCode,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    buildRG;
    controller.getAllmemberWithQuery(
        indexCode, Get.find<ControllerBoard>().boards.value);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 23.sp,
          ),
        ),
        foregroundColor: Colors.white,
        title: Text(
          indexCode,
          style: TextStyle(
            color: Colors.white,
            fontSize: FontSizes.size16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          QuotesIndex(
            indexCode: indexCode,
          ),
          Container(
            color: Colors.white,
            height: 30.h,
            width: 0.999.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _customButton("Stock", 0, context),
                    _customButton("Chart", 1, context),
                    _customButton("Historical", 2, context),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            return _selectedIndex.value == 0
                ? Container(
                    margin: EdgeInsets.only(
                      top: 5.h,
                      bottom: 5.h,
                    ),
                    child: PopupMenuButton(
                      constraints: BoxConstraints.tightFor(
                        height: 130.h,
                        width: 60.w,
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

                        requestStockwithBoard();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 5.w),
                        width: 45.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            border: Border.all(
                              width: 1.w,
                              color: Colors.green,
                            )),
                        child: Center(
                          child: GetBuilder<ControllerBoard>(
                            init: ControllerBoard(),
                            builder: (controllerBoard) => Text(
                              controllerBoard.boards.value,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: FontSizes.size11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          }),
          Obx(() {
            return _selectedIndex.value == 0
                ? Expanded(
                    child: StockListIndex(
                      indexCode: indexCode,
                    ),
                  )
                : _selectedIndex.value == 1
                    ? Expanded(
                        child: StreamBuilder(
                            stream: ObjectBoxDatabase.streamChart(indexCode),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ChartComponent(
                                  type: ChartType.daily,
                                  stockCode: indexCode,
                                  data: CandleList.generateList(
                                    snapshot.data == null ||
                                            snapshot.data!.isEmpty
                                        ? []
                                        : snapshot.data!.first
                                            .arraydailyindexchartdatasList,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              } else {
                                return ChartComponent(
                                  type: ChartType.daily,
                                  stockCode: indexCode,
                                  data: CandleList.generateList(
                                    snapshot.data == null ||
                                            snapshot.data!.isEmpty
                                        ? []
                                        : snapshot.data!.first
                                            .arraydailyindexchartdatasList,
                                  ),
                                );
                              }
                            }),
                      )
                    : _selectedIndex.value == 2
                        ? Flexible(
                            child: HistoricalMain(
                              indexCode: indexCode,
                            ),
                          )
                        : Container();
          })
        ],
      ),
    );
  }

  Widget _customButton(String title, int index, BuildContext context2) {
    return GestureDetector(
      onTap: () => _selectedIndex.value != index ? _onTabSelected(index) : null,
      child: Obx(() {
        return Column(
          children: [
            Container(
              width: 0.333.sw,
              height: 28.h,
              color: _selectedIndex.value == index ? Colors.white : bgabu,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: FontSizes.size13,
                    fontWeight: _selectedIndex.value == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _selectedIndex.value == index
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CandleList {
  static List<KLineEntity> generateList(
      List<ArrayDailyIndexChartDatasModel> datas) {
    List<ArrayDailyIndexChartDatasModel> data = List.filled(
        datas.length,
        ArrayDailyIndexChartDatasModel(
          closePrice: 0,
          date: int.parse(
              DateFormat("yyyyMMddHHkkmm", 'en_US').format(DateTime.now())),
          openPrice: 0,
          highPrice: 0,
          lowPrice: 0,
          freq: 0,
          value: 0,
          volume: 0,
        ));
    int ins = 0;
    for (var element in datas) {
      if (ins < datas.length) {
        data[ins] = element;
        ins++;
      }
    }
    var sorts = data..sort((a, b) => a.date!.compareTo(b.date!));

    return List.generate(
      sorts.length,
      (index) => KLineEntity.fromCustom(
        close: sorts[index].closePrice!.toInt().toDouble(),
        time: date(sorts[index].date!.toString()),
        open: sorts[index].openPrice!.toInt().toDouble(),
        vol: sorts[index].volume!.toInt().toDouble(),
        high: sorts[index].highPrice!.toInt().toDouble(),
        low: sorts[index].lowPrice!.toInt().toDouble(),
      ),
    ).toList();
  }
}
