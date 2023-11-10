import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';
import 'package:online_trading/view/tabbar_view/tradingView/controller/runningtrade.controller.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/build.tablerunningtrade.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/popup.trading.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class TradingViewMain extends StatelessWidget {
  TradingViewMain({super.key});

  final getController = Get.put(ControllerHandelSUB());
  final getRunning = Get.put(RunningTradeController());

  @override
  Widget build(BuildContext context) {
    getController.addOrUpdateToSubList(
      ModelSUB(routingKey: 'RT.*.*'),
    );
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            height: 45.h,
            padding: EdgeInsets.all(10.w),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Running Trades',
                  style: TextStyle(
                    color: putihop85,
                    fontSize: FontSizes.size15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  child: Icon(
                    Icons.settings,
                    size: 20.sp,
                    color: putihop85,
                  ),
                  onTap: () {
                    PopupBottom.show(context);
                  },
                ),
              ],
            ),
          ),
          // const Divider(),
          Expanded(
            child: Obx(() {
              List<RunningTrades> data = [];
              if (getRunning.rombongan.isEmpty) {
                data = getRunning.list.reversed.toList();
              } else {
                data = getRunning.listQuery.reversed.toList();
              }

              return MainTable(
                // border: 1,
                header: BuildTableRT.header(),
                body: BuildTableRT.dataBody(data).isEmpty
                    ? []
                    : BuildTableRT.dataBody(data),
              );
            }),
          ),
        ],
      ),
    );
  }
}
