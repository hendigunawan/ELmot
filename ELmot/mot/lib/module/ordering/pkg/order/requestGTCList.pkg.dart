import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/requestGTCList.model.dart';

RxList<RequestGTCList> listGTC = <RequestGTCList>[].obs;
RequestGTCList requestGTCListPKG(Uint8List buf) {
  var data = RequestGTCList();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  int loginId = getController.encrypt2(buf);
  data.loginId = getController.getAsciiString(buf, loginId);
  int ref = getController.encrypt2(buf);
  data.reference = getController.getAsciiString(buf, ref);
  int accountId = getController.encrypt2(buf);
  data.accountId = getController.getAsciiString(buf, accountId);
  int array = getController.encrypt4(buf);
  List<RequestGTCArray> dataArray = [];
  for (var i = 0; i < array; i++) {
    RequestGTCArray array = RequestGTCArray();
    int gtcId = getController.encrypt2(buf);
    array.gtcId = getController.getAsciiString(buf, gtcId);
    array.subscribeDate = getController.encrypt4(buf);
    array.subscribeTime = getController.encrypt4(buf);
    array.effectiveDate = getController.encrypt4(buf);
    array.dueDate = getController.encrypt4(buf);
    array.sessionId = getController.encrypt1(buf);
    array.gtcFlags = getController.encrypt1(buf);
    int exchangeCode = getController.encrypt2(buf);
    array.exchangeCode = getController.getAsciiString(buf, exchangeCode);
    int market = getController.encrypt2(buf);
    array.marketCode = getController.getAsciiString(buf, market);
    array.expiry = getController.encrypt1(buf);
    array.command = getController.encrypt1(buf);
    int stockCode = getController.encrypt2(buf);
    array.stockCode = getController.getAsciiString(buf, stockCode);
    array.price = getController.encrypt4(buf);
    array.oVolume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    array.rVolume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    array.tVolume = getController.encrypt8(buf) ~/
        Get.find<LoginOrderController>().order!.value.lot;
    array.autoPriceStep = getController.encrypt4(buf);
    array.subscribeStatus = getController.encrypt1(buf);
    array.sourceId = getController.encrypt1(buf);
    array.cancelSourceId = getController.encrypt1(buf);
    int inputUser = getController.encrypt2(buf);
    array.inputUser = getController.getAsciiString(buf, inputUser);
    int cancelUser = getController.encrypt2(buf);
    array.cancelUser = getController.getAsciiString(buf, cancelUser);
    int complianceId = getController.encrypt2(buf);
    array.complianceId = getController.getAsciiString(buf, complianceId);
    dataArray.add(array);
  }
  data.array = dataArray;
  listGTC.clear();
  listGTC.add(data);
  listGTC.refresh();
  return data;
}
