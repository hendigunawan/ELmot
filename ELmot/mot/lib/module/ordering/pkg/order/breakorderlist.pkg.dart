import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/breakorder_list.model.dart';

RxList<BreakOrderList> listBreakorderList = <BreakOrderList>[].obs;
BreakOrderList requestBreakOrderListPKG(Uint8List buf) {
  BreakOrderList data = BreakOrderList();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int loginId = getController.encrypt2(buf);
  data.loginId = getController.getAsciiString(buf, loginId);
  int ref = getController.encrypt2(buf);
  data.reference = getController.getAsciiString(buf, ref);
  int accountId = getController.encrypt2(buf);
  data.custId = getController.getAsciiString(buf, accountId);
  int array = getController.encrypt4(buf);
  List<ArrayBreakOrderList> dataArray = [];
  for (int i = 0; i < array; i++) {
    ArrayBreakOrderList array = ArrayBreakOrderList();
    int orderId = getController.encrypt2(buf);
    array.orderId = getController.getAsciiString(buf, orderId);
    array.command = getController.encrypt1(buf);
    int boardL = getController.encrypt2(buf);
    array.board = getController.getAsciiString(buf, boardL);
    int stockLen = getController.encrypt2(buf);
    array.stockCode = getController.getAsciiString(buf, stockLen);
    array.price = getController.encrypt4(buf);
    array.volume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    array.autoPriceStep = getController.encrypt4(buf);
    array.priceType = getController.encrypt1(buf);
    array.priceCriteria = getController.encrypt1(buf);
    array.targetPrice = getController.encrypt4(buf);
    array.volumeType = getController.encrypt1(buf);
    array.volumeCriteria = getController.encrypt1(buf);
    array.targetVol = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    array.orderstatus = getController.encrypt1(buf);
    array.orderDate = getController.encrypt4(buf);
    array.orderTime = getController.encrypt4(buf);
    array.sendDate = getController.encrypt4(buf);
    array.sendTime = getController.encrypt4(buf);
    array.startDate = getController.encrypt4(buf);
    array.dueDate = getController.encrypt4(buf);
    array.sourceId = getController.encrypt1(buf);
    array.withdrawsourceId = getController.encrypt1(buf);
    int inputuserL = getController.encrypt2(buf);
    array.inputUser = getController.getAsciiString(buf, inputuserL);
    int withdrawyBYL = getController.encrypt2(buf);
    array.withdrawBy = getController.getAsciiString(buf, withdrawyBYL);
    int descL = getController.encrypt2(buf);
    array.description = getController.getAsciiString(buf, descL);
    int clientIPadL = getController.encrypt2(buf);
    array.clinetIpAddress = getController.getAsciiString(buf, clientIPadL);
    int resL = getController.encrypt2(buf);
    array.resultNote = getController.getAsciiString(buf, resL);
    dataArray.add(array);
  }
  data.array = dataArray;
  listBreakorderList.clear();
  listBreakorderList.add(data);
  listBreakorderList.refresh();
  return data;
}
