import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/order/orderMassageReject.model.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

RejectedOrderMassageModel rejectedOrderMassagePkg(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  RejectedOrderMassageModel data = RejectedOrderMassageModel();

  int loginIdL = getController.encrypt2(buf);
  data.loginId = getController.getAsciiString(buf, loginIdL);
  int refL = getController.encrypt2(buf);
  data.reference = getController.getAsciiString(buf, refL);
  int accountL = getController.encrypt2(buf);
  data.accountId = getController.getAsciiString(buf, accountL);
  int orderidL = getController.encrypt2(buf);
  data.orderId = getController.getAsciiString(buf, orderidL);
  int massageL = getController.encrypt2(buf);
  data.rejectedMessage = getController.getAsciiString(buf, massageL);
  NotifikasiPopup.showINFO(text: data.rejectedMessage!);
  return data;
}
