import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/historicalTradelist.model.dart';

RxList<HistoricalTradeListModel> listtradeListHistory =
    <HistoricalTradeListModel>[].obs;
HistoricalTradeListModel historicaltradeListReq(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  HistoricalTradeListModel datas = HistoricalTradeListModel();
  int loginIdL = getController.encrypt2(buf);
  datas.loginId = getController.getAsciiString(buf, loginIdL);
  int referenceL = getController.encrypt2(buf);
  datas.reference = getController.getAsciiString(buf, referenceL);
  int accountIdL = getController.encrypt2(buf);
  datas.accountId = getController.getAsciiString(buf, accountIdL);
  int arrayL = getController.encrypt4(buf);
  List<ArrayHistoricalTradeListModel> array = [];
  for (var i = 0; i < arrayL; i++) {
    ArrayHistoricalTradeListModel dataAr = ArrayHistoricalTradeListModel();

    int orderIdL = getController.encrypt2(buf);
    dataAr.orderId = getController.getAsciiString(buf, orderIdL);
    int idxL = getController.encrypt2(buf);
    dataAr.idxOrderId = getController.getAsciiString(buf, idxL);
    int amendIDL = getController.encrypt2(buf);
    dataAr.idxTradeId = getController.getAsciiString(buf, amendIDL);

    dataAr.tradeDate = getController.encrypt4(buf);
    dataAr.tradeTime = getController.encrypt4(buf);
    int exchangeCodel = getController.encrypt2(buf);
    dataAr.exchangeCode = getController.getAsciiString(buf, exchangeCodel);
    int marketCodeL = getController.encrypt2(buf);
    dataAr.board = getController.getAsciiString(buf, marketCodeL);
    dataAr.expiry = getController.encrypt1(buf);
    dataAr.command = getController.encrypt1(buf);
    int stockCodeL = getController.encrypt2(buf);
    dataAr.stockCode = getController.getAsciiString(buf, stockCodeL);
    dataAr.price = getController.encrypt4(buf);
    dataAr.volume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    int counterPartyL = getController.encrypt2(buf);
    dataAr.counterPartyUid = getController.getAsciiString(buf, counterPartyL);

    array.add(dataAr);
  }
  datas.array = array;
  listtradeListHistory.clear();
  listtradeListHistory.add(datas);
  return datas;
}
