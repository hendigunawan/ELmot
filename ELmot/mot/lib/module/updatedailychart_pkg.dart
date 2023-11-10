import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/dailychartdata_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

UpdateDailyChart() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  UpdateArrayDailyChartData update = UpdateArrayDailyChartData();
  final openBox = ObjectBoxDatabase.dailyChartDataBox;

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

  update = UpdateArrayDailyChartData(
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
          DailyChartDataModel_.stockCode.equals(update.stockCode.toString()) &
              DailyChartDataModel_.board.equals(update.board.toString()))
      .build()
      .findFirst();

  if (query != null) {
    ArrayDailyChartData? where;
    for (var i = 0; i < query.arrayDailyChartList.length; i++) {
      if (query.arrayDailyChartList[i].date == update.date) {
        where = query.arrayDailyChartList[i];
        break;
      }
    }
    // var where = query.arrayDailyChartList.firstWhereOrNull(
    //   (element) => element.date == update.date,
    // );

    var updatedChartData = ArrayDailyChartData(
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
      query.arrayDailyChartList.add(updatedChartData);
    } else {
      query.arrayDailyChartList.removeWhere(
        (element) => element.date == where!.date,
      );
      query.arrayDailyChartList.add(updatedChartData);
    }

    // Sort the array after additions or removals
    // query.arrayDailyChartList.sort(
    //   (a, b) => (a.date as int).compareTo(b.date as int),
    // );

    openBox.put(query);
  }

  update;
}
