import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/info/trading_limit.model.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

TradingLimit tradingLimitPKGorder(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int lRef = getController.encrypt2(buf);
  String ref = getController.getAsciiString(buf, lRef);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int lAccountname = getController.encrypt2(buf);
  String accountName = getController.getAsciiString(buf, lAccountname);
  int cCash = getController.encrypt8(buf);
  int rdnBal = getController.encrypt8(buf);
  int cashT3 = getController.getDouble8(buf);
  int cRatio = getController.getDouble(buf);
  int tLimit = getController.encrypt8(buf);
  int remainTlimit = getController.encrypt8(buf);

  TradingLimit listD = TradingLimit()
    ..loginId = loginID
    ..reference = ref
    ..accountId = accountId
    ..accountName = accountName
    ..currentCash = cCash
    ..rdnBalance = rdnBal
    ..cashonT3 = cashT3
    ..currentRatio =
        cRatio ~/ Get.find<LoginOrderController>().order!.value.lot!
    ..tradingLimit = tLimit
    ..remainTradingLimit = remainTlimit;
  Get.find<PinSave>().limit.value = listD;
  Get.find<PinSave>().limit.refresh();
  return listD;
}
