import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/daily_history_stock_summary.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

updateDailyHistoryStockSummary() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  DailyHistoryStockSummaryDataModel listD = DailyHistoryStockSummaryDataModel();
  List<ArrayDailyHistoryStockSummaryData> addData = [];
  final object = ObjectBoxDatabase.dailyhistorystocksummary;

  int SCL = getController.encrypt2(buf);
  String SC = getController.getAsciiString(buf, SCL);
  int boardL = getController.encrypt2(buf);
  String board = getController.getAsciiString(buf, boardL);
  int command = getController.encrypt1(buf);
  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int DATE = getController.encrypt4(buf);
    int PREVP = getController.encrypt4(buf);
    int OPENP = getController.encrypt4(buf);
    int HIGHP = getController.encrypt4(buf);
    int LOWP = getController.encrypt4(buf);
    int CLOSEP = getController.encrypt4(buf);
    int AVGP = getController.encrypt4(buf);
    int CHANGE = getController.encrypt4(buf);
    int CHANGER = getController.encrypt4(buf);
    int FREG = getController.encrypt4(buf);
    int VOLUME = getController.encrypt8(buf);
    int VALUE = getController.encrypt8(buf);

    addData.add(ArrayDailyHistoryStockSummaryData()
      ..date = DATE
      ..prevPrice = PREVP
      ..openPrice = OPENP
      ..highPrice = HIGHP
      ..lowPrice = LOWP
      ..closePrice = CLOSEP
      ..avgPrice = AVGP
      ..chg = CHANGE
      ..chgRate = CHANGER
      ..freq = FREG
      ..volume = VOLUME
      ..value = VALUE);
  }
  listD = DailyHistoryStockSummaryDataModel(
      stockC: SC.toString(),
      stockCL: SCL,
      boardL: boardL.toInt(),
      board: board.toString(),
      command: command,
      array: AR);
  final existingPerson = object
      .query(
        DailyHistoryStockSummaryDataModel_.stockC
                .equals(listD.stockC.toString()) &
            DailyHistoryStockSummaryDataModel_.board
                .equals(listD.board.toString()),
      )
      .build()
      .findFirst();

  if (existingPerson != null) {
    object.remove(existingPerson.id!.toInt());
    object.put(listD);
    print("update");
  } else {
    object.put(listD);
    print("ADD");
  }
  print("Ini datanya ==========");
  print(listD.stockC);
  print(listD.stockCL);
}
