// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class MainListSpreadOrder extends StatelessWidget {
  MainListSpreadOrder({super.key});

  late String pin = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 40.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'List Spread Order',
            style: TextStyle(
              fontSize: 16.sp,
              color: putihop85,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              // listGTC.clear();
              // controller.clear();
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: putihop85,
              size: 20.sp,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Pin.show(
            onComplete: (a) {
              Get.put(PinSave()).pin.value = a;
              // Get.put(BodyController());
              pin = a;
              // OrderMassage.reqListTrailingList(
              //     accountId: accountId.value == ""
              //         ? Get.find<LoginOrderController>()
              //             .order!
              //             .value
              //             .account!
              //             .first
              //             .accountId
              //             .toString()
              //         : accountId.value,
              //     pin: int.parse(pin),
              //     status: int.parse(selectedType.value));
              // ActivityRequest.parameterRequest(requestFlag: 1);
            },
            onSelect: () async {
              // await Future.delayed(const Duration(milliseconds: 51), () {
              //   OrderMassage.reqListTrailingList(
              //       accountId: accountId.value == ""
              //           ? Get.find<LoginOrderController>()
              //               .order!
              //               .value
              //               .account!
              //               .first
              //               .accountId
              //               .toString()
              //           : accountId.value,
              //       pin: int.parse(Get.find<PinSave>().pin.value),
              //       status: int.parse(selectedType.value));
              // });
            },
          ),
        ],
      ),
    );
  }
}
