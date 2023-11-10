// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/module/model/packagestocklist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/widget/special_notations.dart';
import 'Card/cardhorizontal.dart';

class HorizontalWidget extends StatelessWidget {
  void Function(PackageStockList)? onTap;
  HorizontalWidget({super.key, this.onTap});
  final getObjectBox = ObjectBoxDatabase.indexMembers;
  final getObjectBoxStock = ObjectBoxDatabase.stockList;
  @override
  Widget build(BuildContext context) {
    final getI = getObjectBox
        .query(IndexMember_.indexCode.equals('LQ45'))
        .build()
        .findFirst();

    final listMemberIndex = getI == null ? [] : getI.array;
    List<PackageStockList> getMem() {
      List<PackageStockList> list = [];
      for (int i = 0; i < listMemberIndex.length; i++) {
        final query = getObjectBoxStock
            .query(PackageStockList_.stcokCode
                .contains(listMemberIndex[i].stockCode.toString()))
            .build()
            .find();
        list.add(query.first);
      }

      return list;
    }

    return Container(
      margin: EdgeInsets.only(top: 7.h),
      height: 255.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: listMemberIndex.isEmpty ? 1 : listMemberIndex.length,
        itemBuilder: (BuildContext context, int index) {
          StringBuffer getSpecialNotiver() {
            String getSN = getMem()[index].remake2.toString();
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

          return listMemberIndex.isEmpty
              ? Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    onTap!(getMem()[index]);
                  },
                  child: CardHorizontal(
                    title: getMem()[index].stcokCode.toString(),
                    spesialnotasi: getSpecialNotiver().isEmpty
                        ? ''
                        : getSpecialNotiver().toString(),
                    detailspesialnotasi: getSpecialNotiver().isEmpty
                        ? ""
                        : specialNotations(
                            getSpecialNotiver(),
                          ).toString(),
                    isi: getMem()[index].stockName.toString(),
                  ),
                );
        },
      ),
    );
  }
}
