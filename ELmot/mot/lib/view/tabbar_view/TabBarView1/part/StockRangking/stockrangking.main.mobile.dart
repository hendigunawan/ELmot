import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/packagestocklist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/tabbar_view/TabBarView1/part/Card/card_vertical.shimmer.dart';
import 'package:online_trading/view/tabbar_view/TabBarView1/part/StockRangking/controllers/rangking.controllers.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import '../Card/cardvertical.dart';

class RangkingWidget extends StatelessWidget {
  const RangkingWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    GetDataRangkingController getData = Get.put(GetDataRangkingController());

    return getData.obx(
      (state) {
        List<PackageStockList> dataStockCode = [];
        for (int i = 0; i < (state!.length < 10 ? state.length : 10); i++) {
          var query = ObjectBoxDatabase.stockList
              .query(
                PackageStockList_.stcokCode.equals(
                  state[i].stockCode.toString(),
                ),
              )
              .build()
              .findFirst();
          if (query == null) {
            dataStockCode = [];
          } else {
            dataStockCode.add(query);
          }
        }
        return Container(
          margin: EdgeInsets.only(top: 5.h),
          child: ListView.builder(
            itemCount: state.length >= 10 ? 10 : state.length,
            shrinkWrap: true,
            itemBuilder: (bct, i) {
              StringBuffer getSpecialNotiver() {
                String getSN = dataStockCode[i].remake2.toString();
                String specialNotiver = getSN.substring(19, 30);
                List<String> fragments = specialNotiver.split('-');
                final buffer = StringBuffer();

                for (String fragment in fragments) {
                  if (fragment != "-") {
                    buffer.write(fragment);
                  }
                }
                return buffer;
              }

              return CardVertical(
                stockCode: state[i].stockCode,
                stockName: dataStockCode[i].stockName,
                spesialnotasi: getSpecialNotiver().isEmpty
                    ? ''
                    : getSpecialNotiver().toString(),
                detailspesialnotasi: getSpecialNotiver().isEmpty
                    ? ""
                    : specialNotations(
                        getSpecialNotiver(),
                      ).toString(),
                last: state[i].lastPrice,
                freq: state[i].freq,
                change: state[i].change,
                prev: state[i].prevPrice,
                changerate: state[i].chgRate,
                vol: state[i].volume,
                high: state[i].hiPrice,
                low: state[i].loPrice,
              );
            },
          ),
        );
      },
      onLoading: const CardVerticalShimmer(),
      onEmpty: Center(
        child: Text(
          'Empty',
          style: TextStyle(color: Colors.white, fontSize: FontSizes.size13),
        ),
      ),
      onError: (error) => Text(
        error!,
        style: TextStyle(color: Colors.white, fontSize: FontSizes.size13),
      ),
    );
  }
}
