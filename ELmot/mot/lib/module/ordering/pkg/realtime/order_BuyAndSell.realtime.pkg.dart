import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/realtime/order_BuyAndSell.realtime.model.dart';

OrderStatusModel orderStatusRealtime(Uint8List buf) {
  OrderStatusModel data = OrderStatusModel();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  data.orderStatus = getController.encrypt1(buf);
  int orderIdL = getController.encrypt2(buf);
  data.orderId = getController.getAsciiString(buf, orderIdL);
  int amendIdL = getController.encrypt2(buf);
  data.amendId = getController.getAsciiString(buf, amendIdL);
  int idxOrderIdL = getController.encrypt2(buf);
  data.idxOrderId = getController.getAsciiString(buf, idxOrderIdL);
  data.orderDate = getController.encrypt4(buf);
  data.orderTime = getController.encrypt4(buf);
  data.sentTime = getController.encrypt4(buf);
  int exchangeCodeL = getController.encrypt2(buf);
  data.exchangeCode = getController.getAsciiString(buf, exchangeCodeL);
  int boardL = getController.encrypt2(buf);
  data.boardMarketCode = getController.getAsciiString(buf, boardL);
  data.expiry = getController.encrypt1(buf);
  int custIdL = getController.encrypt2(buf);
  data.custId = getController.getAsciiString(buf, custIdL);
  int altL = getController.encrypt2(buf);
  data.alt = getController.getAsciiString(buf, altL);
  data.nationality = getController.encrypt1(buf);
  data.command = getController.encrypt1(buf);
  int stockCodeL = getController.encrypt2(buf);
  data.stockCode = getController.getAsciiString(buf, stockCodeL);
  data.price = getController.encrypt4(buf);
  data.oVolume = getController.encrypt8(buf);
  data.rVolume = getController.encrypt8(buf);
  data.tVolume = getController.encrypt8(buf);
  int inputUserL = getController.encrypt2(buf);
  data.inputUser = getController.getAsciiString(buf, inputUserL);
  int conterPartyUID = getController.encrypt2(buf);
  data.counterPartyUid = getController.getAsciiString(buf, conterPartyUID);
  data.sourceId = getController.encrypt1(buf);
  data.amendSourceId = getController.encrypt1(buf);
  int sid = getController.encrypt2(buf);
  data.sidComplianceId = getController.getAsciiString(buf, sid);
  int clientId = getController.encrypt2(buf);
  data.clientId = getController.getAsciiString(buf, clientId);

  return data;
}
