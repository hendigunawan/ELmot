// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/info/stock_balance.model.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/table/main_table.dart';

class StockBalanceWidget extends StatelessWidget {
  StockBalanceWidget({super.key, this.onTapCode});
  void Function(StockBalanceARRAY)? onTapCode;
  var controller = Get.put(BodyController());
  RxBool isOriginal = true.obs;
  RxBool isOriginalV = true.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MainTable(
        isScroll: true,
        border: 0.1.w,
        header: [
          HeaderModel(
            alignment: Alignment.center,
            label: Text(
              'Code',
              style: TextStyle(
                  fontSize: FontSizes.size11,
                  color: putihop85,
                  fontWeight: FontWeight.bold),
            ),
            widthCol: FixedColumnWidth(
              0.17.sw,
            ),
          ),
          HeaderModel(
            alignment: Alignment.center,
            label: Text(
              'Avg',
              style: TextStyle(
                  fontSize: FontSizes.size11,
                  color: putihop85,
                  fontWeight: FontWeight.bold),
            ),
            widthCol: FixedColumnWidth(
              0.15.sw,
            ),
          ),
          HeaderModel(
            alignment: Alignment.center,
            label: Text(
              isOriginal.value ? 'Balance' : 'B.Share',
              style: TextStyle(
                  fontSize: FontSizes.size11,
                  color: putihop85,
                  fontWeight: FontWeight.bold),
            ),
            widthCol: FixedColumnWidth(
              0.18.sw,
            ),
          ),
          HeaderModel(
            alignment: Alignment.center,
            label: Text(
              isOriginalV.value ? 'Volume' : 'V.Share',
              style: TextStyle(
                  fontSize: FontSizes.size11,
                  color: putihop85,
                  fontWeight: FontWeight.bold),
            ),
            widthCol: FixedColumnWidth(
              0.17.sw,
            ),
          ),
          HeaderModel(
            alignment: Alignment.center,
            label: Text(
              'Gain/Loss',
              style: TextStyle(
                  fontSize: FontSizes.size11,
                  color: putihop85,
                  fontWeight: FontWeight.bold),
            ),
            widthCol: FixedColumnWidth(
              0.21.sw,
            ),
          ),
          HeaderModel(
            alignment: Alignment.center,
            label: Text(
              '%',
              style: TextStyle(
                  fontSize: FontSizes.size11,
                  color: putihop85,
                  fontWeight: FontWeight.bold),
            ),
            widthCol: FixedColumnWidth(
              0.12.sw,
            ),
          ),
        ],
        body: List.generate(
            controller.stockBalance.isEmpty
                ? 0
                : controller.stockBalance.first.stocks!.length, (index) {
          var data = controller.stockBalance.first.stocks;
          return BodyModel(
            body: [
              GestureDetector(
                onTap: () {
                  onTapCode == null ? null : onTapCode!(data[index]);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 3.w),
                  alignment: Alignment.centerLeft,
                  height: 30.h,
                  child: Text(
                    data![index].stockCode!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: FontSizes.size10,
                      color: putihop85,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 3.w),
                alignment: Alignment.centerRight,
                height: 30.h,
                child: Text(
                  formattaCurrun(data[index].avgPrice!),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: FontSizes.size10,
                    color: putihop85,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isOriginal.value = !isOriginal.value;
                },
                child: Container(
                  padding: EdgeInsets.only(right: 3.w),
                  alignment: Alignment.centerRight,
                  height: 30.h,
                  color: Colors.transparent,
                  child: Obx(() {
                    if (isOriginal.value) {
                      return Text(
                        formattaCurrun(data[index].balance! ~/
                            Get.find<LoginOrderController>().order!.value.lot!),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: FontSizes.size10,
                          color: putihop85,
                        ),
                        textAlign: TextAlign.right,
                      );
                    } else {
                      return Text(
                        formattaCurrun(data[index].balance!),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: FontSizes.size10,
                          color: putihop85,
                        ),
                        textAlign: TextAlign.right,
                      );
                    }
                  }),
                ),
              ),
              GestureDetector(
                onTap: () {
                  isOriginalV.value = !isOriginalV.value;
                },
                child: Container(
                  padding: EdgeInsets.only(right: 3.w),
                  alignment: Alignment.centerRight,
                  height: 30.h,
                  color: Colors.transparent,
                  child: Obx(() {
                    if (isOriginalV.value) {
                      return Text(
                        formattaCurrun(data[index].volume! ~/
                            Get.find<LoginOrderController>().order!.value.lot!),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: FontSizes.size10,
                          color: putihop85,
                        ),
                        textAlign: TextAlign.right,
                      );
                    } else {
                      return Text(
                        formattaCurrun(data[index].volume!),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: FontSizes.size10,
                          color: putihop85,
                        ),
                        textAlign: TextAlign.right,
                      );
                    }
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 3.w),
                alignment: Alignment.centerRight,
                height: 30.h,
                child: Text(
                  formattaCurrun(data[index].potentialGainLoss!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: FontSizes.size10,
                    color: data[index].potentialGainLossPercentage! < 0
                        ? Colors.red
                        : Colors.green,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 3.w),
                alignment: Alignment.centerRight,
                height: 30.h,
                child: Text(
                  formattaCurrun(data[index].potentialGainLossPercentage! ~/
                      Get.find<LoginOrderController>().order!.value.lot!),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: FontSizes.size10,
                    color: data[index].potentialGainLossPercentage! < 0
                        ? Colors.red
                        : Colors.green,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
