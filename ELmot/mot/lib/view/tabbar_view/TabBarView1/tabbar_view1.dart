import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

import 'part/StockRangking/controllers/rangking.controllers.dart';
import 'part/StockRangking/stockrangking.main.mobile.dart';
import 'part/horizontalview_widget.dart';

void datas() {
  if (Get.put(ConnectionsController()).onReadys.value == false) return;
  Get.find<ControllerHandelSUB>().unBind();
  var open0 = ObjectBoxDatabase.indexMembers;
  var open1 = ObjectBoxDatabase.StockCodeRangking;
  if (!open0.isEmpty()) {
    var query =
        open0.query(IndexMember_.indexCode.equals('LQ45')).build().findFirst();
    if (query != null) {
      for (var i = 0; i < query.array.length; i++) {
        Get.find<ControllerHandelSUB>().addOrUpdateToSubList(
          ModelSUB(
            routingKey: 'QT.${query.array[i].stockCode}.RG',
          ),
        );
      }
    }
  }
  if (!open1.isEmpty()) {
    var query = open1
        .query(StockData_.reqType.equals(1) & StockData_.iBoard.equals(0))
        .build()
        .findFirst();
    if (query != null && query.arrayData.isNotEmpty) {
      for (var i = 0; (i < 10 ? i < query.arrayData.length : i < 10); i++) {
        Get.find<ControllerHandelSUB>().addOrUpdateToSubList(
          ModelSUB(
            routingKey: 'QT.${query.arrayData[i].stockCode}.RG',
          ),
        );
      }
    }
  }
}

class TabBarView1 extends StatefulWidget {
  const TabBarView1({super.key});

  @override
  State<TabBarView1> createState() => _TabBarView1State();
}

class _TabBarView1State extends State<TabBarView1> {
  GetDataRangkingController getDataRangking =
      Get.put(GetDataRangkingController());

  RxInt _selectedIndex = 1.obs;
  void _onTabSelected(int index) {
    _selectedIndex.value = index;
    if (_selectedIndex.value == 1) {
      getDataRangking.add(
        HandelReqRangkinModel(
          code: 1,
          board: 'RG',
        ),
        indexs: _selectedIndex.value,
      );
      getDataRangking.isFirst.toggle();
      getDataRangking.isDelate.toggle();
    } else if (_selectedIndex.value == 8) {
      getDataRangking.add(
        HandelReqRangkinModel(
          code: 8,
          board: 'RG',
        ),
        indexs: _selectedIndex.value,
      );
      getDataRangking.isFirst.toggle();
      getDataRangking.isDelate.toggle();
    } else {
      getDataRangking.add(
        HandelReqRangkinModel(
          code: 6,
          board: 'RG',
        ),
        indexs: _selectedIndex.value,
      );
      getDataRangking.isFirst.toggle();
      getDataRangking.isDelate.toggle();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Dispose');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('Deactive');
  }

  @override
  Widget build(BuildContext context) {
    datas();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HorizontalWidget(
          onTap: (data) {
            Navigator.pushNamed(
              context,
              '/goDetailview',
              arguments: <String, String>{
                'title': data.stcokCode.toString(),
                'subtitle': data.stockName.toString(),
                'board': 'RG',
              },
            );
          },
        ),
        Container(
          margin: EdgeInsets.only(top: 8.h),
          child: SizedBox(
            width: 0.9.sw,
            height: 30.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _customButton("Top Active", 1),
                _customButton("Top Gainer", 8),
                _customButton("Top Looser", 6),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: RangkingWidget(
            index: _selectedIndex.value,
          ),
        ),
      ],
    );
  }

  Widget _customButton(String title, int index) {
    return GestureDetector(
      onTap: () => _selectedIndex.value != index ? _onTabSelected(index) : null,
      child: Obx(
        () {
          _selectedIndex = getDataRangking.index;
          return ClipPath(
            clipper: FolderShapeClipper(),
            child: Container(
              constraints: BoxConstraints.expand(
                width: 0.28.sw,
              ),
              alignment: Alignment.center,
              color: bgabu,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: getDataRangking.index.value == index
                      ? ConstantStyle.oren
                      : Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FolderShapeClipper extends CustomClipper<Path> {
  final a = 0.10;
  final b = 0.25;
  final c = 0.5;
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * a, 0)
      ..lineTo(0, size.height * b)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0)
      // ..lineTo(size.width, size.height)
      // ..lineTo(size.width * c, 0)
      // ..lineTo(size.width * a, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
