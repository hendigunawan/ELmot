import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'model/dailyindexchartdatas_model.dart';

RxList<DailyIndexChartDatasModel> dataChart = <DailyIndexChartDatasModel>[].obs;

updateDailyIndexChartDatas() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  DailyIndexChartDatasModel listD = DailyIndexChartDatasModel();
  List<ArrayDailyIndexChartDatasModel> addDataB = [];
  var object = ObjectBoxDatabase.indexChartDaily;

  int idxL = getController.encrypt2(buf);
  String ic = getController.getAsciiString(buf, idxL);
  int command = getController.encrypt1(buf);
  int Ar = getController.encrypt4(buf);
  for (int x = 0; x < Ar; x++) {
    int DATE = getController.encrypt4(buf);
    int OPENP = getController.encrypt4(buf);
    int HIGHP = getController.encrypt4(buf);
    int LOWP = getController.encrypt4(buf);
    int CLOSEP = getController.encrypt4(buf);
    int FREG = getController.encrypt4(buf);
    int VOLUME = getController.encrypt8(buf);
    int VALUE = getController.encrypt8(buf);

    addDataB.add(ArrayDailyIndexChartDatasModel()
      ..date = DATE
      ..openPrice = OPENP
      ..highPrice = HIGHP
      ..lowPrice = LOWP
      ..closePrice = CLOSEP
      ..freq = FREG
      ..volume = VOLUME
      ..value = VALUE);
  }
  listD = DailyIndexChartDatasModel(
    indexCodeL: idxL,
    indexCode: ic,
    command: command,
    array: Ar,
  );
  final existingPerson = object
      .query(DailyIndexChartDatasModel_.indexCode
          .equals(listD.indexCode.toString()))
      .build()
      .findFirst();

  listD.arraydailyindexchartdatasList.addAll(addDataB);
  if (existingPerson != null) {
    if (addDataB.isEmpty) {
      object.put(existingPerson);
    } else {
      for (int i = 0; i < addDataB.length; i++) {
        var where =
            existingPerson.arraydailyindexchartdatasList.firstWhereOrNull(
          (element) => element.date == addDataB[i].date,
        );
        if (where != null) {
          existingPerson.arraydailyindexchartdatasList.removeWhere(
            (element) => element.date == where.date,
          );
        }
      }
      existingPerson.arraydailyindexchartdatasList.addAll(addDataB);
      object.put(existingPerson);
    }
    print("Data daily chart index diperbaharui : ${existingPerson.indexCode}");
  } else {
    print("Data person dengan ${listD.indexCode}  yang sama tidak ditemukan");
    object.put(listD);
  }
  // dataChart.clear();
  dataChart.add(listD);
}

UpdateDailyChartIndex() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  UpdateStockDataIndex update = UpdateStockDataIndex();
  final openBox = ObjectBoxDatabase.indexChartDaily;

  int stockCodeL = getController.encrypt2(buf);
  String stockCode = getController.getAsciiString(buf, stockCodeL);
  int DATE = getController.encrypt4(buf);
  int openPrice = getController.encrypt4(buf);
  int highPrice = getController.encrypt4(buf);
  int lowPrice = getController.encrypt4(buf);
  int closePrice = getController.encrypt4(buf);
  int freq = getController.encrypt4(buf);
  int volume = getController.encrypt8(buf);
  int value = getController.encrypt8(buf);

  update = UpdateStockDataIndex(
    indexCode: stockCode,
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
      .query(DailyIndexChartDatasModel_.indexCode
          .equals(update.indexCode.toString()))
      .build()
      .findFirst();
  // var query =
  //     dataChart.firstWhereOrNull((p0) => p0.indexCode == update.indexCode);

  if (query != null) {
    var where = query.arraydailyindexchartdatasList.firstWhereOrNull(
      (element) => element.date == update.date,
    );
    if (where == null) {
      query.arraydailyindexchartdatasList.add(
        ArrayDailyIndexChartDatasModel(
          date: update.date,
          openPrice: update.openPrice,
          lowPrice: update.lowPrice,
          highPrice: update.highPrice,
          closePrice: update.closePrice,
          freq: update.freq,
          volume: update.volume,
          value: update.value,
        ),
      );
      openBox.put(query);
    } else {
      query.arraydailyindexchartdatasList
          .removeWhere((element) => element.date == where.date);
      query.arraydailyindexchartdatasList.add(
        ArrayDailyIndexChartDatasModel(
          date: update.date,
          openPrice: update.openPrice,
          lowPrice: update.lowPrice,
          highPrice: update.highPrice,
          closePrice: update.closePrice,
          freq: update.freq,
          volume: update.volume,
          value: update.value,
        ),
      );
      openBox.put(query);
    }
  }

  update;
}
