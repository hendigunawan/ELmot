import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/realized_gainlos.model.dart';

RxList<RealizedGainLost> listRealizedGainlos = <RealizedGainLost>[].obs;
RealizedGainLost realizedPKGORDer(Uint8List buf) {
  List<ArrayRealizedGainLost> listD = [];
  listRealizedGainlos.clear();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginId = getController.getAsciiString(buf, lLogin);
  int Lref = getController.encrypt2(buf);
  String reference = getController.getAsciiString(buf, Lref);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int period = getController.encrypt4(buf);
  int arrayCount = getController.encrypt4(buf);
  for (int i = 0; i < arrayCount; i++) {
    int transactionDate = getController.encrypt4(buf);
    int command = getController.encrypt1(buf);
    int LStock = getController.encrypt2(buf);
    String stockCode = getController.getAsciiString(buf, LStock);
    int avgPrice = getController.encrypt8(buf);
    int price = getController.encrypt4(buf);
    int volume = getController.encrypt8(buf);
    int gainLossSign = getController.encrypt8(buf);
    int totalGainLossSign = getController.encrypt8(buf);

    listD.add(
      ArrayRealizedGainLost()
        ..transactionDate = transactionDate
        ..command = command
        ..stockCode = stockCode
        ..avgPrice = avgPrice
        ..price = price
        ..volume = volume
        ..gainLossSign = gainLossSign
        ..totalGainLossSign = totalGainLossSign,
    );
  }
  RealizedGainLost data = RealizedGainLost()
    ..loginId = loginId
    ..reference = reference
    ..accountId = accountId
    ..period = period
    ..array = listD;
  listRealizedGainlos.add(data);
  return data;
}
