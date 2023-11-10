import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/objectbox.g.dart';

import 'model/weeklychartdata_model.dart';
import 'objectbox/crud/crud_.dart';

updateWeeklyChartData() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  WeeklyChartDataModel listD = WeeklyChartDataModel();
  List<ArrayWeeklyChartData> addData = [];
  final object = ObjectBoxDatabase.weeklyChartDataBox;

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
      ArrayWeeklyChartData()
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
  listD = WeeklyChartDataModel(
    stockCodeL: scl,
    stockCode: sc,
    boardL: bl.toInt(),
    board: bls.toString(),
    command: command,
    array: AR,
  );

  final existingPerson = object
      .query(
        WeeklyChartDataModel_.stockCode.equals(listD.stockCode.toString()) &
            WeeklyChartDataModel_.board.equals(listD.board.toString()),
      )
      .build()
      .findFirst();
  listD.arrayWeeklyChartList.addAll(addData);
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
      existingPerson.arrayWeeklyChartList.assignAll(addData);
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

// ignore: non_constant_identifier_names
UpdateWeeklyChart() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  UpdateArrayWeeklyChartData update = UpdateArrayWeeklyChartData();
  final openBox = ObjectBoxDatabase.weeklyChartDataBox;

  int stockCodeL = getController.encrypt2(buf);
  String stockCode = getController.getAsciiString(buf, stockCodeL);
  int boardL = getController.encrypt2(buf);
  String board = getController.getAsciiString(buf, boardL);
  int DATE = getController.encrypt4(buf);
  int openPrice = getController.encrypt4(buf);
  int highPrice = getController.encrypt4(buf);
  int lowPrice = getController.encrypt4(buf);
  int closePrice = getController.encrypt4(buf);
  int freq = getController.encrypt4(buf);
  int volume = getController.encrypt8(buf);
  int value = getController.encrypt8(buf);

  update = UpdateArrayWeeklyChartData(
    stockCode: stockCode,
    board: board,
    date: DATE,
    openPrice: openPrice,
    lowPrice: lowPrice,
    highPrice: highPrice,
    closePrice: closePrice,
    freq: freq,
    volume: volume,
    value: value,
  );

  var query = openBox
      .query(
          WeeklyChartDataModel_.stockCode.equals(update.stockCode.toString()) &
              WeeklyChartDataModel_.board.equals(update.board.toString()))
      .build()
      .findFirst();

  if (query != null) {
    ArrayWeeklyChartData? where;
    for (var i = 0; i < query.arrayWeeklyChartList.length; i++) {
      if (query.arrayWeeklyChartList[i].date == update.date) {
        where = query.arrayWeeklyChartList[i];
        break;
      }
    }

    var updatedChartData = ArrayWeeklyChartData(
      date: update.date,
      openPrice: update.openPrice,
      lowPrice: update.lowPrice,
      highPrice: update.highPrice,
      closePrice: update.closePrice,
      freq: update.freq,
      volume: update.volume,
      value: update.value,
    );

    if (where == null) {
      query.arrayWeeklyChartList.add(updatedChartData);
    } else {
      query.arrayWeeklyChartList.removeWhere(
        (element) => element.date == where!.date,
      );
      query.arrayWeeklyChartList.add(updatedChartData);
    }

    openBox.put(query);
  }

  update;
}
