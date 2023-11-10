import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/pkg/order/requestGTCList.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/listGTC/constans/tableHeaderGTC.const.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';

Widget tableGTC({void Function(int index)? onTap, Widget? childEtions}) {
  return Obx(() {
    return HorizontalDataTable(
      elevation: 0,
      rowSeparatorWidget: Divider(
        height: 2.h,
        thickness: 0.05,
      ),
      leftHandSideColumnWidth: 0.6.sw,
      rightHandSideColumnWidth: 2.sw,
      isFixedHeader: true,
      leftHandSideColBackgroundColor: Colors.black,
      rightHandSideColBackgroundColor: Colors.black,
      headerWidgets: getHeaderWidgetGTC(),
      itemCount: listGTC.isEmpty ? 0 : listGTC.first.array!.length,
      leftSideItemBuilder: (context, index) {
        return Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 66.h,
              width: 0.1.sw,
              color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: listGTC.first.array![index].subscribeStatus != 1 ||
                        listGTC.first.array![index].subscribeStatus != 1
                    ? []
                    : [
                        GestureDetector(
                          onTap: () {
                            onTap!(index);
                          },
                          child: childEtions ??
                              Icon(
                                Icons.cancel,
                                size: FontSizes.size16,
                                color: const Color(0xFFE53935),
                              ),
                        ),
                      ],
              ),
            ),
            Container(
              color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
              height: 66.h,
              width: 0.25.sw,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 33.h,
                    alignment: Alignment.center,
                    child: Text(
                      dateAjaGarisMiring(
                          listGTC.first.array![index].subscribeDate),
                      maxLines: 1,
                      style: TextStyle(
                        color: putihop85,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                    height: 33.h,
                    alignment: Alignment.center,
                    child: Text(
                      dateTimeAJa(
                          listGTC.first.array![index].subscribeTime.toString()),
                      maxLines: 1,
                      style: TextStyle(
                        color: putihop85,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
              height: 66.h,
              width: 0.25.sw,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 33.h,
                    alignment: Alignment.center,
                    child: Text(
                      listGTC.first.array![index].stockCode.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        color: putihop85,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                    height: 33.h,
                    alignment: Alignment.center,
                    child: Text(
                      (listGTC.first.array![index].command == 0
                              ? 'Buy'
                              : 'Sell')
                          .toUpperCase(),
                      maxLines: 1,
                      style: TextStyle(
                        color: listGTC.first.array![index].command == 0
                            ? Colors.red
                            : Colors.green,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      rightSideItemBuilder: (context, index) {
        return Row(
          children: List.generate(1, (i) {
            return Row(
              children: List.generate(1, (i) {
                return Row(
                  children: [
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              dateAjaGarisMiring(
                                  listGTC.first.array![index].effectiveDate),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              dateAjaGarisMiring(
                                  listGTC.first.array![index].dueDate),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].sessionId.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].gtcFlags.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].exchangeCode
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].marketCode == "RG"
                                  ? "Regular"
                                  : "Tunai",
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].expiry == 0
                                  ? "Day Order"
                                  : "Session Order",
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  listGTC.first.array![index].price!),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  listGTC.first.array![index].oVolume! ~/
                                      Get.find<LoginOrderController>()
                                          .order!
                                          .value
                                          .lot!),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  listGTC.first.array![index].rVolume! ~/
                                      Get.find<LoginOrderController>()
                                          .order!
                                          .value
                                          .lot!),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  listGTC.first.array![index].tVolume! ~/
                                      Get.find<LoginOrderController>()
                                          .order!
                                          .value
                                          .lot!),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.centerRight,
                            child: Text(
                              listGTC.first.array![index].autoPriceStep
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Container(
                        height: 66.h,
                        alignment: Alignment.center,
                        child: Text(
                          listGTC.first.array![index].subscribeStatus == 0
                              ? "Unsubscribe"
                              : listGTC.first.array![index].subscribeStatus == 1
                                  ? "Open"
                                  : listGTC.first.array![index]
                                              .subscribeStatus ==
                                          2
                                      ? "Done"
                                      : "Withdrawn",
                          maxLines: 1,
                          style: TextStyle(
                            color: putihop85,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].inputUser!,
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            child: Text(
                              listGTC.first.array![index].cancelUser!,
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            );
          }),
        );
      },
    );
  });
}
