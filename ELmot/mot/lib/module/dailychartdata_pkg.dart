import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

import 'model/dailychartdata_model.dart';

updateDailyChartData() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  DailyChartDataModel listD = DailyChartDataModel();
  List<ArrayDailyChartData> addData = [];
  final object = ObjectBoxDatabase.dailyChartDataBox;

  int scl = getController.encrypt2(buf);
  String sc = getController.getAsciiString(buf, scl);
  int bl = getController.encrypt2(buf);
  String bls = getController.getAsciiString(buf, bl);
  int command = getController.encrypt1(buf);
  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int DATE = getController.encrypt4(buf);
    int OPENP = getController.encrypt4(buf);
    int HIGHP = getController.encrypt4(buf);
    int LOWP = getController.encrypt4(buf);
    int CLOSEP = getController.encrypt4(buf);
    int FREG = getController.encrypt4(buf);
    int VOLUME = getController.encrypt8(buf);
    int VALUE = getController.encrypt8(buf);
    addData.add(
      ArrayDailyChartData()
        ..date = DATE
        ..openPrice = OPENP
        ..highPrice = HIGHP
        ..lowPrice = LOWP
        ..closePrice = CLOSEP
        ..freq = FREG
        ..volume = VOLUME
        ..value = VALUE,
    );
  }
  listD = DailyChartDataModel(
    stockCodeL: scl,
    stockCode: sc,
    boardL: bl.toInt(),
    board: bls.toString(),
    command: command,
    array: AR,
  );

  final existingPerson = object
      .query(
        DailyChartDataModel_.stockCode.equals(listD.stockCode.toString()) &
            DailyChartDataModel_.board.equals(listD.board.toString()),
      )
      .build()
      .findFirst();
  listD.arrayDailyChartList.addAll(addData);
  if (existingPerson != null) {
    if (addData.isEmpty) {
      object.put(existingPerson);
    } else {
      // for (int i = 0; i < addData.length; i++) {
      //   var where = existingPerson.arrayDailyChartList.firstWhereOrNull(
      //     (element) => element.date == addData[i].date,
      //   );
      //   if (where != null) {
      //     existingPerson.arrayDailyChartList.removeWhere(
      //       ((element) => element.date == where.date),
      //     );
      //   }
      // }
      // existingPerson.arrayDailyChartList.clear();
      existingPerson.arrayDailyChartList.assignAll(addData);
      object.put(existingPerson);
      // existingPerson.arrayDailyChartList
      //     .sort((a, b) => a.date!.compareTo(b.date as num));
      // object.put(existingPerson);
    }

    print("Data daily chart diperbaharui : ${existingPerson.stockCode}");
  } else {
    print(
        "Data person dengan ${listD.board} dan ${listD.stockCode} yang sama tidak ditemukan");
    object.put(listD);
  }
}
