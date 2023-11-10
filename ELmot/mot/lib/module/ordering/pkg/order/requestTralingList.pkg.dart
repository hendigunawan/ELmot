import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/requestTralingList.model.dart';

RxList<RequestTralingOrderModel> listTrailingOrder =
    <RequestTralingOrderModel>[].obs;
RequestTralingOrderModel requestTralingOrderListPKG(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  var data = RequestTralingOrderModel();

  int loginIdLen = getController.encrypt2(buf);
  data.loginId = getController.getAsciiString(buf, loginIdLen);
  int referenceLen = getController.encrypt2(buf);
  data.reference = getController.getAsciiString(buf, referenceLen);
  int custIdLen = getController.encrypt2(buf);
  data.custId = getController.getAsciiString(buf, custIdLen);
  int array = getController.encrypt4(buf);
  List<ArrayRequestTralingOrderModel> dataArray = [];
  for (var i = 0; i < array; i++) {
    var array = ArrayRequestTralingOrderModel();

    int orderIdLen = getController.encrypt2(buf);
    array.orderId = getController.getAsciiString(buf, orderIdLen);
    array.command = getController.encrypt1(buf);
    int marketCodeLen = getController.encrypt2(buf);
    array.marketCode = getController.getAsciiString(buf, marketCodeLen);
    int stockCodeLen = getController.encrypt2(buf);
    array.stockCode = getController.getAsciiString(buf, stockCodeLen);
    array.execPrice = getController.encrypt1(buf);
    array.volume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    array.autoPriceStep = getController.encrypt4(buf);
    array.dropPrice = getController.encrypt4(buf);
    array.trailingPriceType = getController.encrypt1(buf);
    array.trailingStep = getController.encrypt4(buf);
    array.stopPrice = getController.encrypt4(buf);
    array.trailingPrice = getController.encrypt4(buf);
    array.executedPrice = getController.encrypt4(buf);
    array.orderStatus = getController.encrypt1(buf);
    array.orderDate = getController.encrypt4(buf);
    array.orderTime = getController.encrypt4(buf);
    array.sentDate = getController.encrypt4(buf);
    array.sentTime = getController.encrypt4(buf);
    array.startDate = getController.encrypt4(buf);
    array.dueDate = getController.encrypt4(buf);
    array.sourceId = getController.encrypt1(buf);
    array.withdrawSrcId = getController.encrypt1(buf);
    int inputUserLen = getController.encrypt2(buf);
    array.inputUser = getController.getAsciiString(buf, inputUserLen);
    int withdrawByLen = getController.encrypt2(buf);
    array.withdrawBy = getController.getAsciiString(buf, withdrawByLen);
    int descriptionLen = getController.encrypt2(buf);
    array.description = getController.getAsciiString(buf, descriptionLen);
    int clientIPAddressLen = getController.encrypt2(buf);
    array.clientIpAddress =
        getController.getAsciiString(buf, clientIPAddressLen);
    int resultNoteLen = getController.encrypt2(buf);
    array.resultNote = getController.getAsciiString(buf, resultNoteLen);

    dataArray.add(array);
  }
  data.array = dataArray;
  listTrailingOrder.clear();
  listTrailingOrder.add(data);
  return data;
}
