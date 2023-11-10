import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/orderListReq.model.dart';
import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';

OrderList orderListReq(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  OrderList datas = OrderList();
  int loginIdL = getController.encrypt2(buf);
  datas.loginId = getController.getAsciiString(buf, loginIdL);
  int referenceL = getController.encrypt2(buf);
  datas.reference = getController.getAsciiString(buf, referenceL);
  int accountIdL = getController.encrypt2(buf);
  datas.accountId = getController.getAsciiString(buf, accountIdL);
  int arrayL = getController.encrypt4(buf);
  List<OrderListData> array = [];
  for (var i = 0; i < arrayL; i++) {
    OrderListData dataAr = OrderListData();

    dataAr.orderStatus = getController.encrypt1(buf);
    int orderIdL = getController.encrypt2(buf);
    dataAr.orderId = getController.getAsciiString(buf, orderIdL);
    int amendIDL = getController.encrypt2(buf);
    dataAr.amendId = getController.getAsciiString(buf, amendIDL);
    int idxL = getController.encrypt2(buf);
    dataAr.idxOrderId = getController.getAsciiString(buf, idxL);
    dataAr.orderDate = getController.encrypt4(buf);
    dataAr.orderTime = getController.encrypt4(buf);
    dataAr.sentTime = getController.encrypt4(buf);
    int exchangeCodel = getController.encrypt2(buf);
    dataAr.exchangeCode = getController.getAsciiString(buf, exchangeCodel);
    int marketCodeL = getController.encrypt2(buf);
    dataAr.boardMarketCode = getController.getAsciiString(buf, marketCodeL);
    dataAr.expiry = getController.encrypt1(buf);
    dataAr.command = getController.encrypt1(buf);
    int stockCodeL = getController.encrypt2(buf);
    dataAr.stockCode = getController.getAsciiString(buf, stockCodeL);
    dataAr.price = getController.encrypt4(buf);
    dataAr.oVolume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    dataAr.rVolume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    dataAr.tVolume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    int inputUserL = getController.encrypt2(buf);
    dataAr.inputUser = getController.getAsciiString(buf, inputUserL);
    int counterPartyL = getController.encrypt2(buf);
    dataAr.counterPartyUid = getController.getAsciiString(buf, counterPartyL);
    dataAr.sourceId = getController.encrypt1(buf);
    int complianceIdL = getController.encrypt2(buf);
    dataAr.sidComplianceId = getController.getAsciiString(buf, complianceIdL);
    int clientIdL = getController.encrypt2(buf);
    dataAr.clientId = getController.getAsciiString(buf, clientIdL);

    array.add(dataAr);
  }
  datas.array = array;
  Get.put(OrderListController()).data.value = datas;
  return datas;
}
