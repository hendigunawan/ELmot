import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/rangkingstock_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

StockRangking() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  final openBox = ObjectBoxDatabase.StockCodeRangking;

  int iBoard = getController.encrypt1(buf);
  int reqType = getController.encrypt1(buf);
  int array = getController.encrypt4(buf);

  List<ArrayData> arrayData = [];

  for (int i = 0; i < (array < 10 ? array : 10); i++) {
    int stockCodeL = getController.encrypt2(buf);
    String stockCode = getController.getAsciiString(buf, stockCodeL);
    int prevPrice = getController.encrypt4(buf);
    int lastPrice = getController.encrypt4(buf);
    int openPrice = getController.encrypt4(buf);
    int highPrice = getController.encrypt4(buf);
    int lowPrice = getController.encrypt4(buf);
    int avgPrice = getController.encrypt4(buf);
    int change = getController.getDouble(buf);
    int changeRate = getController.getDouble(buf);
    int tradedFreq = getController.encrypt8(buf);
    int tradedVolume = getController.encrypt8(buf);
    int tradedValue = getController.encrypt8(buf);

    arrayData.add(
      ArrayData(
        stockCodeLen: stockCodeL,
        stockCode: stockCode,
        prevPrice: prevPrice,
        lastPrice: lastPrice,
        openPrice: openPrice,
        highPrice: highPrice,
        lowPrice: lowPrice,
        avgPrice: avgPrice,
        change: change,
        changeRate: changeRate,
        tradedFreq: tradedFreq,
        tradedVolume: tradedVolume,
        tradedValue: tradedValue,
      ),
    );
  }
  StockData data = StockData(
    iBoard: iBoard,
    reqType: reqType,
    array: array,
  );
  var query = openBox
      .query(
          StockData_.reqType.equals(reqType) & StockData_.iBoard.equals(iBoard))
      .build()
      .findFirst();

  if (query != null) {
    query.arrayData.clear();
    query.arrayData.addAll(arrayData);
    openBox.put(query);
    print('UPDATE RANGKING TYPE: $reqType');
  } else {
    data.arrayData.addAll(arrayData);
    openBox.put(data);
    print('ADD RANGKING TYPE: $reqType');
  }
}
