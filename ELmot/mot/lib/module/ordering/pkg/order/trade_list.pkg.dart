import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/tradeList.model.dart';

RxList<TradeListModel> listTradeList = <TradeListModel>[].obs;
TradeListModel tradeListPKG(Uint8List buf) {
  TradeListModel data = TradeListModel();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  int loginId = getController.encrypt2(buf);
  data.loginId = getController.getAsciiString(buf, loginId);
  int ref = getController.encrypt2(buf);
  data.reference = getController.getAsciiString(buf, ref);
  int accountId = getController.encrypt2(buf);
  data.accountId = getController.getAsciiString(buf, accountId);
  int array = getController.encrypt4(buf);
  List<ArrayTradeList> dataArray = [];
  for (int i = 0; i < array; i++) {
    ArrayTradeList listD = ArrayTradeList();
    int orderIdL = getController.encrypt2(buf);
    listD.orderId = getController.getAsciiString(buf, orderIdL);
    int idxOrderIdL = getController.encrypt2(buf);
    listD.idxOrderId = getController.getAsciiString(buf, idxOrderIdL);
    int idxTradeIdL = getController.encrypt2(buf);
    listD.idxTradeId = getController.getAsciiString(buf, idxTradeIdL);
    listD.tradeDate = getController.encrypt4(buf);
    listD.tradeTime = getController.encrypt4(buf);
    int exchangeCodeL = getController.encrypt2(buf);
    listD.exchangeCode = getController.getAsciiString(buf, exchangeCodeL);
    int boardL = getController.encrypt2(buf);
    listD.board = getController.getAsciiString(buf, boardL);
    listD.expiry = getController.encrypt1(buf);
    listD.command = getController.encrypt1(buf);
    int stockCL = getController.encrypt2(buf);
    listD.stockCode = getController.getAsciiString(buf, stockCL);
    listD.price = getController.encrypt4(buf);
    listD.volume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    int counterPartyUidL = getController.encrypt2(buf);
    listD.counterPartyUid = getController.getAsciiString(buf, counterPartyUidL);
    listD.sourceId = getController.encrypt1(buf);
    dataArray.add(listD);
  }
  data.array = dataArray;
  listTradeList.clear();
  listTradeList.add(data);
  return data;
}
