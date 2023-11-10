import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
import 'package:online_trading/view/checkoutview/tradelist/widget/widget.tradelist.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class TradeListMain extends StatelessWidget {
  const TradeListMain({super.key});

  @override
  Widget build(BuildContext context) {
    listTradeList.clear();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 40.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: SizedBox(
              child: Icon(
                Icons.arrow_back,
                size: 0.05.sw,
                color: putihop85,
              ),
            ),
          ),
          title: Text(
            'Trade List',
            style: TextStyle(
              color: putihop85,
              fontSize: 16.sp,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Pin.show(
            onComplete: (a) {
              Get.find<PinSave>().pin.value = a;

              OrderMassage.reqTradeList(
                accountId: accountId.value == ''
                    ? Get.find<LoginOrderController>()
                        .order!
                        .value
                        .account!
                        .first
                        .accountId!
                    : accountId.value,
                pin: a,
              );
              fokusNode.unfocus();
            },
            onSelect: () async {
              await Future.delayed(const Duration(milliseconds: 51), () {
                OrderMassage.reqTradeList(
                  accountId: accountId.value == ''
                      ? Get.find<LoginOrderController>()
                          .order!
                          .value
                          .account!
                          .first
                          .accountId!
                      : accountId.value,
                  pin: Get.find<PinSave>().pin.value,
                );
              });
            },
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 8.h),
            child: const WidgetTradeList(),
          ))
        ],
      ),
    ));
  }
}
