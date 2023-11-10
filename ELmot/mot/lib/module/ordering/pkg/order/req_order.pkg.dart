import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/order/reqOrder.model.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';

ReqOrder reqOrderPkg(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int lRef = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, lRef);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);

  ReqOrder data = ReqOrder()
    ..loginId = loginID
    ..accountId = accountId
    ..reference = Ref;
  Get.find<Back>().backOrder.value = data;
  Get.find<Back>().backOrder.refresh();
  return data;
}
